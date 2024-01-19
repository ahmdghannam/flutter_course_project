import 'package:flutter/material.dart';
import 'package:flutter_course_project/view/ProfilePage.dart';
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

final List<Widget> pages = [HomePage(), StartingPage(), ProfilePage()];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/omarlogo.png', height: 250,),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Welcome to TableCraft, where we effortlessly transform your student data into organized tables! Simplify your workload and enhance efficiency with just a few clicks.',
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
              child: Text('Create New Table', style: TextStyle(color: Colors.white),),
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
                  MaterialPageRoute(builder: (context) => StartingPage()),
                );// Add functionality for updating passed courses
              },
              child: Text('Update Passed Courses', style: TextStyle(color: Colors.white)),
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
              child: Text('Go to CSE Plan', style: TextStyle(color: Colors.white)),
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
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Create New Table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pages[index]),
          );
        },
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
