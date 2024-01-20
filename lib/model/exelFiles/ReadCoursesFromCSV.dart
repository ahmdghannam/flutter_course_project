import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_project/model/Dto/AvailableSection.dart';

import '../Dto/CseCourse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("hi");
  List<AvailableSection> ll = await loadAvailableSections();
  print(ll.toString());
}

Future<List<AvailableSection>> loadAvailableSections() async {
  return _loadAvailableSections("assets/filtered_sections.csv");
}

Future<List<AvailableSection>> _loadAvailableSections(String path) async {
  List<List<dynamic>> _data = [];
  List<AvailableSection> sections = [];

  var result = await rootBundle.loadString(path);
  _data = const CsvToListConverter().convert(result, eol: "\n");

  // Remove header row
  if (_data.isNotEmpty) {
    _data.removeAt(0);
  }

  for (var d in _data) {
    try {
      sections.add(AvailableSection(
          code: d[1].toString(),
          name: d[2].toString(),
          sectionNumber: d[8].toString(),
          activity: d[7].toString(),
          time: d[11].toString(),
          hours: d[3].toString()));
    } catch (e) {
      print('Error parsing row: $d, Error: $e');
    }
  }
  return sections;
}

Future<List<CseCourse>> loadAllCseCourses() async {
  return _loadCseCourses("assets/courses.csv");
}

Future<List<CseCourse>> _loadCseCourses(String path) async {
  List<List<dynamic>> _data = [];
  List<CseCourse> courses = [];
  var result = await rootBundle.loadString(path);
  _data = const CsvToListConverter().convert(result, eol: "\n");

  // Remove header row
  if (_data.isNotEmpty) {
    _data.removeAt(0);
  }

  for (var d in _data) {
    try {
      courses.add(CseCourse(
        int.parse(d[0].toString()), // courseId
        d[1].toString(), // courseName
        int.parse(d[2].toString()), // defaultSemester
        int.parse(d[3].toString()), // creditHours
        int.parse(d[4].toString()), // preRequisitesCourses
      ));
    } catch (e) {
      print('Error parsing row: $d, Error: $e');
    }
  }
  // print(courses.map((e) => "Course ID: ${e.courseId}, Name: ${e.courseName}, Semester: ${e.defaultSemester}, Credit Hours: ${e.creditHours}, Prerequisites: ${e.preRequisitesCourses} \n").toList());
  return courses;
}


