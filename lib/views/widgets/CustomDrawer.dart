// import 'package:busbuddy/models/user.dart';
// import 'package:busbuddy/views/widgets/DrawerCard.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// Widget buildCustomDrawer(BuildContext context, UserModel? _user) {

//   return Drawer(
//     child: Column(
//       children: [
//         // Custom Drawer Header
//         DrawerHeader(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blue.shade600, Colors.blue.shade300],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const CircleAvatar(
//                 radius: 40,
//                 backgroundColor: Colors.white,
//                 child: Icon(
//                   Icons.person,
//                   size: 50,
//                   color: Colors.blue,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       _user?.name ?? 'John Doe',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       _user?.email ?? '',
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.8),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Drawer List Items
//         Expanded(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//             buildDrawerItem(
//                 icon: Icons.home_outlined,
//                 title: 'Home',
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               buildDrawerItem(
//                 icon: Icons.history_outlined,
//                 title: 'Ride History',
//                 onTap: () {
//                   Navigator.pushNamed(context, '/rideHistory');
//                 },
//               ),
//               buildDrawerItem(
//                 icon: Icons.payment_outlined,
//                 title: 'Payment',
//                 onTap: () {
//                   Navigator.pushNamed(context, '/payment');
//                 },
//               ),
//               buildDrawerItem(
//                 icon: Icons.settings_outlined,
//                 title: 'Settings',
//                 onTap: () {
//                   Navigator.pushNamed(context, '/settings');
//                 },
//               ),
//               buildDrawerItem(
//                 icon: Icons.help_outline,
//                 title: 'Help & Support',
//                 onTap: () {
//                   Navigator.pushNamed(context, '/support');
//                 },
//               ),
//             ],
//           ),
//         ),
//         // Logout Button
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: ElevatedButton.icon(
//             onPressed: () {
//               // Handle logout functionality
//               FirebaseAuth.instance.signOut();
//               Navigator.pushReplacementNamed(context, '/login');
//             },
//             icon: const Icon(Icons.logout, size: 20),
//             label: const Text('Logout'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.redAccent,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:busbuddy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildCustomDrawer(BuildContext context, UserModel? user) {
  late SharedPreferences _prefs;
  return Drawer(
    child: Column(
      children: [
        // Custom Drawer Header
        DrawerHeader(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8A1538), Color(0xFFD32F54)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Color(0xFF8A1538),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? 'No name provided',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.email ?? 'No email provided',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Drawer List Items
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              buildDrawerItem(
                icon: Icons.home_outlined,
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              buildDrawerItem(
                icon: Icons.history_outlined,
                title: 'Ride History',
                onTap: () {
                  Navigator.pushNamed(context, '/rideHistory');
                },
              ),
              buildDrawerItem(
                icon: Icons.payment_outlined,
                title: 'Payment',
                onTap: () {
                  Navigator.pushNamed(context, '/payment');
                },
              ),
              buildDrawerItem(
                icon: Icons.settings_outlined,
                title: 'Settings',
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              buildDrawerItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {
                  Navigator.pushNamed(context, '/support');
                },
              ),
            ],
          ),
        ),
        // Logout Button
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () async {
              // Handle logout functionality
              FirebaseAuth.instance.signOut();
              _prefs = await SharedPreferences.getInstance();
              await _prefs.setBool('isLoggedIn', false);
              await _prefs.setString('userType', '');
              
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout, size: 20),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8A1538),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDrawerItem({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF8A1538)),
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
    hoverColor: Colors.grey.shade200,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
