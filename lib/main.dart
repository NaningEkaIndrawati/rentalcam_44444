import 'package:belajar/dashboard.dart';
import 'package:belajar/onboard.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Import file login.dart
import 'register.dart'; // Import file register.dart
import 'onboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardPage(),
      // initialRoute: '/',
      routes: {
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
