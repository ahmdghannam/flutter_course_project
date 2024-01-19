import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'view/login.dart'; // Import the SignUpPage
import 'model/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseFirestore.instance.settings;
  print("Firebase initialization complete.");
  runApp(
      MaterialApp(
        home: MyApp(),
        theme: ThemeData(fontFamily: 'RobotoMono'),
        debugShowCheckedModeBanner: false,
      )

  );
}

