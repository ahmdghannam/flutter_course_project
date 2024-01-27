import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_course_project/model/Dto/CseCourse.dart';
import 'package:flutter_course_project/model/Dto/UICourse.dart';
import 'package:flutter_course_project/model/exelFiles/ReadCoursesFromCSV.dart';
import 'package:flutter_course_project/model/localDatabase/sharedPrefferences.dart';

import '../model/Dto/AvailableSection.dart';
import '../model/Dto/FirebaseCoure.dart';
import '../model/Dto/LectureTime.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<UICourse> ss= await getSuggestedCourses("2");
  print(ss);
}

Future<List<UICourse>> getSuggestedCourses(String chosenSemester) async {

  List<AvailableSection>? availableSections = await loadAvailableSections();

  List<CseCourse>? cseCourses = await loadAllCseCourses();

  String? userId= await getUserID();
  if(userId==null) {
    return throw "user id not found";
  }
  List<FirebaseCourse> notFinishedCourses = await getFalseStatusCourses(userId);
  return generateSuggestionList(
      cseCourses, availableSections, notFinishedCourses,chosenSemester
  );
}

List<UICourse> generateSuggestionList(
    List<CseCourse>? cseCourses,
    List<AvailableSection>? availableSections,
    List<FirebaseCourse> notFinishedCourses,
    String chosenSemester
    ) {

  List<CseCourse> neededCourses =
      getNeededCourses(cseCourses, notFinishedCourses); //join

  sortTheSections(neededCourses, int.parse(chosenSemester));

  List<UICourse> tableToBeDisplayed = [];
  for (var element in neededCourses) {
    // print(element);
    addIfCanAdd(tableToBeDisplayed,availableSections,element);
  }
  return tableToBeDisplayed;
}

bool addIfCanAdd(List<UICourse> tableToBeDisplayed, List<AvailableSection>? availableSections, CseCourse element) {

  if(availableSections == null) return false;

  AvailableSection? chosenItem;
  try {
    chosenItem = availableSections.firstWhere((av) => av.code == element.courseId);
  } catch (e) {
    return false;
  }

  if(noTimeConflict(tableToBeDisplayed,chosenItem)){
    tableToBeDisplayed.add(
        UICourse(chosenItem.code, chosenItem.name, chosenItem.sectionNumber, chosenItem.activity, chosenItem.time, chosenItem.hours)
    );
  }

  return false;
}

bool noTimeConflict(List<UICourse> tableToBeDisplayed, AvailableSection chosenItem) {

  for(var i in tableToBeDisplayed){
    if(isThereAConflict(chosenItem.time,i.time)){
      return false;
    }
  }

  return true;

}
//[13:30-14:20 DAR B109 Sunday Tuesday Thursday]
bool isThereAConflict(String time, String time2) {
  if(time == time2) return true;
  var time1asList= time.substring(1,time.length-1).split(' ');
  var time2asList= time2.substring(1,time2.length-1).split(' ');

  if(!isTheSameDay(time1asList, time2asList)) return false;

  LectureTime lecture1 = parseLectureTimeString(time1asList[0]);
  LectureTime lecture2 = parseLectureTimeString(time2asList[0]);

  return lecture1.isOverlapedWith(lecture2);
}

// 13:30-14:20
LectureTime parseLectureTimeString(String timeString) {

  List<String> parts = timeString.split('-');
  String startTime = parts[0]; //13:30
  // You can add more error checking here if needed
  List<String> startTimeParts = startTime.split(':');
  int hourForStartingTime = int.parse(startTimeParts[0]);//13
  int minuteForStartingTime = int.parse(startTimeParts[1]);//30

  String endingTime = parts[1];//14:20
  // You can add more error checking here if needed
  List<String> endTimeParts = endingTime.split(':');
  int hourForEndingTime = int.parse(endTimeParts[0]);//14
  int minuteForEndingTime = int.parse(endTimeParts[1]);//20


  return LectureTime(
      starting: DateTime(2022, 1, 1, hourForStartingTime, minuteForStartingTime),
      ending: DateTime(2022, 1, 1, hourForEndingTime, minuteForEndingTime)
  );


}

bool isTheSameDay(List<String> tl,List<String> tl2){
  bool sameDay = false;
  for (int i = tl.length - 1; i >= 0; i--) {
    if(!tl[i].endsWith("day")) break;
    if(tl2.contains(tl[i])){
      sameDay=true;
      break;
    }
  }
  return sameDay;
}

List<CseCourse> getNeededCourses(
    List<CseCourse>? cseCourses, List<FirebaseCourse> notFinishedCourses) {

  if (cseCourses == null) return [];

  return cseCourses
      .where((cseCourse) => notFinishedCourses.any((notFininshed) =>
          notFininshed.code.trim() == cseCourse.courseId.trim()))
      .toList(); // join
}

void sortTheSections(List<CseCourse> neededSections, int currentSemester) {
  neededSections.sort((a, b) => b
      .evaluateTheWeight(currentSemester)
      .compareTo(a.evaluateTheWeight(currentSemester)));
}

List<AvailableSection> getNeededSectionJoin(
    List<AvailableSection>? availableSections,
    List<FirebaseCourse> notFinishedCourses) {
  if (availableSections == null) {
    print("list is null");
    return [];
  }
  return availableSections
      .where((availableSection) => notFinishedCourses
          .any((course) => course.code.trim() == availableSection.code.trim()))
      .toList();
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
