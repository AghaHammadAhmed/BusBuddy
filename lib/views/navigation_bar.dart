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

import 'package:flutter/material.dart';

import 'screens/StudentScreen/StudentHomePage.dart';
import 'screens/StudentScreen/OngoingTrip.dart';
import 'screens/ProfileManagment/ProfileManagment.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  // List of pages
  final List<Widget> _pages = [
    const StudentHomePage(),
    const TrackDriver(),
    const ProfilePage(),
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
      ),
    );
  }
}
