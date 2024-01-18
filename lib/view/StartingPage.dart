import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:flutter_course_project/model/exelFiles/ReadCoursesFromCSV.dart';
import 'package:flutter/services.dart';

class YearData {
  final String title;
  final List<String> items;

  YearData({required this.title, required this.items});
}


String capitalizeFirstLetterOfEachWord(String text) {
  List<String> words = text.toLowerCase().split(' ');
  for (int i = 0; i < words.length; i++) {
    if ( words[i] == 'II' || words[i] == 'III') {
      words[i] = words[i].toUpperCase();
    }
    else {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }
  return words.join(' ');
}

class StartingPage extends StatefulWidget {
  final String studentId;

  StartingPage({required this.studentId});

  @override
  _StartingPageState createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  List<List<bool>> isSelectedList = [];

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
      'FUNDAMENTALS OF RESEARCH METHODS',
      'COMPUTER NETWORK LAB',
      'ARTIFICIAL INTELLIGENCE',
      'MICROPROCESSOR LAB',
      'EMBEDDED SYSTEMS',
      'INTERNSHIP'
    ]),
    YearData(title: 'Fifth Year', items: [
      'ENGINEERING PROJECT MANAGEMENT',
      'STATIC',
      'SENIOR PROJECT I',
      'EMBEDDED SYSTEMS LAB',
      'LINUX LAB',
      'SENIOR PROJECT II',
    ]),
  ];
  // final List<YearData> yearDataList

  // here is the error of loading CSV function ****
  Future<void> _loadCourses() async {
     try {
       // List<Course> loadedCourses = await _loadCSV();
     } catch (error) {
       print("Error loading courses: $error");
     }
   }


  @override
  void initState() {
    super.initState();
    initializeSelectedList();
  }

  void initializeSelectedList() {
    isSelectedList = List.generate(
        yearDataList.length,
            (yearIndex) =>
            List.filled(yearDataList[yearIndex].items.length, false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select your passed courses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: yearDataList.length,
                itemBuilder: (context, yearIndex) {
                  YearData yearData = yearDataList[yearIndex];
                  return Container(
                    // Spaced between the years
                    margin: EdgeInsets.all(10),
                    child: ExpansionTile(
                      backgroundColor: Color(0xFFEEEDED),
                      collapsedBackgroundColor: Color(0xFFEEEDED),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      collapsedShape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          yearData.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      tilePadding: EdgeInsets.all(5),
                      childrenPadding: EdgeInsets.all(16.0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          // make 'Select All' and 'Clear All' buttons in the middle
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelectedList[yearIndex] =
                                      List.filled(yearData.items.length, true);
                                });
                              },
                              child: Text('Select All',style: TextStyle(color: Colors.black),),
                            ),
                            Text(' : ',style: TextStyle(color: Colors.black),),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isSelectedList[yearIndex] =
                                      List.filled(yearData.items.length, false);
                                });
                              },
                              child: Text('Clear All',style: TextStyle(color: Colors.black),),
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
                submitStatus(context); // Pass context to the function
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 60),
                backgroundColor: const Color(0xFF842700),
                foregroundColor: Colors.white,
              ),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void submitStatus(BuildContext context) {
    Map<String, bool> coursesStatus = {};

    for (int yearIndex = 0; yearIndex < isSelectedList.length; yearIndex++) {
      YearData yearData = yearDataList[yearIndex];
      for (int itemIndex = 0; itemIndex < isSelectedList[yearIndex].length; itemIndex++) {
        String itemName = yearData.items[itemIndex];
        bool isSelected = isSelectedList[yearIndex][itemIndex];


        // Save the status to the coursesStatus map
        coursesStatus[itemName] = isSelected;
      }
    }
    print(coursesStatus.toString());
    // Save the coursesStatus map to Firestore
    saveStatusToFirestore(context, widget.studentId, coursesStatus);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(studentId: widget.studentId,)),
    );
  }

  void saveStatusToFirestore(BuildContext context, String studentId, Map<String, bool> coursesStatus) async {
    try {
      // Add or update the document in the 'student-course' collection
      await FirebaseFirestore.instance
          .collection('student-course')  // Assuming your collection is named 'students'
          .doc('$studentId')
          .set({
        'studentId': studentId,
        'courses': coursesStatus,
      });
    } catch (e) {
      print('Error saving status to Firestore: $e');
    }
  }

}

