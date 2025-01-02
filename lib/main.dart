// ignore_for_file: prefer_const_constructors
import 'package:busbuddy/views/screens/StudentScreen/OngoingTrip.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/navigation_bar.dart';
import 'views/screens/AuthScreen/SignInScreen.dart';
import 'views/screens/StudentScreen/AvailableDriversScreen.dart';
import 'views/screens/DriverScreen/DriverDetail.dart';
import 'views/screens/StudentScreen/DriverBookingDetail.dart';
import 'views/screens/StudentScreen/RideHistory.dart';
import 'views/screens/StudentScreen/ScheduleSreen.dart';
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
  //  final notificationService = NotificationService();
  // await notificationService.initialize();

  final prefs = await SharedPreferences.getInstance();
  final userType = prefs.getString('userType');
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp( MyApp(isLoggedIn: isLoggedIn, userType: userType));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userType;
  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.userType,
  });

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
        '/availableDrivers': (context) => const AvailableDriversScreen(),
        '/locationSelection': (context) => const LocationPickerScreen(),
        '/DriverBookingDetail': (context) => DriverBookingDetail(),
        '/driverDetail': (context) => const DriverDetailsScreen(),
        '/schedule': (context) => TransportationCalendarPage(),
        '/studentHome': (context) => const StudentHomePage(),
        '/driverHome': (context) => const DriverHomePage(),
        '/trackDriver': (context) => const TrackDriver(),
        '/mainNavigation': (context) => MainNavigation(),
        "/signUp": (context) => const SignUpScreen(),
        '/login': (context) => const SignInScreen(),
        '/rideHistory': (context) => RideHistory(),
      },
      home:  _getInitialScreen(),
    );
  }
  
  Widget _getInitialScreen() {
    if (!isLoggedIn) {
      return const SignInScreen();
    }

    // Navigate based on user type
    switch (userType) {
      case 'student':
        return const StudentHomePage();
      case 'driver':
        return const DriverHomePage();
      default:
        return const SignInScreen();
    }
  }
}

