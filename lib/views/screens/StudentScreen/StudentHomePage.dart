<<<<<<< HEAD
import 'dart:developer';

import 'package:busbuddy/services/AuthService.dart';
import 'package:busbuddy/services/NotificationService.dart';
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/driverService.dart';
<<<<<<< HEAD
import 'LocationSelection.dart';
import 'OngoingTrip.dart';
import 'SafetyScreen.dart';
=======
<<<<<<< HEAD
import 'LocationSelection.dart';
import 'OngoingTrip.dart';
import 'SafetyScreen.dart';
=======
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../../models/driver.dart';
// import '../../../models/user.dart';

// class StudentHomePage extends StatefulWidget {
//   const StudentHomePage({super.key});

//   @override
//   _StudentHomePageState createState() => _StudentHomePageState();
// }

// class _StudentHomePageState extends State<StudentHomePage> {
//   String userId = FirebaseAuth.instance.currentUser!.uid;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         toolbarHeight: 50,
//         elevation: 0,
//         leading: IconButton(
//           color: Colors.black,
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             // Navigate to menu screen
//           },
//         ),
//         actions: [
//           IconButton(
//             color: Colors.black,
//             icon: const Icon(Icons.notifications_none),
//             onPressed: () {
//               // Navigate to notifications screen
//             },
//           ),
//         ],
//       ),
//       body: SafeArea(
//         child: FutureBuilder<UserModel?>(
//           future: _fetchUser(userId),
//           builder: (context, userSnapshot) {
//             if (userSnapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (userSnapshot.hasError) {
//               return const Center(child: Text('Error loading user data.'));
//             }
//             if (!userSnapshot.hasData || userSnapshot.data == null) {
//               return const Center(child: Text('No user data found.'));
//             }

//             UserModel user = userSnapshot.data!;
//             String? driverId = user.currentDriverId;

//             return FutureBuilder<Driver?>(
//               future: _fetchDriver(driverId),
//               builder: (context, driverSnapshot) {
//                 if (driverSnapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//                 if (driverSnapshot.hasError) {
//                   return const Center(
//                       child: Text('Error loading driver data.'));
//                 }

//                 Driver? driver = driverSnapshot.data;

//                 return SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildProfileSection(user),
//                         const SizedBox(height: 20),
//                         driver != null
//                             ? _buildDriverCard(driver)
//                             : _buildDriverCardPlaceholder(),
//                         const SizedBox(height: 5),
//                         _buildManageSection(),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Future<Driver?> _fetchDriver(String? driverId) async {
//     if (driverId == null || driverId.isEmpty) {
//       return null; // Return null if no driver is assigned
//     }

//     DocumentSnapshot<Map<String, dynamic>> driverSnapshot =
//         await FirebaseFirestore.instance
//             .collection('drivers')
//             .doc(driverId)
//             .get();

//     if (driverSnapshot.exists) {
//       return Driver.fromMap(driverSnapshot.data()!);
//     }
//     return null; // Return null if the driver doesn't exist
//   }

//   Future<UserModel?> _fetchUser(String userId) async {
//     return await FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .get()
//         .then((snapshot) =>
//             snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null);
//   }

//   Widget _buildProfileSection(UserModel user) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//       child: Row(
//         children: [
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   user.name,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     const Icon(Icons.pin_drop, size: 16, color: Colors.grey),
//                     const SizedBox(width: 4),
//                     Text(
//                       '${user.address}',
//                       style: TextStyle(color: Colors.grey[600]),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildManageSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Manage',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildManageCard(
//               icon: Icons.search_outlined,
//               label: 'Find Driver',
//               onTap: () {
//                 // Navigate to find driver screen
//                 Navigator.pushNamed(context, '/availableDrivers');
//               },
//             ),
//             _buildManageCard(
//               icon: Icons.location_on_outlined,
//               label: 'Set Pickup Point',
//               onTap: () {
//                 // Navigate to set pickup point screen
//                 Navigator.pushNamed(context, '/locationSelection');
//               },
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildManageCard(
//               icon: Icons.skip_next_outlined,
//               label: 'Skip a Ride',
//               onTap: () {
//                 // Navigate to skip ride screen
//               },
//             ),
//             _buildManageCard(
//               icon: Icons.history_outlined,
//               label: 'Ride History',
//               onTap: () {
//                 // Navigate to ride history screen
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildDriverCard(Driver driver) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: Colors.grey[200]!),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.grey[200],
//                   child: const Icon(Icons.person, size: 35, color: Colors.grey),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         driver.name,
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Vehicle: ${driver.vehicleNumber}',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         'Available Seats: ${driver.seats}',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton.icon(
//                   onPressed: () {
//                     // Handle call action
//                   },
//                   icon: const Icon(Icons.phone),
//                   label: const Text('Call'),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: const Color(0xFF0047BA),
//                     side: const BorderSide(color: Color(0xFF0047BA)),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Navigate to track driver screen
//                     // Navigator.push(
//                     //   context,
//                     //   MaterialPageRoute(
//                     //     builder: (context) => const TrackDriverScreen(),
//                     //   ),
//                     // );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF0047BA),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text('Track Your Driver'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDriverCardPlaceholder() {
//     return Container(
//       height: 150,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: const EdgeInsets.only(bottom: 16),
//       child: const Padding(
//           padding: EdgeInsets.all(16),
//           child: Center(
//             child: Text("No Driver Selected",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           )),
//     );
//   }

//   Widget _buildManageCard({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: SizedBox(
//           width: 150,
//           height: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 30, color: Colors.blue),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

=======
import 'OngoingTrip.dart';
import 'SafetyScreen.dart';
=======
import 'package:busbuddy/services/AuthService.dart';
import 'package:busbuddy/services/driverService.dart';
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../models/user.dart';
<<<<<<< HEAD
import '../../../services/driverService.dart';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
<<<<<<< HEAD
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? userBooking;
  final DriverService _driverService = DriverService();
  final UserService _userService = UserService();
  UserModel? _user;
=======
<<<<<<< HEAD
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
<<<<<<< HEAD
=======
<<<<<<< HEAD
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
  Map<String, dynamic>? userBooking;
  final DriverService _driverService = DriverService();
  // String status = 'pending';
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  Future<void> _fetchUserBookings() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user == null) return;

      final booking = await _driverService.fetchUserBooking(user.uid);
      setState(() {
        userBooking = booking;
<<<<<<< HEAD
      });
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  Future<void> _fetchUser() async {
    try {
      final user =
          await _userService.fetchUser(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        _user = user;
      });
    } catch (e) {
      print('Error fetching user: $e');
=======
<<<<<<< HEAD
=======
  List<Map<String, dynamic>> userBookings = [];
  final DriverService _driverService = DriverService();
  String status = 'pending';

  Future<void> _fetchUserBookings() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      final User? user = _auth.currentUser;

      if (user == null) return;

      final bookings = await _driverService.fetchUserBookings(user.uid);
      setState(() {
        userBookings = bookings;
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      });
    } catch (e) {
      print("Error fetching bookings: $e");
=======

      });
    } catch (e) {
      print("Error fetching bookings: $e");
=======
  final UserService _firebaseService = UserService();
  final DriverService _driverService = DriverService();
  UserModel? _user;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  Driver? _selectedDriver;
  Future<void> _fetchUserData() async {
    UserModel? user = await _firebaseService.fetchUser(userId);
    setState(() {
      _user = user;
    });

    // Fetch a driver from the Firestore 'drivers' collection
    DocumentSnapshot<Map<String, dynamic>> driverSnapshot =
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc(user!.currentDriverId)
            .get();

    if (driverSnapshot.exists) {
      Driver fetchedDriver = Driver.fromMap(driverSnapshot.data()!);
      setState(() {
        _selectedDriver = fetchedDriver;
      });
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    }
  }

  @override
  void initState() {
<<<<<<< HEAD
    _fetchUserBookings();
    _fetchUser();
    // final notificationService = NotificationService();
    // notificationService.showNotification(
    //   id: 0,
    //   title: 'Welcome to Bus Buddy!',
    //   body: 'Find a driver or schedule a ride.',
    // );
=======
<<<<<<< HEAD
    _fetchUserBookings();
<<<<<<< HEAD
=======

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
<<<<<<< HEAD
    _fetchUserBookings();
=======
    _fetchUserData();
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
<<<<<<< HEAD
      key: _scaffoldKey,
=======
<<<<<<< HEAD
<<<<<<< HEAD
      key: _scaffoldKey,
=======
      key: _scaffoldKey,
=======
    return Scaffold(
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
        elevation: 0,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
        //menu icon button
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.menu),
          onPressed: () {
<<<<<<< HEAD
            _scaffoldKey.currentState!.openDrawer();
=======
<<<<<<< HEAD
            _scaffoldKey.currentState!.openDrawer();
=======
<<<<<<< HEAD
            _scaffoldKey.currentState!.openDrawer();
=======
            // Navigate to menu screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          },
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Navigate to notifications screen
            },
          ),
        ],
      ),
<<<<<<< HEAD
      drawer: _buildCustomDrawer(context),
      body: SafeArea(
        child: StreamBuilder<UserModel?>(
=======
<<<<<<< HEAD
      drawer: _buildCustomDrawer(context),
      body: SafeArea(
        child: StreamBuilder<UserModel?>(
=======
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 50,
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          actions: [
            IconButton(
              color: Colors.black,
              icon: const Icon(Icons.notifications_none),
              onPressed: () {
                // Navigate to notifications screen
              },
            ),
          ],
        ),
        drawer: _buildCustomDrawer(context),
        body: SafeArea(
            child: StreamBuilder<UserModel?>(
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
<<<<<<< HEAD
      drawer: _buildCustomDrawer(context),
      body: SafeArea(
        child: StreamBuilder<UserModel?>(
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          stream: _userStream(userId),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (userSnapshot.hasError) {
              return const Center(child: Text('Error loading user data.'));
            }
            if (!userSnapshot.hasData || userSnapshot.data == null) {
              return const Center(child: Text('No user data found.'));
            }

            UserModel user = userSnapshot.data!;
            String? driverId = user.currentDriverId;

            return StreamBuilder<Driver?>(
              stream: _driverStream(driverId),
              builder: (context, driverSnapshot) {
                if (driverSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (driverSnapshot.hasError) {
                  return const Center(
                      child: Text('Error loading driver data.'));
                }
<<<<<<< HEAD
                Driver? driver = driverSnapshot.data;
=======
<<<<<<< HEAD
<<<<<<< HEAD
                Driver? driver = driverSnapshot.data;
=======

                Driver? driver = driverSnapshot.data;

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
                Driver? driver = driverSnapshot.data;
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileSection(user, screenWidth),
                        SizedBox(height: screenHeight * 0.03),
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                        if (driverId == null)
                          _buildDriverCardPlaceholder(screenWidth),
                        if (driver != null)
                          _buildDriverCardPending(driver, screenWidth),
                        // if (driver != null && status == 'confirmed')
                        // _buildDriverCard(driver, screenWidth),
<<<<<<< HEAD
                        SizedBox(height: screenHeight * 0.02),

=======
<<<<<<< HEAD
                        SizedBox(height: screenHeight * 0.02),

=======
                        if (driver != null && status == 'pending')
                          _buildDriverCardPending(driver, screenWidth),
                        if (driver != null && status != 'pending')
                          _buildDriverCard(driver, screenWidth),
                        if (driver == null)
                          _buildDriverCardPlaceholder(screenWidth),
                        SizedBox(height: screenHeight * 0.02),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======

                        SizedBox(height: screenHeight * 0.02),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                        _buildManageSection(screenWidth),
                      ],
                    ),
                  ),
                );
              },
            );
          },
<<<<<<< HEAD
        ),
      ),
    );
=======
<<<<<<< HEAD
<<<<<<< HEAD
        ),
      ),
    );
=======
        )));
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
        ),
      ),
    );
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  }

  Stream<UserModel?> _userStream(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null);
  }

  Stream<Driver?> _driverStream(String? driverId) {
    if (driverId == null || driverId.isEmpty) {
      return Stream.value(null);
    }
    return FirebaseFirestore.instance
        .collection('drivers')
        .doc(driverId)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? Driver.fromMap(snapshot.data()!) : null);
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
  Future<Driver?> _fetchDriver(String? driverId) async {
    if (driverId == null || driverId.isEmpty) {
      return null;
    }
    DocumentSnapshot<Map<String, dynamic>> driverSnapshot =
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc(driverId)
            .get();
    if (driverSnapshot.exists) {
      return Driver.fromMap(driverSnapshot.data()!);
    }
    return null;
  }

  Future<UserModel?> _fetchUser(String userId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((snapshot) =>
            snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null);
  }

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  Widget _buildProfileSection(UserModel user, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        children: [
<<<<<<< HEAD
          SizedBox(width: screenWidth * 0.04),
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
          CircleAvatar(
            radius: screenWidth * 0.08,
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, size: 35, color: Colors.grey),
          ),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
          SizedBox(width: screenWidth * 0.04),
=======
  
          SizedBox(width: screenWidth * 0.04),
=======
      body: _user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildProfileSection(),
                      const SizedBox(height: 20),
                      _selectedDriver != null
                          ? _buildDriverCard(_selectedDriver!)
                          : _buildDriverCardPlaceholder(),
                      const SizedBox(height: 5),
                      _buildManageSection(),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
  
  Widget _buildProfileSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                  user.name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: Text(
                        'PickUp: ${user.address}',
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01),
                  ],
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
                    SizedBox(
                      width: screenWidth * 0.75,
                      child: Text(
                        'Destination: ${user.dropOffLocation}',
<<<<<<< HEAD
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
=======
<<<<<<< HEAD
=======
                    const Icon(Icons.pin_drop, size: 16, color: Colors.grey),
                    SizedBox(width: screenWidth * 0.01),
                    Container(
                      width: screenWidth * 0.55,
                      child: Text(
                        '${user.address}',
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
=======
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
=======
                  _user!.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.pin_drop, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${_user!.address}',
                      style: TextStyle(color: Colors.grey[600]),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildDriverCardPending(Driver driver, double screenWidth) {
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
  Widget _buildDriverCard(Driver driver, double screenWidth) {
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.08,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Text(
                        'Vehicle: ${driver.vehicleNumber}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Text(
                        'Available Seats: ${driver.seats}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenWidth * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0047BA),
                    side: const BorderSide(color: Color(0xFF0047BA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
<<<<<<< HEAD
=======
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047BA),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Track Your Driver'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
  Widget _buildDriverCardPending(Driver driver, double screenWidth) {
    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
=======
  Widget _buildDriverCardPending(Driver driver, double screenWidth) {
    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
=======
  Widget _buildManageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Manage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildManageCard(
              icon: Icons.search_outlined,
              label: 'Find Driver',
              onTap: () {
                // Navigate to find driver screen
                Navigator.pushNamed(context, '/availableDrivers');
              },
            ),
            _buildManageCard(
              icon: Icons.location_on_outlined,
              label: 'Set Pickup Point',
              onTap: () {
                // Navigate to set pickup point screen
                Navigator.pushNamed(context, '/locationSelection');
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildManageCard(
              icon: Icons.skip_next_outlined,
              label: 'Skip a Ride',
              onTap: () {
                // Navigate to skip ride screen
              },
            ),
            _buildManageCard(
              icon: Icons.history_outlined,
              label: 'Ride History',
              onTap: () {
                // Navigate to ride history screen
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDriverCard(Driver driver) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
<<<<<<< HEAD
        padding: EdgeInsets.all(screenWidth * 0.04),
=======
<<<<<<< HEAD
        padding: EdgeInsets.all(screenWidth * 0.04),
=======
        padding: const EdgeInsets.all(16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                  radius: screenWidth * 0.08,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                SizedBox(width: screenWidth * 0.04),
<<<<<<< HEAD
=======
=======
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                const SizedBox(width: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
<<<<<<< HEAD
=======
=======
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                      Text(
                        'Vehicle: ${driver.vehicleNumber}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
<<<<<<< HEAD
                      SizedBox(height: screenWidth * 0.02),
=======
<<<<<<< HEAD
                      SizedBox(height: screenWidth * 0.02),
=======
                      const SizedBox(height: 4),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                      Text(
                        'Available Seats: ${driver.seats}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
            SizedBox(height: screenWidth * 0.04),
=======
<<<<<<< HEAD
            SizedBox(height: screenWidth * 0.04),
=======
            const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
<<<<<<< HEAD
                  onPressed: () {},
=======
<<<<<<< HEAD
                  onPressed: () {},
=======
                  onPressed: () {
                    // Handle call action
                  },
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0047BA),
                    side: const BorderSide(color: Color(0xFF0047BA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                //Track your driver button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const TrackDriver();
                    }));
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text('Track Driver'),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047BA),
<<<<<<< HEAD
=======
<<<<<<< HEAD
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
=======
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenWidth * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Pending',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
                    ),
                  ),
=======
=======
                ElevatedButton(
                  onPressed: () {
                    // Navigate to track driver screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const TrackDriverScreen(),
                    //   ),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047BA),
                    foregroundColor: Colors.white,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
                  child: const Text('Track Your Driver'),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildDriverCardPlaceholder(double screenWidth) {
    return Container(
      height: screenWidth * 0.3,
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
  Future<void> _cancelBooking(String bookingId) async {
    try {
      await _driverService.cancelBooking(bookingId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking successfully canceled')),
      );
      _fetchUserBookings(); // Refresh bookings
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to cancel booking: $e')),
      );
    }
  }

  Widget _buildPendingRequestCard(double screenWidth) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('pending_requests')
          .doc(
              'singleRequest') // assuming you have a specific doc for the pending request
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching request.'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No pending requests.'));
        }

        var request = snapshot.data!.data() as Map<String, dynamic>;

        return Card(
          margin: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey[200]!),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pending Request',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.02),
                Text('Name: ${request['name']}'),
                Text('Pickup Point: ${request['pickup_point']}'),
                Text('Destination: ${request['destination']}'),
                SizedBox(height: screenWidth * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle approve
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Approve'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Handle decline
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Decline'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
  Widget _buildDriverCardPlaceholder(double screenWidth) {
    return Container(
      height: screenWidth * 0.3,
=======
  Widget _buildDriverCardPlaceholder(double screenWidth) {
    return Container(
      height: screenWidth * 0.3,
=======
  Widget _buildDriverCardPlaceholder() {
    return Container(
      height: 150,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: const Center(
        child: Text(
          "No Driver Selected",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildManageSection(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenWidth * 0.03),
        Wrap(
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
            spacing: screenWidth * 0.02,
            runSpacing: screenWidth * 0.02,
            children: [
              if (userBooking == null) ...[
                // If there are no bookings, show the "Find Driver" and "Set Pickup Point" cards.
                _buildManageCard(
                  icon: Icons.search_outlined,
                  label: 'Find Driver',
                  onTap: () {
                    Navigator.pushNamed(context, '/availableDrivers');
                  },
                  screenWidth: screenWidth,
                ),
                _buildManageCard(
                  icon: Icons.location_on_outlined,
                  label: 'Set Pickup Point',
                  onTap: () {
                    Navigator.pushNamed(context, '/locationSelection');
                  },
                  screenWidth: screenWidth,
                ),
              ] else if (userBooking?['status'] != 'confirmed') ...[
                // If bookings exist but the status is not 'confirmed', show the same cards.
                _buildManageCard(
                  icon: Icons.search_outlined,
                  label: 'Find Driver',
                  onTap: () {
                    Navigator.pushNamed(context, '/availableDrivers');
                  },
                  screenWidth: screenWidth,
                ),
                _buildManageCard(
                  icon: Icons.location_on_outlined,
                  label: 'Set Pickup Point',
                  onTap: () {
                    Navigator.pushNamed(context, '/locationSelection');
                  },
                  screenWidth: screenWidth,
                )
              ],
              _buildManageCard(
                icon: Icons.schedule_outlined,
                label: 'Schedule Ride',
                onTap: () {
                  Navigator.pushNamed(context, '/schedule');
                },
                screenWidth: screenWidth,
              ),
              _buildManageCard(
                icon: Icons.history_outlined,
                label: 'Ride History',
                onTap: () {
                  Navigator.pushNamed(context, '/rideHistory');
                },
                screenWidth: screenWidth,
              ),
              _buildManageCard(
                icon: Icons.book_outlined,
                label: 'Booking Requests',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DriverBookingDetail();
                  }));
                },
                screenWidth: screenWidth,
              ),
              _buildManageCard(
                icon: Icons.safety_check_outlined,
                label: 'Safety',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SafetyScreen();
                  }));
                },
                screenWidth: screenWidth,
              ),
            ]),
        if (userBooking != null && userBooking?['status'] == 'confirmed') ...[
          GestureDetector(
<<<<<<< HEAD
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
=======
            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) {
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
              return const LocationPickerScreen();
            })),
            child: Container(
              // set pick up point and destination
              width: double.infinity,
              margin: EdgeInsets.only(top: screenWidth * 0.04),
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.04,
                horizontal: screenWidth * 0.03,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: screenWidth * 0.08, color: Colors.blue),
                  SizedBox(width: screenWidth * 0.07),
                  Text(
                    "Set Pick Up Point and Destination",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
<<<<<<< HEAD
      ],
=======
=======
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
          children: [
            _buildManageCard(
              icon: Icons.search_outlined,
              label: 'Find Driver',
              onTap: () {
                Navigator.pushNamed(context, '/availableDrivers');
=======
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
          children: [
            if (userBooking == null) ...[
              // If there are no bookings, show the "Find Driver" and "Set Pickup Point" cards.
              _buildManageCard(
                icon: Icons.search_outlined,
                label: 'Find Driver',
                onTap: () {
                  Navigator.pushNamed(context, '/availableDrivers');
                },
                screenWidth: screenWidth,
              ),
              _buildManageCard(
                icon: Icons.location_on_outlined,
                label: 'Set Pickup Point',
                onTap: () {
                  Navigator.pushNamed(context, '/locationSelection');
                },
                screenWidth: screenWidth,
              ),
            ] else if (userBooking?['status'] != 'confirmed') ...[
              // If bookings exist but the status is not 'confirmed', show the same cards.
              _buildManageCard(
                icon: Icons.search_outlined,
                label: 'Find Driver',
                onTap: () {
                  Navigator.pushNamed(context, '/availableDrivers');
                },
                screenWidth: screenWidth,
              ),
              _buildManageCard(
                icon: Icons.location_on_outlined,
                label: 'Set Pickup Point',
                onTap: () {
                  Navigator.pushNamed(context, '/locationSelection');
                },
                screenWidth: screenWidth,
              )
            ],
            _buildManageCard(
              icon: Icons.schedule_outlined,
              label: 'Schedule Ride',
              onTap: () {
                Navigator.pushNamed(context, '/schedule');
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
              },
              screenWidth: screenWidth,
            ),
            _buildManageCard(
<<<<<<< HEAD
              icon: Icons.location_on_outlined,
              label: 'Set Pickup Point',
              onTap: () {
                Navigator.pushNamed(context, '/locationSelection');
              },
              screenWidth: screenWidth,
            ),
            _buildManageCard(
              icon: Icons.skip_next_outlined,
              label: 'Skip a Ride',
              onTap: () {},
              screenWidth: screenWidth,
            ),
            _buildManageCard(
              icon: Icons.history_outlined,
              label: 'Ride History',
              onTap: () {},
              screenWidth: screenWidth,
            ),
            //Section for the Driver Pending Request
            userBookings.isEmpty
                ? const Center(
                    child: Text('No bookings found'),
                  )
                : ListTile(
                    leading: const Icon(Icons.book_online),
                    title: Text('Driver ID: ${userBookings[0]['driver_id']}'),
                    subtitle: Text(
                        'Status: ${userBookings[0]['status']}\nPickup: ${userBookings[0]['pickup_location']}\nDropoff: ${userBookings[0]['dropoff_location']}'),
                    trailing: userBookings[0]['status'] == 'pending'
                        ? ElevatedButton(
                            onPressed: () =>
                                _cancelBooking(userBookings[0]['id']),
                            child: const Text('Cancel'),
                          )
                        : null,
                  ),
          ],
        ),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      ],
=======
              icon: Icons.history_outlined,
              label: 'Ride History',
              onTap: () {
                Navigator.pushNamed(context, '/rideHistory');
              },
              screenWidth: screenWidth,
            ),
            _buildManageCard(
              icon: Icons.book_outlined,
              label: 'Booking Requests',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DriverBookingDetail();
                }));
              },
              screenWidth: screenWidth,
            ),
            _buildManageCard(
              icon: Icons.safety_check_outlined,
              label: 'Safety',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SafetyScreen();
                }));
              },
              screenWidth: screenWidth,
            ),
          ],
        ),
      ],
=======
      margin: const EdgeInsets.only(bottom: 16),
      child: const Padding(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Text("No Driver Selected",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          )),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    );
  }

  Widget _buildManageCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (screenWidth - (screenWidth * 0.1)) / 2,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.04,
          horizontal: screenWidth * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: screenWidth * 0.08, color: Colors.blue),
            SizedBox(height: screenWidth * 0.02),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 150,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        ),
      ),
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  Widget _buildCustomDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Custom Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: const Icon(
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                    Icons.person,
                    size: 50,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
<<<<<<< HEAD
                      Text(
                        _user?.name ?? 'John Doe',
=======
                      const Text(
                        'John Doe',
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
<<<<<<< HEAD
                        _user?.email ?? '',
=======
                        'john.doe@example.com',
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
                _buildDrawerItem(
                  icon: Icons.home_outlined,
                  title: 'Home',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.search_outlined,
                  title: 'Find a Driver',
                  onTap: () {
                    Navigator.pushNamed(context, '/availableDrivers');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.history_outlined,
                  title: 'Ride History',
                  onTap: () {
                    Navigator.pushNamed(context, '/rideHistory');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment',
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                _buildDrawerItem(
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
              onPressed: () {
                // Handle logout functionality
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: const Icon(Icons.logout, size: 20),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
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

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
}
