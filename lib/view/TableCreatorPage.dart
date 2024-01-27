import 'package:flutter/material.dart';
import 'package:flutter_course_project/view/GeneratedTableDisplay.dart';

void main() {
  runApp(TableCreatorPage());
}

class TableCreatorPage extends StatefulWidget {
  const TableCreatorPage({super.key});

  @override
  State<TableCreatorPage> createState() => _TableCreatorPageState();
}

class _TableCreatorPageState extends State<TableCreatorPage> {
  List<String> hoursInterval = [
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
  ];
  String chosenMinHour = "15";
  String chosenMaxHour = "17";

  List<String> semesters = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
  ];

  String chosenSemester = "1";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.arrow_back),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(width: 8),
                const Text(
                  "Table Creator",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                VerticalSpacing(48),
                hoursIntervalSection(),
                VerticalSpacing(24),
                startEndSection(),
                VerticalSpacing(60),
                CustomButton(),
                VerticalSpacing(16),
                const Text("The hours should be between 12 -19 "),
                VerticalSpacing(12),
              ],
            ),
          ),
        ));
  }

  ElevatedButton CustomButton() {
    return ElevatedButton(
        onPressed: () {
          navigateToDisplayTable();
        },
        child: Text(
          "Generate",
          style: TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF842700), minimumSize: Size(300, 60)));
  }

  Container VerticalSpacing(double value) => Container(height: value);

  Container startEndSection() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0x0f000000)),
          borderRadius: BorderRadius.all(Radius.circular(21))),
      height: 108,
      width: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Semester"),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDropDownButton(semesters, chosenSemester, (v) {
                setState(() {
                  chosenSemester = v as String;
                });
              }),
            ],
          )
        ],
      ),
    );
  }

  Container hoursIntervalSection() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0x0f000000)),
          borderRadius: BorderRadius.all(Radius.circular(21))),
      height: 108,
      width: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Hours Interval "),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDropDownButton(hoursInterval, chosenMinHour, (v) {
                setState(() {
                  chosenMinHour = v as String;
                });
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("to"),
              ),
              CustomDropDownButton(hoursInterval, chosenMaxHour, (v) {
                setState(() {
                  chosenMaxHour = v as String;
                });
              }),
            ],
          )
        ],
      ),
    );
  }

  Container CustomDropDownButton(
      List<String> items, String value, Function(String?) onChanged) {
    return Container(
      child: DropdownButton(
        value: value,
        items: items
            .map(
              (e) => DropdownMenuItem(
                child: Text(e),
                value: e,
              ),
            )
            .toList(),
        onChanged: onChanged,
        underline: Container(),
      ),
      width: 117,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Color(0xFFEEEDED),
          borderRadius: BorderRadius.all(Radius.circular(31))),
    );
  }

  void navigateToDisplayTable() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GeneratedTableDisplay()));
  }
}
