import 'package:flutter/material.dart';

import 'screens/StudentScreen/StudentHomePage.dart';
<<<<<<< HEAD
import 'screens/StudentScreen/OngoingTrip.dart';
import 'screens/ProfileManagment/ProfileManagment.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

=======
import 'screens/OngoingTrip.dart';
import 'screens/ProfileManagment/ProfileManagment.dart';

class MainNavigation extends StatefulWidget {
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
<<<<<<< HEAD
    const StudentHomePage(),
    const TrackDriver(),
    const ProfilePage(),
=======
    StudentHomePage(),
    TrackDriver(),
    EditProfileScreen(),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
  ];

  // Update selected page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Ongoing Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
