import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Import the SignUpPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  await Firebase.initializeApp();
  print("Firebase initialization complete.");
  runApp(MyApp());
}

