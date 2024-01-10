import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Table Creator",
            style: TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.white,
        ),
        body: const TableCreatorPage(),
      )));
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

  List<String> startEndTimes = [
    "8:30",
    "9:00",
    "10:00",
    "11:00",
    "12:30",
    "1:00",
    "2:00",
    "3:00",
    "4:00",
  ];

  String chosenStartHour = "8:30";
  String chosenEndHour = "3:00";

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const Text("The day time should be between 8:30 and 4:00"),
      ],
    );
  }

  ElevatedButton CustomButton() {
    return ElevatedButton(
          onPressed: () {},
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
          border: Border.all(color: Color(0x1E000000)),
          borderRadius: BorderRadius.all(Radius.circular(21))),
      height: 108,
      width: 300,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("start"),
                Text("end"),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDropDownButton(startEndTimes, chosenStartHour, (v) {
                setState(() {
                  chosenStartHour = v as String;
                });
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("to"),
              ),
              CustomDropDownButton(startEndTimes, chosenEndHour, (v) {
                setState(() {
                  chosenEndHour = v as String;
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
          border: Border.all(color: Color(0x1E000000)),
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
}
