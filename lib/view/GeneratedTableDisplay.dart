import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  List<Course> courses =  testCourses();

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
              child: SingleChildScrollView(child: CoursesTable())),
        ));
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
      CustomColumnHeader("course\n name"),
      CustomColumnHeader("section"),
      CustomColumnHeader("Activity"),
      CustomColumnHeader("Time"),
      CustomColumnHeader("hours"),
      CustomColumnHeader("incstructor"),
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
      CustomDataCell(course.name),
      CustomDataCell(course.sectionNumber),
      CustomDataCell(course.activity),
      CustomDataCell(course.time),
      CustomDataCell(course.hours),
      CustomDataCell(course.instructor),
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
    Course('Computer Science 101', 'CS101-01', 'Lecture', '9:00 AM', '3 hours',
        'Dr. Smith'),
    Course('Mathematics 201', 'MATH201-02', 'Lab', '1:30 PM', '2 hours',
        'Prof. Johnson'),
    Course('History 110', 'HIST110-01', 'Discussion', '11:00 AM', '1.5 hours',
        'Dr. Davis'),
    Course('Physics 301', 'PHYS301-03', 'Lecture', '10:00 AM', '3 hours',
        'Prof. White'),
    Course('English 202', 'ENGL202-04', 'Seminar', '2:30 PM', '2 hours',
        'Dr. Turner'),
    Course('Chemistry 202', 'CHEM202-01', 'Lab', '3:30 PM', '2 hours',
        'Dr. Brown'),
    Course('Psychology 110', 'PSYCH110-02', 'Discussion', '12:30 PM',
        '1.5 hours', 'Prof. Wilson'),
    Course('Biology 204', 'BIOL204-05', 'Lecture', '8:30 AM', '3 hours',
        'Dr. Martinez'),
    Course('Economics 301', 'ECON301-03', 'Seminar', '4:00 PM', '2 hours',
        'Prof. Adams'),
    Course('Art History 150', 'ARTH150-02', 'Lab', '2:00 PM', '2 hours',
        'Dr. Taylor'),
    Course('Sociology 210', 'SOC210-01', 'Discussion', '10:30 AM', '1.5 hours',
        'Prof. Walker'),
    Course('Political Science 220', 'POLSCI220-04', 'Lecture', '11:30 AM',
        '3 hours', 'Dr. Harris'),
    Course('Spanish 101', 'SPAN101-03', 'Lab', '3:00 PM', '2 hours',
        'Prof. Rodriguez'),
    Course('Music 130', 'MUSIC130-02', 'Seminar', '1:00 PM', '2 hours',
        'Dr. Miller'),
    Course('Physical Education 102', 'PE102-01', 'Discussion', '12:00 PM',
        '1.5 hours', 'Prof. Clark'),
    Course('Geology 205', 'GEOL205-06', 'Lecture', '9:30 AM', '3 hours',
        'Dr. Allen'),
    Course('Philosophy 210', 'PHIL210-04', 'Lab', '4:30 PM', '2 hours',
        'Dr. Carter'),
    Course('Statistics 301', 'STAT301-02', 'Discussion', '2:30 PM', '1.5 hours',
        'Prof. Lee'),
    Course('Engineering 202', 'ENGR202-03', 'Seminar', '10:30 AM', '2 hours',
        'Dr. Thompson'),
  ];
}
