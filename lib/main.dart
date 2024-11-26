import 'package:flutter/material.dart';

import 'views/screens/AuthScreen/Auth_Screen.dart';
import 'views/screens/AvailableDriversScreen/AvailableDriversScreen.dart';
import 'views/screens/HomePage.dart';
import 'views/screens/LocationSelection.dart';
import 'views/screens/ProfileManagment/ProfileManagment.dart';
import "firebase_options.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MapSample(),
    );
  }
}
