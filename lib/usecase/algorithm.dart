import 'package:flutter/cupertino.dart';
import 'package:flutter_course_project/model/Dto/CseCourse.dart';
import 'package:flutter_course_project/model/Dto/UICourse.dart';
import 'package:flutter_course_project/model/exelFiles/ReadCoursesFromCSV.dart';

import '../model/Dto/AvailableSection.dart';
import '../model/Dto/FirebaseCoure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getSuggestedCourses();
}

Future<List<AvailableSection>> getSuggestedCourses() async {
  List<AvailableSection>? availableSections = await loadAvailableSections();

  List<CseCourse>? cseCourses = await loadAllCseCourses();

  List<FirebaseCourse> notFinishedCourses = getPassedCoursesFromFirebase()
      .where((element) => !element.isPassed)
      .toList();

  return generateSuggestionList(
      cseCourses, availableSections, notFinishedCourses);
}

List<AvailableSection> generateSuggestionList(
    List<CseCourse>? cseCourses,
    List<AvailableSection>? availableSections,
    List<FirebaseCourse> notFinishedCourses) {
  List<CseCourse> neededCourses =
      getNeededCourses(cseCourses, notFinishedCourses);
  sortTheSections(neededCourses, 6);
  List<UICourse> tableToBeDisplayed = [];
  neededCourses.forEach((element) {
    addIfCanAdd(tableToBeDisplayed,availableSections,element);
  });
  return [];
}

bool addIfCanAdd(List<UICourse> tableToBeDisplayed, List<AvailableSection>? availableSections, CseCourse element) {
  if(availableSections == null) return false;
  AvailableSection chosenItem = availableSections.firstWhere((av) => av.code==element.courseId);
  if(noTimeConflict(tableToBeDisplayed,chosenItem)){
    tableToBeDisplayed.add(
        UICourse(chosenItem.code, chosenItem.name, chosenItem.sectionNumber, chosenItem.activity, chosenItem.time, chosenItem.hours)
    );
  }
  return false;
}

bool noTimeConflict(List<UICourse> tableToBeDisplayed, AvailableSection chosenItem) {

  for(var i in tableToBeDisplayed){
    if(isOverlap(chosenItem.time,i.time)){
      return false;
    }
  }
  return true;
}

bool isOverlap(String time, String time2) {
  if(time == time2) return true;
  

  return false;
}

List<CseCourse> getNeededCourses(
    List<CseCourse>? cseCourses, List<FirebaseCourse> notFinishedCourses) {
  if (cseCourses == null) return [];
  return cseCourses
      .where((cseCourse) => notFinishedCourses.any((notFininshed) =>
          notFininshed.code.trim() == cseCourse.courseId.trim()))
      .toList();
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

List<FirebaseCourse> getPassedCoursesFromFirebase() {
  return [
    FirebaseCourse('10610035', false), // advanced english
    FirebaseCourse('230112120', false), //  ELECTRICAL CIRCUITS I
    FirebaseCourse('240112030', false), //  DATA STRUCTURES
    FirebaseCourse('230112240', false), //  SIGNALS AND SYSTEMS
    FirebaseCourse('100413020', false), //  ENGINEERING MATHEMATICS II
    FirebaseCourse('230213150', false), // ALGORITHMS ANALYSIS AND DESIGN
    FirebaseCourse('100411010', false), // calculus 1
  ];
}
