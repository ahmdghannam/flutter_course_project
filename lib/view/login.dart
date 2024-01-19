import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'signup.dart'; // to import the RoundedTextField
import '../model/localDatabase/sharedPrefferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserCredential userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  
    // Get the Student ID generated by Firebase Authentication
    String studentid = userCredential.user?.uid ?? "";
    
    return FutureBuilder<bool?>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          bool? isLoggedI = snapshot.data;
          return MaterialApp(
            theme: ThemeData(fontFamily: 'RobotoMono'),
            home: isLoggedI == true ? HomePage(studentId: studentid) : LoginPage(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          // While the Future is still in progress, you can show a loading indicator or another widget.
          return const CircularProgressIndicator();
        }
      },
   );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(color: Color(0xFF92705B)),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ListView(
          children: [
            Column(
              children: [
                const Image(
                  image: AssetImage("assets/omarlogo.png"),
                  height: 300,
                ),
                RoundedTextField(
                  label: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 25),
                RoundedTextField(
                  label: 'Password',
                  isPassword: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    loginUser(context);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 60),
                    backgroundColor: const Color(0xFF842700),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Do not have an account? ',
                      style: TextStyle(color: Color(0xFF92705B)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                            color: Color(0xFF92705B),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void loginUser(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the Student ID generated by Firebase Authentication
      String studentid = userCredential.user?.uid ?? "";

      // User logged in successfully
      print("Login Successful");

      // navigation logic to the next screen after successful login
      Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(studentId: studentid),),);
    } catch (e) {
      print("Login Failed: $e");
      // Handle login failure
      // You can show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login failed. Please check your credentials."),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
