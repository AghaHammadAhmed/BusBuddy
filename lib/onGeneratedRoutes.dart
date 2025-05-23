<<<<<<< HEAD
import 'package:busbuddy/views/navigation_bar2.dart';
=======
<<<<<<< HEAD
import 'package:busbuddy/views/navigation_bar2.dart';
=======
<<<<<<< HEAD
import 'package:busbuddy/views/navigation_bar2.dart';
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
import 'package:flutter/material.dart';
import 'package:busbuddy/views/screens/StudentScreen/OngoingTrip.dart';
import 'package:busbuddy/views/screens/AuthScreen/SignInScreen.dart';
import 'package:busbuddy/views/screens/StudentScreen/AvailableDriversScreen.dart';
import 'package:busbuddy/views/screens/DriverScreen/DriverDetail.dart';
import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:busbuddy/views/screens/StudentScreen/RideHistory.dart';
import 'package:busbuddy/views/screens/StudentScreen/ScheduleSreen.dart';
import 'package:busbuddy/views/screens/DriverScreen/DriverHomePage.dart';
import 'package:busbuddy/views/screens/AuthScreen/SignUpScreen.dart';
import 'package:busbuddy/views/screens/StudentScreen/StudentHomePage.dart';
import 'package:busbuddy/views/screens/StudentScreen/LocationSelection.dart';
import 'package:busbuddy/views/navigation_bar.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );

      case '/availableDrivers':
        return MaterialPageRoute(
          builder: (_) => const AvailableDriversScreen(),
        );

      case '/locationSelection':
        return MaterialPageRoute(
          builder: (_) => const LocationPickerScreen(),
        );

      case '/DriverBookingDetail':
        return MaterialPageRoute(
          builder: (_) => DriverBookingDetail(),
        );

      case '/driverDetail':
        return MaterialPageRoute(
          builder: (_) => const DriverDetailsScreen(),
        );

      case '/schedule':
        return MaterialPageRoute(
          builder: (_) => TransportationCalendarPage(),
        );

      case '/studentHome':
        return MaterialPageRoute(
          builder: (_) => const StudentHomePage(),
        );

      case '/driverHome':
        return MaterialPageRoute(
          builder: (_) => const DriverHomePage(),
        );

      case '/trackDriver':
        return MaterialPageRoute(
          builder: (_) => const TrackDriver(),
        );

      case '/mainNavigation':
        return MaterialPageRoute(
          builder: (_) => const MainNavigation(),
        );

<<<<<<< HEAD
      case '/mainNavigation2':
        return MaterialPageRoute(builder: (_) => const MainNavigation2());

=======
<<<<<<< HEAD
      case '/mainNavigation2':
        return MaterialPageRoute(builder: (_) => const MainNavigation2());

=======
<<<<<<< HEAD
      case '/mainNavigation2':
        return MaterialPageRoute(builder: (_) => const MainNavigation2());

=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      case '/signUp':
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
        );

      case '/rideHistory':
        return MaterialPageRoute(
          builder: (_) => const RideHistory(),
        );

      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found!'),
        ),
      );
    });
  }
}
