import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_course_project/model/Dto/CseCourse.dart';
import 'package:flutter_course_project/model/Dto/UICourse.dart';
import 'package:flutter_course_project/model/exelFiles/ReadCoursesFromCSV.dart';
import 'package:flutter_course_project/model/localDatabase/sharedPrefferences.dart';
import 'package:flutter/material.dart';

import '../model/Dto/Section.dart';
import '../model/Dto/FirebaseCourse.dart';
// import '../model/Dto/LectureTime.dart';

extension TimeOfDayExtension on TimeOfDay {
  int compareTo(TimeOfDay other) {
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }
  String toStringConvert() {
    String addLeadingZeroIfNeeded(int value) {
      if (value < 10) {
        return '0$value';
      }
      return value.toString();
    }

    final String hourLabel = addLeadingZeroIfNeeded(hour);
    final String minuteLabel = addLeadingZeroIfNeeded(minute);

    return '$hourLabel:$minuteLabel';
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<UICourse> ss = await getSuggestedCourses("2");
  print(ss);
}

Future<List<FirebaseCourse>> getFalseStatusCourses(String studentId) async {
  List<FirebaseCourse> falseStatusCourses = [];

  try {
    // Retrieve the student document from the 'student-course' collection
    DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
        .collection('student-course')
        .doc(studentId)
        .get();

    if (studentSnapshot.exists) {
      // Get the 'courses' map from the student document
      Map<String, dynamic> coursesMap = studentSnapshot['courses'];

      // Iterate through the coursesMap and check for false status
      coursesMap.forEach((code, isPassed) {
        if (isPassed == false) {
          falseStatusCourses.add(FirebaseCourse(code, isPassed));
        }
      });
    }
  } catch (e) {
    print('Error retrieving false status courses: $e');
  }

  return falseStatusCourses;
}
List<CseCourse> getNeededCourses(List<CseCourse>? cseCourses, List<FirebaseCourse> notFinishedCourses) {
  if (cseCourses == null) return [];

  return cseCourses
      .where((cseCourse) => notFinishedCourses.any((notFininshed) =>
  notFininshed.code.trim() == cseCourse.courseId.trim()))
      .toList(); // join
}
List<CseCourse> sortCourses(List<CseCourse> courses) {
  // Sort courses based on the calculated weight
  courses.sort((a, b) {
    int weightA = calculateCourseWeight(a);
    int weightB = calculateCourseWeight(b);

    // Sort in reverse order (big to small weight)
    return weightA.compareTo(weightB);
  });

  return courses;
}
int calculateCourseWeight(CseCourse course) {
  // Function to calculate the weight for each course based on default semester and prerequisites
  // Adjust the formula based on your specific weighting criteria
  return course.defaultSemester + course.childrenCount;
}

Future<List<UICourse>> getSuggestedCourses(String chosenSemester) async {
  // The University Schedule sections,
  List<Section>? sections = await loadAvailableSections();

  // The Major Courses with it's details
  List<CseCourse>? cseCourses = await loadAllCseCourses();

  // Get the needed courses ( the allowed courses to be registered (not finished yet) )
  String? userId = await getUserID();
  if (userId == null) {
    return throw "user id not found";
  }
  List<FirebaseCourse> notFinishedCourses = await getFalseStatusCourses(userId);
  List<CseCourse> neededCourses =
  getNeededCourses(cseCourses, notFinishedCourses); //join
  neededCourses = sortCourses(neededCourses);
  print("neededCourses $neededCourses");
  // Default parameters to be taken from the user later
  int desiredCreditHours = 15;
  TimeOfDay startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 16, minute: 0);

  // The Table to be Displayed for the user
  List<UICourse> tableToBeDisplayed = [];

  // Attempt to generate a schedule using the provided inputs
  if (generateSchedule(neededCourses, sections, tableToBeDisplayed, 0, desiredCreditHours, startTime, endTime)) {
    // Print the successfully generated schedule
    print("Schedule generated successfully:");
  } else {
    // Print a message indicating failure to generate a suitable schedule
    print("Failed to generate schedule.");
  }
  return tableToBeDisplayed;
}

bool generateSchedule(
    List<CseCourse> neededCourses,
    List<Section> sections,
    List<UICourse> tableToBeDisplayed,
    int currentIndex,
    int desiredCreditHours,
    TimeOfDay startTime,
    TimeOfDay endTime ) {

  // Base case: successfully scheduled all desired credit hours or reached the end of the course list
  if (currentIndex == neededCourses.length || desiredCreditHours <= 0) {
    return true; // Successfully scheduled all desired credit hours
  }

  // for (var course in neededCourses) {
  //   addIfCanAdd(tableToBeDisplayed, sections, course);
  // }
  // Get the current course
  CseCourse currentCourse = neededCourses[currentIndex]; // most important one, now
  print("currentCourse $currentCourse");
  print("startTime $startTime , endTime $endTime");
  print("first- getOpenSections ${getOpenSections(sections, currentCourse, startTime, endTime)[0]}");
  // Iterate through open sections of the current course within the specified time range
  for (Section section in getOpenSections(sections, currentCourse, startTime, endTime)) {
    // Check if the section conflicts with the existing schedule
    if (!hasConflict(tableToBeDisplayed, section)) {
      print("not has conflict between table and section");// Add the section to the schedule
      tableToBeDisplayed.add(
          UICourse(
              section.courseId.toString(),
              currentCourse.courseName,
              section.sectionId.toString(),
              section.status.toString(), // should be changed to activity (the change in the section class)
              section.time.toString(),
              currentCourse.creditHours.toString())
      );

      print("going to the next course 167");// Recursively attempt to schedule the remaining courses
      if (generateSchedule(
          neededCourses, sections, tableToBeDisplayed, currentIndex + 1, desiredCreditHours - currentCourse.creditHours, startTime, endTime)) {
        return true; // Move to the next course
      }

      print("remove the last added section 173"); // Backtrack by removing the last added section if scheduling failed
      tableToBeDisplayed.removeLast();
    }
  }
  // Could not find a suitable section for the current course
  return false;
}

bool hasConflict(List<UICourse> tableToBeDisplayed, Section newSection) {
  if (tableToBeDisplayed == []){
    print("tableToBeDisplayed == [] 183");
    return false;}
  print("fn- has conflict 185");

  print("tableToBeDisplayed $tableToBeDisplayed");

  for (UICourse section in tableToBeDisplayed) {
    print('section loop $section');
    if (doSectionsConflict(Section(
        int.parse(section.sectionNumber),
        int.parse(section.code),
        false,
        section.time
    ), newSection)) {
      print('section conflict 197 $section, $newSection');
      return true;
    }
  }
  return false;
}


List<Section> getOpenSections(List<Section> sections, CseCourse course, TimeOfDay startTime, TimeOfDay endTime) {
  return sections
      .where((section) =>
              section.courseId == int.parse(course.courseId)
              && !section.status // The ! should be removed
              // && doSectionsConflict(section, Section(0,0,false,'[${startTime.toStringConvert()}-${endTime.toStringConvert()}]'))
              // The below is not valid
              // && section.startTime.compareTo(startTime)==-1 &&
              // section.endTime.compareTo(endTime)==1
            ).toList();
}

// You can add more error checking here if needed
// timeString = "13:30-14:20"
List<TimeOfDay> parseLectureTimeString(String timeString) {
  List<String> parts = timeString.split('-'); // parts = ["13:30","14:20"]

  List<String> startTimeParts = parts[0].split(':'); // startTimeParts = ["13","30"]
  TimeOfDay startTime = TimeOfDay(hour: int.parse(startTimeParts[0]), minute: int.parse(startTimeParts[1]));

  List<String> endTimeParts = parts[1].split(':'); // endTimeParts = ["14","20"]
  TimeOfDay endTime = TimeOfDay(hour: int.parse(endTimeParts[0]), minute: int.parse(endTimeParts[1]));

  return [startTime,endTime];
}

//[13:30-14:20 DAR B109 Sunday Tuesday Thursday]
bool isThereAConflict(String time, String time2) {
  if (time == time2) return true;
  var time1asList = time.substring(1, time.length - 1).split(' ');
  var time2asList = time2.substring(1, time2.length - 1).split(' ');
  // if (!isTheSameDay(time1asList, time2asList)) return false;

  List<TimeOfDay> L1_time = parseLectureTimeString(time1asList[0]);
  TimeOfDay L1_startTime = L1_time[0];
  TimeOfDay L1_endTime = L1_time[1];

  List<TimeOfDay> L2_time = parseLectureTimeString(time2asList[0]);
  TimeOfDay L2_startTime = L2_time[0];
  TimeOfDay L2_endTime = L2_time[1];
  // v1 : if (L1_startTime.compareTo(L2_startTime)==-1 && L1_endTime.compareTo(L2_endTime)==1)
  // v2 : if (L1_endTime.compareTo(L2_startTime)==-1 || L2_endTime.compareTo(L1_startTime)==-1)
  if ((L1_startTime.compareTo(L2_startTime)==-1 && L1_endTime.compareTo(L2_startTime)==-1)
      || (L2_startTime.compareTo(L1_startTime)==-1 && L2_endTime.compareTo(L1_startTime)==-1))
    return false;
  else
    return true;
}


// Function to check if two sections have conflicting days and time overlap
// may have problems, due to day/time
bool doSectionsConflict(Section section1, Section section2) {
  print("doSectionsConflict 255: ${section1.toString()} && ${section2.toString()}");
  // Take the days from the section 1 time
  List<String> section1List = section1.time.substring(1, section1.time.length - 1).split(' ');
  List<String> section1Days = [];
  for (int i = section1List.length - 1; i >= 0; i--) {
    if (section1List[i].endsWith("day")) {
      section1Days.add(section1List[i]);
    }
  }
  // Take the days from the section 2 time
  List<String> section2List = section2.time.substring(1, section2.time.length - 1).split(' ');
  List<String> section2Days = [];
  for (int i = section2List.length - 1; i >= 0; i--) {
    if (section2List[i].endsWith("day")) {
      section2Days.add(section2List[i]);
    }
  }
  // Check conflict
  if (section1Days.any((day) => section2Days.contains(day))) {
    if (isThereAConflict(section1.time,section2.time)) {
      return true;
    }
  }
  return false; // No conflict
}

// bool addIfCanAdd(List<UICourse> tableToBeDisplayed, List<Section>? sections,CseCourse course) {
//   if (sections == null) return false;
//
//   Section? section;
//   try {
//     section = sections.firstWhere((section) => section.courseId == course.courseId);
//   } catch (e) {
//     return false;
//   }
//
//   if (noTimeConflict(tableToBeDisplayed, section)) {
//     tableToBeDisplayed.add(UICourse(
//         section.courseId.toString(),
//         course.courseName,
//         section.sectionId.toString(),
//         section.status.toString(), // should be changed to activity (the change in the section class)
//         section.startTime.toString()+", "+section.endTime.toString(),
//         course.creditHours.toString()));
//   }
//
//   return false;
// }

// bool noTimeConflict(List<UICourse> tableToBeDisplayed, Section chosenItem) {
//   for (var i in tableToBeDisplayed) {
//     if (isThereAConflict(chosenItem.time, i.time)) {
//       return false;
//     }
//   }
//
//   return true;
// }

// void sortTheSections(List<CseCourse> neededSections, int currentSemester) {
//   neededSections.sort((a, b) => b
//       .evaluateTheWeight(currentSemester)
//       .compareTo(a.evaluateTheWeight(currentSemester)));
// }

// Function to get a list of courses sorted based on a weighted criterion




List<Section> getNeededSectionJoin(
    List<Section>? sections, List<FirebaseCourse> notFinishedCourses) {
  if (sections == null) {
    print("list is null");
    return [];
  }
  return sections
      .where((section) => notFinishedCourses
          .any((course) => course.code.trim() == section.courseId.toString().trim()))
      .toList();
}



// List<FirebaseCourse> getPassedCoursesFromFirebase() {
//   return [
//     FirebaseCourse('10610035', false), // advanced english
//     FirebaseCourse('230112120', false), //  ELECTRICAL CIRCUITS I
//     FirebaseCourse('240112030', false), //  DATA STRUCTURES
//     FirebaseCourse('230112240', false), //  SIGNALS AND SYSTEMS
//     FirebaseCourse('100413020', false), //  ENGINEERING MATHEMATICS II
//     FirebaseCourse('230213150', false), // ALGORITHMS ANALYSIS AND DESIGN
//     FirebaseCourse('100411010', false), // calculus 1
//   ];
// }
// Future<List<FirebaseCourse>> getFalseStatusCourses(String studentId) async {
//   List<FirebaseCourse> falseStatusCourses = [];
//
//   try {
//     // Retrieve the student document from the 'student-course' collection
//     DocumentSnapshot studentSnapshot = await FirebaseFirestore.instance
//         .collection('student-course')
//         .doc(studentId)
//         .get();
//
//     if (studentSnapshot.exists) {
//       // Get the 'courses' map from the student document
//       Map<String, dynamic> coursesMap = studentSnapshot['courses'];
//
//       // Iterate through the coursesMap and check for false status
//       coursesMap.forEach((code, isPassed) {
//         if (isPassed == false) {
//           falseStatusCourses.add(FirebaseCourse(code, isPassed));
//         }
//       });
//
//     }
//   } catch (e) {
//     print('Error retrieving false status courses: $e');
//   }
//
//   return falseStatusCourses;
// }
