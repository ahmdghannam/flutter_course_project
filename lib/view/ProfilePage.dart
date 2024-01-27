import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_project/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/localDatabase/sharedPrefferences.dart';
import 'HomePage.dart';
import 'TableCreatorPage.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

final List<Widget> pages = [
  HomePage(
    studentId: "",
  ),
  ProfilePage()
];

class _ProfilePageState extends State<ProfilePage> {
  late Future<DocumentSnapshot> userFuture;

  @override
  void initState() {
    super.initState();
    userFuture = loadUserInfo();
  }

  Future<DocumentSnapshot> loadUserInfo() async {
    // Get user ID from SharedPreferences
    String userID = await getUserID() ?? '';

    // Fetch user information from Firestore
    return FirebaseFirestore.instance.collection('student').doc(userID).get();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xffEEEDED),
          appBar: AppBar(
            title: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Container(width: 8),
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                ],
              ),
              onTap: () {
                setAsLoggedOut();
                Navigator.popUntil(context, (route) => false);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            backgroundColor: const Color(0xffEEEDED),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalSpacing(36),
                    Center(
                      child: Container(
                        height: 300,
                        width: 300,
                        child: Image.asset("assets/profilePlaceHolder.png"),
                      ),
                    ),
                    VerticalSpacing(7),
                    const Center(
                        child: Text(
                      "Musab Nuirat",
                      style: TextStyle(fontSize: 22),
                    )),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.2,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30, width: MediaQuery.of(context).size.width),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: FutureBuilder<DocumentSnapshot>(
                      future: userFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var userSnapshot = snapshot.data!;
                          String userEmail = userSnapshot['email'] ?? '';
                          String userID = userSnapshot['id'] ?? '';
                          // String userMajor = userSnapshot['major'] ?? '';
                          String userMajor = 'CSE';
                          // int passedHours = userSnapshot['passedHours'] ?? 0;
                          int passedHours = 130;
                          // int remainingHours = userSnapshot['remainingHours'] ?? 0;
                          int remainingHours = 30;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email\n\nID\n\nMajor\n\nPassed Hours\n\nRemaining Hours',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 189, 114, 64),
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$userEmail\n\n$userID\n\n$userMajor\n\n${passedHours.toString()}\n\n${remainingHours.toString()}',
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                      height: 100, width: MediaQuery.of(context).size.width),
                  // Add more widgets as needed
                ],
              ),
              // Page content here
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1,
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
