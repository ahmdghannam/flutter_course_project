import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'StartingPage.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                RoundedTextField(
                  label: 'Full Name',
                  width: 320,
                  controller: nameController,
                ),
                const SizedBox(height: 25),
                RoundedTextField(
                  label: 'Student ID',
                  width: 320,
                  controller: idController,
                ),
                const SizedBox(height: 25),
                RoundedTextField(
                  label: 'Email',
                  width: 320,
                  controller: emailController,
                ),
                const SizedBox(height: 25),
                RoundedTextField(
                  label: 'Password',
                  isPassword: true,
                  width: 320,
                  controller: passwordController,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    signUpUser(context);
                  },
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

  void signUpUser(BuildContext context) async {
    String name = nameController.text;
    String id = idController.text;
    String email = emailController.text;
    String password = passwordController.text;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the Student ID generated by Firebase Authentication
      String studentid = userCredential.user?.uid ?? "";

      // Save student information to Firestore (database)
      await FirebaseFirestore.instance.collection('student').doc(studentid).set({
        'name': name,
        'id': id,
        'email': email,
      });

      // User registered successfully
      print("Registration Successful");

      // Navigation to the next screen after successful registration
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StartingPage(studentId: studentid),
        ),
      );

    } catch (e) {
      print("Registration Failed: $e");
      // Handle registration failure
      // You can show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registration failed. Please try again."),
        duration: Duration(seconds: 3),
      ));
    }
  }
}

class RoundedTextField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final double width;
  final TextEditingController? controller;

  const RoundedTextField(
      {required this.label,
      this.isPassword = false,
      this.width = 250,
      this.controller});

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
        controller: controller,
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

// past code
// class SignUpPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Sign Up Page',
//           style: TextStyle(color: Color(0xFF92705B)),
//         ),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 const Image(
//                   image: AssetImage("assets/logo.png"),
//                   height: 250,
//                 ),
//                 const RoundedTextField(label: 'Full Name',width: 320,),
//                 const SizedBox(height: 25),
//                 const RoundedTextField(label: 'Student ID', width: 320),
//                 const SizedBox(height: 25),
//                 const RoundedTextField(label: 'Email', width: 320),
//                 const SizedBox(height: 25),
//                 const RoundedTextField(label: 'Password', isPassword: true, width: 320),
//                 const SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     fixedSize: const Size(320, 60),
//                     backgroundColor: const Color(0xFF842700),
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Sign Up'),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RoundedTextField extends StatelessWidget {
//   final String label;
//   final bool isPassword;
//   final double width;
//
//   const RoundedTextField(
//       {required this.label, this.isPassword = false, this.width = 250});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50.0),
//         border: Border.all(color: const Color(0xFFf5efec)),
//         color: const Color(
//             0xFFf5efec), // This creates a border without specifying a color
//       ),
//       padding: const EdgeInsets.all(8),
//       child: TextFormField(
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: label,
//           filled: true,
//           fillColor: const Color(0xFFf5efec),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
