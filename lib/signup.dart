import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up Page',
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
                  height: 250,
                ),
                const RoundedTextField(
                  label: 'Full Name',
                  width: 320,
                ),
                const SizedBox(height: 25),
                const RoundedTextField(label: 'Student ID', width: 320),
                const SizedBox(height: 25),
                const RoundedTextField(label: 'Email', width: 320),
                const SizedBox(height: 25),
                const RoundedTextField(
                    label: 'Password', isPassword: true, width: 320),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(320, 60),
                    backgroundColor: const Color(0xFF842700),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Sign Up'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class RoundedTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final double width;

  const RoundedTextField(
      {required this.label, this.isPassword = false, this.width = 250});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(color: const Color(0xFFf5efec)),
        color: const Color(
            0xFFf5efec), // This creates a border without specifying a color
      ),
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFf5efec),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
