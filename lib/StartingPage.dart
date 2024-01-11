import 'package:flutter/material.dart';

import 'HomePage.dart';

void main() {
  runApp(MyApp());
}

class YearData {
  final String title;
  final List<String> items;

  YearData({required this.title, required this.items});
}

class MyApp extends StatelessWidget {
  final List<YearData> yearDataList = [
    YearData(title: 'First Year', items: [
      'BEGINNING ENGLISH',
      'INTERMEDIATE ENGLISH',
      'INTERMEDIATE ENGLISH LAB',
      'COMPUTER SKILLS',
      'GENERAL PHYSICS I',
      'GENERAL PHYSICS LAB I',
      'CALCULUS I',
      'PROGRAMMING FUNDAMENTALS I',
      'PROGRAMMING FUNDAMENTALS I (LAB)',
      'ADVANCED ENGLISH',
      'ADVANCED ENGLISH LAB',
      'CALCULUS II',
      'ENGINEERING DRAWING',
      'GENERAL PHYSICS II',
      'DIGITAL LOGIC DESIGN',
      'PROGRAMMING FUNDAMENTALS II'
    ]),
    YearData(title: 'Second Year', items: [
      'Univ. Elec.',
      'ENGINEERING MATHEMATICS I',
      'ENGINEERING WORKSHOP I',
      'DISCRETE MATHEMATICS',
      'ELECTRICAL CIRCUITS I',
      'DIGITAL LOGIC DESIGN LAB',
      'PRINCIPLES OF OBJECT ORIENTED PROGRAMMING',
      'ENGINEERING MATHEMATICS II',
      'ENGINEERING WORKSHOP II',
      'ELECTRICAL CIRCUITS II',
      'ELECTRICAL CIRCUITS LAB',
      'SIGNALS AND SYSTEMS',
      'COMPUTER ORGANIZATION',
      'DATA STRUCTURES'
    ]),
    YearData(title: 'Third Year', items: [
      'PALESTINIAN STUDIES',
      'ALGORITHMS ANALYSIS AND DESIGN',
      'ADVANCED DIGITAL SYSTEMS DESIGN',
      'DATABASE LAB',
      'ELECTRONICS I',
      'INTRODUCTION TO DATABASE SYSTEMS',
      'ARABIC LANGUAGE',
      'NUMERICAL METHODS',
      'DATA & COMPUTER NETWORKS',
      'ELECTRONICS II',
      'MICROPROCESSOR SYSTEMS & APPLICATIONS',
      'OPERATING SYSTEMS'
    ]),
    YearData(title: 'Fourth Year', items: [
      'ASSEMBLY PROGRAMMING LAB',
      'PROBABILITY AND RANDOM VARIABLES',
      'ELECTRONICS LAB',
      'TECHNICAL WRITING',
      'SOFTWARE ENGINEERING',
      'WEB PROGRAMMING',
      'Spec. Elec.',
      'FUNDAMENTALS OF RESEARCH METHODS',
      'Univ. Elec.',
      'COMPUTER NETWORK LAB',
      'ARTIFICIAL INTELLIGENCE',
      'MICROPROCESSOR LAB',
      'EMBEDDED SYSTEMS',
      'Spec. Elec.',
      'SUMMER SEMESTER',
      'INTERNSHIP'
    ]),
    YearData(title: 'Fifth Year', items: [
      'ENGINEERING PROJECT MANAGEMENT',
      'STATIC',
      'SENIOR PROJECT I',
      'EMBEDDED SYSTEMS LAB',
      'LINUX LAB',
      'Spec. Elec.',
      'Free Elective',
      'Univ. Elec.',
      'Univ. Elec.',
      'SENIOR PROJECT II',
      'Spec. Elec.',
      'Free Elective'
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        dividerTheme: DividerThemeData(
          thickness: 0.0,
        ),
      ),
      home: MyHomePage(yearDataList: yearDataList),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<YearData> yearDataList;

  MyHomePage({required this.yearDataList});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<bool>> isSelectedList = [];

  @override
  void initState() {
    super.initState();
    initializeSelectedList();
  }

  void initializeSelectedList() {
    isSelectedList = List.generate(
        widget.yearDataList.length,
            (yearIndex) =>
            List.filled(widget.yearDataList[yearIndex].items.length, false));
  }

  String capitalizeFirstLetterOfEachWord(String text) {
    List<String> words = text.toLowerCase().split(' ');

    for (int i = 0; i < words.length; i++) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }

    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Select your passed courses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.yearDataList.length,
                itemBuilder: (context, yearIndex) {
                  YearData yearData = widget.yearDataList[yearIndex];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 224, 188, 188),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        yearData.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      tilePadding: EdgeInsets.all(10),
                      childrenPadding: EdgeInsets.all(16.0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelectedList[yearIndex] =
                                      List.filled(yearData.items.length, true);
                                });
                              },
                              child: Text(
                                'Select All',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelectedList[yearIndex] =
                                      List.filled(yearData.items.length, false);
                                });
                              },
                              child: Text(
                                'Clear All',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: yearData.items.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  isSelectedList[yearIndex][index] =
                                  !isSelectedList[yearIndex][index];
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: isSelectedList[yearIndex][index]
                                      ? Color.fromARGB(255, 189, 114, 64)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    capitalizeFirstLetterOfEachWord(
                                        yearData.items[index]),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelectedList[yearIndex][index]
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                submitStatus();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void submitStatus() {
    for (int yearIndex = 0; yearIndex < isSelectedList.length; yearIndex++) {
      YearData yearData = widget.yearDataList[yearIndex];
      print('Year ${yearData.title} status:');
      for (int itemIndex = 0;
      itemIndex < isSelectedList[yearIndex].length;
      itemIndex++) {
        String item = yearData.items[itemIndex];
        bool isSelected = isSelectedList[yearIndex][itemIndex];
        print('$item: ${isSelected ? 'Selected' : 'Not Selected'}');
      }
      print('----------------------');
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}