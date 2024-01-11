// main.dart

import 'package:flutter/material.dart';
import 'signup.dart'; // Import the SignUpPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatelessWidget {
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
                  image: AssetImage("assets/logo.png"),
                  height: 300,
                ),
                const RoundedTextField(label: 'Email'),
                const SizedBox(height: 25),
                const RoundedTextField(label: 'Password', isPassword: true),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {},
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
}
