import 'package:flutter/material.dart';
import 'package:flutter_course_project/view/login.dart';
import '../model/localDatabase/sharedPrefferences.dart';
import 'HomePage.dart';
import 'StartingPage.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final List<Widget> pages = [HomePage(studentId: "",), ProfilePage()];

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  Container(width: 8),
                  const Text(
                    "logout",
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                ],
              ),
              onTap: (){
                setAsLoggedOut();
                Navigator.popUntil(context, (route) => false);
                Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing(36),
                Center(child: Image.asset("assets/profilePlaceHolder.png")),
                VerticalSpacing(16),
                Center(
                    child: Text(
                  "John Doe",
                  style: TextStyle(fontSize: 22),
                )),
                VerticalSpacing(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Divider(
                    height: 1,
                  ),
                ),
                VerticalSpacing(44),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("email  : john@gmail.com"),
                      Icon(Icons.edit)
                    ],
                  ),
                ),
                VerticalSpacing(8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text("id : 1-570-236-7033"),
                )
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
                icon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => pages[index]),
              );
            },
          ),
        ));
  }
}

Container VerticalSpacing(double value) {
  return Container(
    height: value,
  );
}
