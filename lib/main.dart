import 'package:belajar/dashboard.dart';
import 'package:belajar/onboard.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'env.dart';
import 'login.dart'; // Import file login.dart
import 'register.dart'; // Import file register.dart
import 'onboard.dart';

void main() {
  runApp(MyApp());
    //Remove this method to stop OneSignal Debugging 
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(appidOneSignal);

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
      // initialRoute: '/',
      routes: {
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
