import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrientationLockedTableScreen(),
    );
  }
}

class OrientationLockedTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lock screen orientation to landscape mode
    RotateMobile();
    return Scaffold(
      appBar: AppBar(
        title: Text("Landscape Table"),
      ),
      body: buildTable(),
    );
  }

  void RotateMobile() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Widget buildTable() {
    // Replace this with your actual table implementation
    return DataTable(
      columns: [
        DataColumn(label: Text('Column 1')),
        DataColumn(label: Text('Column 2')),
        DataColumn(label: Text('Column 3')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('Row 1, Cell 1')),
          DataCell(Text('Row 1, Cell 2')),
          DataCell(Text('Row 1, Cell 3')),
        ]),
        DataRow(cells: [
          DataCell(Text('Row 2, Cell 1')),
          DataCell(Text('Row 2, Cell 2')),
          DataCell(Text('Row 2, Cell 3')),
        ]),
      ],
    );
  }
}
