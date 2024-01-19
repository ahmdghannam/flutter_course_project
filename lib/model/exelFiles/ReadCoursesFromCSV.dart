import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Course {
  int courseId;
  String courseName;
  int defaultSemester;
  int creditHours;
  int preRequisitesCourses;

  Course(this.courseId, this.courseName, this.defaultSemester, this.creditHours, this.preRequisitesCourses);
}
void main() => runApp(App());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  List<Course> courses = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Courses'),
        ),
        body: Text('Get Courses'),),
    );
  }

  Widget buildListView() {
    if (courses.isEmpty) {
      return Column(
        children: [Text('No data found!!')],
      );
    }

    return Column(
      children: courses
          .map(
            (e) => ListTile(
          title: Text(
            "Course ID: ${e.courseId}, Name: ${e.courseName}, Semester: ${e.defaultSemester}, Credit Hours: ${e.creditHours}, Prerequisites: ${e.preRequisitesCourses}",
          ),
        ),
      )
          .toList(),
    );
  }
}

Future<List<Course>> _loadCSV() async {
  String filePath = "courses.csv"; // default
  List<List<dynamic>> _data = [];
  List<Course> courses = [];
  var result = await rootBundle.loadString(filePath);
  _data = const CsvToListConverter().convert(result, eol: "\n");

  // Remove header row
  if (_data.isNotEmpty) {
    _data.removeAt(0);
  }

  for (var d in _data) {
    try {
      courses.add(Course(
        int.parse(d[0].toString()),        // courseId
        d[1].toString(),                  // courseName
        int.parse(d[2].toString()),        // defaultSemester
        int.parse(d[3].toString()),        // creditHours
        int.parse(d[4].toString()),        // preRequisitesCourses
      ));
    } catch (e) {
      print('Error parsing row: $d, Error: $e');
    }
  }
  // print(courses.map((e) => "Course ID: ${e.courseId}, Name: ${e.courseName}, Semester: ${e.defaultSemester}, Credit Hours: ${e.creditHours}, Prerequisites: ${e.preRequisitesCourses} \n").toList());
  return courses;
}