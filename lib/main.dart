<<<<<<< HEAD
import 'package:busbuddy/views/OnboardingScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:busbuddy/onGeneratedRoutes.dart';
import 'package:busbuddy/services/NotificationService.dart';
import 'package:busbuddy/views/navigation_bar2.dart';
import "firebase_options.dart";
import 'views/screens/AuthScreen/SignInScreen.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';

=======
<<<<<<< HEAD
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:busbuddy/onGeneratedRoutes.dart';
import 'package:busbuddy/services/NotificationService.dart';
import 'package:busbuddy/views/navigation_bar2.dart';

import "firebase_options.dart";
import 'views/screens/AuthScreen/SignInScreen.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';
=======
<<<<<<< HEAD
import 'package:busbuddy/onGeneratedRoutes.dart';
import 'package:busbuddy/services/NotificationService.dart';
=======
<<<<<<< HEAD
import 'package:busbuddy/onGeneratedRoutes.dart';
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/screens/AuthScreen/SignInScreen.dart';
import 'views/screens/DriverScreen/DriverHomePage.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
// ignore_for_file: prefer_const_constructors
<<<<<<< HEAD
import 'package:busbuddy/services/NotificationService.dart';
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
import "firebase_options.dart";

>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD

  final notificationService = NotificationService();
  await notificationService.initialize();
=======
<<<<<<< HEAD
  final notificationService = NotificationService();
  await notificationService.initialize();
=======
<<<<<<< HEAD
  final notificationService = NotificationService();
  await notificationService.initialize();
=======
<<<<<<< HEAD
  // final notificationService = NotificationService();
  // await notificationService.initialize();
=======
   final notificationService = NotificationService();
  await notificationService.initialize();
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  final prefs = await SharedPreferences.getInstance();
  final userType = prefs.getString('userType');
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
<<<<<<< HEAD
  final bool hasSeenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(MyApp(
    isLoggedIn: isLoggedIn,
    userType: userType,
    hasSeenOnboarding: hasSeenOnboarding,
  ));
=======
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  runApp(MyApp(isLoggedIn: isLoggedIn, userType: userType));
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userType;
<<<<<<< HEAD
  final bool hasSeenOnboarding;
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  const MyApp({
    super.key,
    required this.isLoggedIn,
    this.userType,
<<<<<<< HEAD
    required this.hasSeenOnboarding,
  });
=======
  });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
=======
import 'package:busbuddy/views/screens/StudentScreen/OngoingTrip.dart';
import 'package:firebase_core/firebase_core.dart';
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
<<<<<<< HEAD
=======
import 'services/NotificationService.dart';
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
=======
import 'package:busbuddy/views/screens/DriverScreen/DriverMapView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
import 'views/navigation_bar.dart';
import 'views/screens/AuthScreen/SignInScreen.dart';
import 'views/screens/StudentScreen/AvailableDriversScreen.dart';
import 'views/screens/DriverScreen/DriverDetail.dart';
<<<<<<< HEAD
import 'views/screens/StudentScreen/DriverBookingDetail.dart';
import 'views/screens/StudentScreen/RideHistory.dart';
import 'views/screens/StudentScreen/ScheduleSreen.dart';
<<<<<<< HEAD
import 'views/screens/DriverScreen/DriverHomePage.dart';
import 'views/screens/AuthScreen/SignUpScreen.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';
import 'views/screens/StudentScreen/LocationSelection.dart';
import "firebase_options.dart";
=======
import 'views/screens/StudentScreen/TrackDriver.dart';
import 'views/screens/DriverScreen/DriverHomePage.dart';
import 'views/screens/StudentScreen/PaymentScreen.dart';
import 'views/screens/AuthScreen/SignUpScreen.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';
import 'views/screens/StudentScreen/LocationSelection.dart';
import 'views/screens/ProfileManagment/ProfileManagment.dart';
import "firebase_options.dart";

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
=======
import 'views/screens/StudentScreen/TrackDriver.dart';
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
import 'views/screens/DriverScreen/DriverHomePage.dart';
import 'views/screens/AuthScreen/SignUpScreen.dart';
import 'views/screens/StudentScreen/StudentHomePage.dart';
import 'views/screens/StudentScreen/LocationSelection.dart';
import "firebase_options.dart";

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD
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
=======
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
<<<<<<< HEAD
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Buddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
=======
<<<<<<< HEAD
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
=======
<<<<<<< HEAD
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
=======
<<<<<<< HEAD
      // initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
=======
<<<<<<< HEAD
<<<<<<< HEAD
      initialRoute: '/',
      routes: {
=======
      initialRoute: '/',
      routes: {
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      home: _getInitialScreen(),
    );
  }

<<<<<<< HEAD
  Widget _getInitialScreen() {
    if (!hasSeenOnboarding) {
      return OnboardingScreen();
    }
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
      home:  _getInitialScreen(),
    );
  }
<<<<<<< HEAD
  
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  Widget _getInitialScreen() {
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    if (!isLoggedIn) {
      return const SignInScreen();
    }

    // Navigate based on user type
    switch (userType) {
      case 'student':
        return const StudentHomePage();
      case 'driver':
<<<<<<< HEAD
        return const MainNavigation2();
=======
<<<<<<< HEAD
        return const MainNavigation2();
=======
        return const DriverHomePage();
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      default:
        return const SignInScreen();
    }
  }
<<<<<<< HEAD
}
=======
<<<<<<< HEAD
}
=======
<<<<<<< HEAD
}
=======
<<<<<<< HEAD
}
=======
<<<<<<< HEAD
=======
      home: MapSample(),
=======
}

=======
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
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    );
  }
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
}
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
