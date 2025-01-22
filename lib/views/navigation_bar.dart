<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
// import 'package:flutter/material.dart';

// import 'screens/StudentScreen/StudentHomePage.dart';
// import 'screens/StudentScreen/OngoingTrip.dart';
// import 'screens/ProfileManagment/ProfileManagment.dart';

// class MainNavigation extends StatefulWidget {
//   const MainNavigation({super.key});

//   @override
//   _MainNavigationState createState() => _MainNavigationState();
// }

// class _MainNavigationState extends State<MainNavigation> {
//   int _selectedIndex = 0;

//   // List of pages
//   final List<Widget> _pages = [
//     const StudentHomePage(),
//     const TrackDriver(),
//     const ProfilePage(),
//   ];

//   // Update selected page
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.directions_car),
//             label: 'Ongoing Trip',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
// }
<<<<<<< HEAD

import 'package:flutter/material.dart';

import 'screens/StudentScreen/StudentHomePage.dart';
=======
import 'package:flutter/material.dart';

import 'screens/StudentScreen/StudentHomePage.dart';
<<<<<<< HEAD
=======
=======
import 'package:flutter/material.dart';

import 'screens/StudentScreen/StudentHomePage.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
import 'screens/StudentScreen/OngoingTrip.dart';
import 'screens/ProfileManagment/ProfileManagment.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF8A1538),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 28,
                color: _selectedIndex == 0
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.directions_car,
                size: 28,
                color: _selectedIndex == 1
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
              ),
              label: 'Ongoing Trip',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 28,
                color: _selectedIndex == 2
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
              ),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          backgroundColor: const Color(0xFF8A1538),
          selectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 13,
          ),
          type: BottomNavigationBarType.fixed,
        ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      ),
    );
  }
}
