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
          backgroundColor: Colors.white,
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
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Container(
                height: 150,
                width: 150,
                child: Image.asset("assets/profilePlaceHolder.png"),
              ),
              SizedBox(height: 30, width: MediaQuery.of(context).size.width),
              const SizedBox(height: 16),
              FutureBuilder<DocumentSnapshot>(
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
                    String userName = userEmail.split("@")[0];
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name\n\nEmail\n\nID\n\nMajor\n\nPassed Hours\n\nRemaining Hours',
                              style: TextStyle(
                                  color:
                                  Color.fromARGB(255, 189, 114, 64),
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$userName\n\n$userEmail\n\n$userID\n\n$userMajor\n\n${passedHours.toString()}\n\n${remainingHours.toString()}',
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
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
