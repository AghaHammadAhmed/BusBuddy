import 'package:busbuddy/views/screens/DriverScreen/DriverMapView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'views/navigation_bar.dart';
import 'views/screens/AuthScreen/SignInScreen.dart';
import 'views/screens/StudentScreen/AvailableDriversScreen.dart';
import 'views/screens/DriverScreen/DriverDetail.dart';
import 'views/screens/StudentScreen/TrackDriver.dart';
import 'views/screens/DriverScreen/DriverHomePage.dart';
import 'views/screens/AuthScreen/SignUpScreen.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';
import 'views/screens/StudentScreen/LocationSelection.dart';
import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      initialRoute: '/',
      routes: {
        '/login': (context) => const SignInScreen(),
        "/signUp": (context) => const SignUpScreen(),
        '/mainNavigation': (context) => MainNavigation(),
        '/studentHome': (context) => const StudentHomePage(),
        '/driverHome': (context) => const DriverHomePage(),
        '/locationSelection': (context) => const LocationPickerScreen(),
        '/trackDriver': (context) => const TrackDriver(),
        '/availableDrivers': (context) => const AvailableDriversScreen(),
        '/driverDetail': (context) => const DriverDetailsScreen(),
      },
      home: const SignInScreen(),
    );
  }
}
