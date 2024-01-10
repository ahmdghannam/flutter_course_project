import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back),
              const Text(
                "Suggested Schedule",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "total hours 13",
                style: TextStyle(fontSize: 12,color: Color(0xFF842700)),
              ),
            ],
          ),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(child: const GeneratedTableDisplay()),
      )));
}

class GeneratedTableDisplay extends StatefulWidget {
  const GeneratedTableDisplay({super.key});

  @override
  State<GeneratedTableDisplay> createState() => _GeneratedTableDisplayState();
}

class _GeneratedTableDisplayState extends State<GeneratedTableDisplay> {
  @override
  Widget build(BuildContext context) {
    RotateMobile();
    return CoursesTable();
  }

  void RotateMobile() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Widget CoursesTable() {
    return DataTable(border: TableBorder.all(color: Colors.black54), columns: [
      CustomColumnHeader("course\n name"),
      CustomColumnHeader("section"),
      CustomColumnHeader("Activity"),
      CustomColumnHeader("Time"),
      CustomColumnHeader("hours"),
      CustomColumnHeader("incstructor"),
    ], rows: [
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
      testDataRow(),
    ]);
  }

  DataColumn CustomColumnHeader(String text) {
    return DataColumn(
        label: Expanded(
            child: Text(
     text,
      overflow: TextOverflow.fade,
    )));
  }

  DataRow testDataRow() {
    return DataRow(cells: [
      CustomDataCell("calculas"),
      CustomDataCell("2"),
      CustomDataCell("course"),
      CustomDataCell("8:30-9:45"),
      CustomDataCell("3"),
      CustomDataCell("dr.abd alhaleem zeqan"),
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
}
