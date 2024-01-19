import 'package:flutter/material.dart';
import 'package:flutter_course_project/view/TableCreatorPage.dart';
import 'StartingPage.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURLInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}

class HomePage extends StatelessWidget {
  final String studentId;

  HomePage({required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TableCreatorPage()),
                );
              },
              child: Text('Create New Table'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 70),
                backgroundColor: Color(0xff842700),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StartingPage(studentId: studentId,)),
                );// Add functionality for updating passed courses
              },
              child: Text('Update Passed Courses'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 70),
                backgroundColor: Color(0xff842700),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                _launchURLInBrowser('https://www.aaup.edu/Academics/Undergraduate-Studies/Faculty-Engineering/Computer-Systems-Engineering-Department/Computer-Systems-Engineering/Curriculum');
              },
              child: Text('Go to CSE Plan'),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(250, 70),
                backgroundColor: Color(0xff842700),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Create New Table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Table'),
      ),
      body: Center(
        child: Text('Page 1 Content'),
      ),
    );
  }
}
