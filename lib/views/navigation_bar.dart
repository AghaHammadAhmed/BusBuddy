import 'package:flutter/material.dart';

import 'screens/StudentScreen/StudentHomePage.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'screens/StudentScreen/OngoingTrip.dart';
import 'screens/ProfileManagment/ProfileManagment.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

<<<<<<< HEAD
=======
=======
import 'screens/OngoingTrip.dart';
import 'screens/ProfileManagment/ProfileManagment.dart';

<<<<<<< HEAD
class MainNavigation extends StatefulWidget {
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======

class MainNavigation extends StatefulWidget {
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
    const StudentHomePage(),
    const TrackDriver(),
    const ProfilePage(),
=======
    StudentHomePage(),
<<<<<<< HEAD
    TrackDriver(),
    EditProfileScreen(),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
    OngoingTrip(),
    EditProfileScreen(),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
