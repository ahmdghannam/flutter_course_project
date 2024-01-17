import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_course_project/model/exelFiles/ReadCoursesFromCSV.dart';

import '../model/Dto/Course.dart';

void main() {
  runApp(GeneratedTableDisplay());
}

class GeneratedTableDisplay extends StatefulWidget {
  const GeneratedTableDisplay({super.key});

  @override
  State<GeneratedTableDisplay> createState() => _GeneratedTableDisplayState();
}

class _GeneratedTableDisplayState extends State<GeneratedTableDisplay> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    try {
      List<Course> fetchedCourses = await getAvailableSections();
      print(fetchedCourses.toString());
      setState(() {
        courses = fetchedCourses.sublist(0, 10);
      });
    } catch (error) {
      print("Error loading courses: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    RotateMobile();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(),
            body: Container(
              alignment: Alignment.topCenter,
              child: courses.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(child: CoursesTable()),
            )));
  }

  void RotateMobile() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  Widget CoursesTable() {
    return DataTable(
        border: TableBorder.all(color: Colors.black54),
        columns: columnsHeaders(),
        rows: courses.map((c) => CustomDataRow(c)).toList());
  }

  List<DataColumn> columnsHeaders() {
    return [
      CustomColumnHeader("course\n code"),
      CustomColumnHeader("course\n name"),
      CustomColumnHeader("section"),
      CustomColumnHeader("Activity"),
      CustomColumnHeader("Time"),
      CustomColumnHeader("hours"),
    ];
  }

  DataColumn CustomColumnHeader(String text) {
    return DataColumn(
        label: Expanded(
            child: Text(
      text,
      overflow: TextOverflow.fade,
    )));
  }

  DataRow CustomDataRow(Course course) {
    return DataRow(cells: [
      CustomDataCell(course.code),
      CustomDataCell(course.name),
      CustomDataCell(course.sectionNumber),
      CustomDataCell(course.activity),
      CustomDataCell(course.time),
      CustomDataCell(course.hours),
    ]);
  }

  DataCell CustomDataCell(String text) {
    return DataCell(
      Expanded(
        child: Text(
          text,
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Text(
            "Suggested Schedule",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "total hours 13",
            style: TextStyle(fontSize: 12, color: Color(0xFF842700)),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}

List<Course> testCourses() {
  return [
    Course('12412', 'Computer Science 101', 'CS101-01', 'Lecture', '9:00 AM',
        '3 hours'),
    Course('123456789', 'Mathematics 201', 'MATH201-02', 'Lab', '1:30 PM',
        '2 hours'),
    Course('987654321', 'History 110', 'HIST110-01', 'Discussion', '11:00 AM',
        '1.5 hours'),
    Course('567890123', 'Physics 301', 'PHYS301-03', 'Lecture', '10:00 AM',
        '3 hours'),
    Course('456789012', 'English 202', 'ENGL202-04', 'Seminar', '2:30 PM',
        '2 hours'),
    Course('654321098', 'Chemistry 202', 'CHEM202-01', 'Lab', '3:30 PM',
        '2 hours'),
    Course('234567890', 'Psychology 110', 'PSYCH110-02', 'Discussion',
        '12:30 PM', '1.5 hours'),
    Course('890123456', 'Biology 204', 'BIOL204-05', 'Lecture', '8:30 AM',
        '3 hours'),
    Course('123098765', 'Economics 301', 'ECON301-03', 'Seminar', '4:00 PM',
        '2 hours'),
    Course('567801234', 'Art History 150', 'ARTH150-02', 'Lab', '2:00 PM',
        '2 hours'),
    Course('345678901', 'Sociology 210', 'SOC210-01', 'Discussion', '10:30 AM',
        '1.5 hours'),
    Course('678901234', 'Political Science 220', 'POLSCI220-04', 'Lecture',
        '11:30 AM', '3 hours'),
    Course(
        '901234567', 'Spanish 101', 'SPAN101-03', 'Lab', '3:00 PM', '2 hours'),
    Course('234567890', 'Music 130', 'MUSIC130-02', 'Seminar', '1:00 PM',
        '2 hours'),
    Course('890123456', 'Physical Education 102', 'PE102-01', 'Discussion',
        '12:00 PM', '1.5 hours'),
    Course('123456789', 'Geology 205', 'GEOL205-06', 'Lecture', '9:30 AM',
        '3 hours'),
    Course('456789012', 'Philosophy 210', 'PHIL210-04', 'Lab', '4:30 PM',
        '2 hours'),
    Course('654321098', 'Statistics 301', 'STAT301-02', 'Discussion', '2:30 PM',
        '1.5 hours'),
    Course('234567890', 'Engineering 202', 'ENGR202-03', 'Seminar', '10:30 AM',
        '2 hours'),
  ];
}
