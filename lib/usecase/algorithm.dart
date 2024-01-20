import 'package:flutter/cupertino.dart';
import 'package:flutter_course_project/model/exelFiles/ReadCoursesFromCSV.dart';

import '../model/Dto/AvailableSection.dart';
import '../model/Dto/FirebaseCoure.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getSuggestedCourses();
}

Future<List<AvailableSection>> getSuggestedCourses() async {
  List<AvailableSection>? availableSections = await loadAvailableSections();
  List<FirebaseCourse> notFinishedCourses = getPassedCoursesFromFirebase()
      .where((element) => !element.isPassed)
      .toList();

  return generateSuggestionList(availableSections, notFinishedCourses);
}

List<AvailableSection> generateSuggestionList(
    List<AvailableSection>? availableSections,
    List<FirebaseCourse> notFinishedCourses) {
  List<AvailableSection> neededSections = getNeededSectionJoin(
      availableSections, notFinishedCourses);
  print(neededSections);
  return [];
}

List<AvailableSection> getNeededSectionJoin(
    List<AvailableSection>? availableSections,
    List<FirebaseCourse> notFinishedCourses) {
  if (availableSections == null) {
    print("list is null");
    return [];
  }
  return availableSections
      .where((availableSection) =>
      notFinishedCourses
          .any((course) => course.code.trim() == availableSection.code.trim()))
      .toList();
}

List<FirebaseCourse> getPassedCoursesFromFirebase() {
  return [
    FirebaseCourse('10610035', false), // advanced english
    FirebaseCourse('110712120', false), // advanced ELECTRICAL CIRCUITS I
    FirebaseCourse('240112031', true), // advanced DATA STRUCTURES
    FirebaseCourse('110712240', true), // advanced SIGNALS AND SYSTEMS
    FirebaseCourse('100413020', false), // advanced ENGINEERING MATHEMATICS II
    FirebaseCourse('230213151', true), // ALGORITHMS ANALYSIS AND DESIGN
  ];
}
