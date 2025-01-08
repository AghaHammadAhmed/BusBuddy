<<<<<<< HEAD
// ignore_for_file: prefer_const_constructors
import 'package:busbuddy/models/user.dart';
import 'package:busbuddy/views/screens/DriverScreen/DriverPickUpLocation.dart';
import 'package:busbuddy/views/widgets/CustomDrawer.dart';
import 'package:busbuddy/views/widgets/ManageCard.dart';
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
// ignore_for_file: prefer_const_constructors
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import 'DriverMapView.dart';
import 'PendingStudentRequest.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../../models/driver.dart';
// import 'DriverMapView.dart';

// class DriverHomePage extends StatefulWidget {
//   const DriverHomePage({super.key});

//   @override
//   _DriverHomePageState createState() => _DriverHomePageState();
// }

// class _DriverHomePageState extends State<DriverHomePage> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   FirebaseAuth userCredential = FirebaseAuth.instance;
//   List<Map<String, dynamic>> _students = []; // List of students
//   @override
//   void initState() {
//     super.initState();
//     _loadDriver();
//   }

//   Driver? _driver; // Driver instance
//   bool _isLoading = true; // Loading state

//   Future<Driver?> _fetchDriverByUserId() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
//           .collection('drivers')
//           .where('userID', isEqualTo: userCredential.currentUser!.uid)
//           .limit(1) // Fetch only one document
//           .get();

//       if (driverQuery.docs.isNotEmpty) {
//         final driverData = driverQuery.docs.first.data();
//         print("Driver fetched: ${driverData}");
//         return Driver.fromJson(driverData); // Convert to Driver object
//       }
//       print("No driver found.");
//       return null; // No driver found
//     } catch (e) {
//       print("Failed to fetch driver: $e");
//       return null;
//     }
//   }

//   Future<void> _fetchStudents(String driverId) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> studentQuery = await _firestore
//           .collection('users')
//           .where('role', isEqualTo: 'student') // Filter by role
//           .where('currentDriverId', isEqualTo: driverId) // Match driver ID
//           .get();

//       if (studentQuery.docs.isNotEmpty) {
//         setState(() {
//           _students = studentQuery.docs
//               .map((doc) => doc.data()) // Convert documents to map
//               .toList();
//         });
//         print("Students fetched: ${_students.length}");
//       } else {
//         print("No students found.");
//       }
//     } catch (e) {
//       print("Failed to fetch students: $e");
//     }
//   }

//   Future<void> _loadDriver() async {
//     try {
//       Driver? fetchedDriver = await _fetchDriverByUserId();

//       if (fetchedDriver != null) {
//         await _fetchStudents(fetchedDriver.driverID);
//       }
//       setState(() {
//         _driver = fetchedDriver;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
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
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _driver == null
//               ? const Center(child: Text('No driver found.'))
//               : SafeArea(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildProfileSection(_driver!),
//                           const SizedBox(height: 20),
//                           _buildStudentsSection(),
//                           const SizedBox(height: 20),
//                           _buildManageSection(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//     );
//   }

//   Widget _buildStudentsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Your Rides',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         _students.isEmpty
//             ? //placeholder for no students allocated with 200 height
//             SizedBox(height: 200, child: const Center(child: Text('No rides', style: TextStyle(fontSize: 16))))
//             : SizedBox(
//                 height: 320,
//                 child: SingleChildScrollView(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _students.length,
//                     itemBuilder: (context, index) {
//                       final student = _students[index];
//                       return Card(
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           child: ListTile(
//                               leading:
//                                   const Icon(Icons.person, color: Colors.blue),
//                               title: Text(
//                                 student['name'],
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('pick Up: ${student['address']}'),
//                                   //button to call on left and track on right
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           // Call student
//                                         },
//                                         //elevated Style
//                                         style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                         child: const Text('Call'),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )));
//                     },
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _buildProfileSection(Driver driver) {
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
//                   driver.name,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.orange, size: 16),
//                     SizedBox(width: 4),
//                     Text(
//                       '${driver.rating} Rating',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Vehicle: ${driver.vehicleNumber}',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
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
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildManageCard(
//               icon: Icons.map_outlined,
//               label: 'Map View',
//               onTap: () {
//                 // Navigate to map screen
//                 print("Driver ID: ${_driver!.driverID}");
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DriverLiveLocation(
//                               driverId: _driver!.driverID,
//                             )));
//               },
//             ),
//             _buildManageCard(
//               icon: Icons.schedule_outlined,
//               label: 'Schedule',
//               onTap: () {
//                 // Navigate to schedule screen
//               },
//             ),
//             _buildManageCard(
//               icon: Icons.message_outlined,
//               label: 'Messages',
//               onTap: () {
//                 // Navigate to message screen
//               },
//             ),
//           ],
//         ),
//       ],
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
//           width: 100,
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

// ignore_for_file: prefer_const_constructors

=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import 'DriverMapView.dart';
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
<<<<<<< HEAD
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final DriverService _driverService = DriverService();
  // List<Map<String, dynamic>> _students = [];
  // List<Map<String, dynamic>> _bookingRequests = [];
  UserModel? _user;

  Driver? _driver;
  bool _isLoading = true;
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
<<<<<<< HEAD
  // final DriverService _driverService = DriverService();
  // List<Map<String, dynamic>> _students = [];
  // List<Map<String, dynamic>> _bookingRequests = [];
=======
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> _bookingRequests = [];
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e

  Driver? _driver;
  bool _isLoading = true;
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final DriverService _driverService = DriverService();
  // List<Map<String, dynamic>> _students = [];
  // List<Map<String, dynamic>> _bookingRequests = [];

  Driver? _driver;
  bool _isLoading = true;
<<<<<<< HEAD
=======
=======
  final List<Map<String, dynamic>> _rides = [
    {
      'studentName': 'Shaheen ghani',
      'pickupLocation': 'Perfume chowk',
      'destination': 'ABC School',
      'time': '7:30 AM',
      'status': 'Scheduled'
    },
    {
      'studentName': 'Virat kholi',
      'pickupLocation': 'Anda mor',
      'destination': 'XYZ School',
      'time': '8:00 AM',
      'status': 'Completed'
    },
  ];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth userCredential = FirebaseAuth.instance;
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c

  @override
  void initState() {
    super.initState();
    _loadDriver();
<<<<<<< HEAD
    _fetchUser();
  }

=======
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
  Driver? _driver; // Driver instance
  bool _isLoading = true; // Loading state

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
  Future<Driver?> _fetchDriverByUserId() async {
    try {
      QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
          .collection('drivers')
<<<<<<< HEAD
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
=======
<<<<<<< HEAD
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
=======
<<<<<<< HEAD
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
=======
<<<<<<< HEAD
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
=======
          .where('userID', isEqualTo: userCredential.currentUser!.uid)
          .limit(1) // Fetch only one document
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
          .get();

      if (driverQuery.docs.isNotEmpty) {
        final driverData = driverQuery.docs.first.data();
<<<<<<< HEAD
        return Driver.fromJson(driverData);
      }
      return null;
=======
<<<<<<< HEAD
        return Driver.fromJson(driverData);
      }
      return null;
=======
<<<<<<< HEAD
        return Driver.fromJson(driverData);
      }
      return null;
=======
<<<<<<< HEAD
        return Driver.fromJson(driverData);
      }
      return null;
=======
        print("Driver fetched: ${driverData}");
        return Driver.fromJson(driverData); // Convert to Driver object
      }
      print("No driver found.");
      return null; // No driver found
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
    } catch (e) {
      print("Failed to fetch driver: $e");
      return null;
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
  Future<void> _fetchStudents(String driverId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> studentQuery = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'student')
          .where('currentDriverId', isEqualTo: driverId)
          .get();

      if (studentQuery.docs.isNotEmpty) {
        setState(() {
<<<<<<< HEAD
          // _students = studentQuery.docs.map((doc) => doc.data()).toList();
=======
<<<<<<< HEAD
          // _students = studentQuery.docs.map((doc) => doc.data()).toList();
=======
<<<<<<< HEAD
<<<<<<< HEAD
          // _students = studentQuery.docs.map((doc) => doc.data()).toList();
=======
          _students = studentQuery.docs.map((doc) => doc.data()).toList();
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
          // _students = studentQuery.docs.map((doc) => doc.data()).toList();
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
        });
      }
    } catch (e) {
      print("Failed to fetch students: $e");
    }
  }

  Future<void> _fetchBookingRequests(String driverId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> bookingQuery = await _firestore
          .collection('booking_requests')
          .where('driver_id', isEqualTo: driverId)
          .where('status', isEqualTo: 'pending')
          .get();

      if (bookingQuery.docs.isNotEmpty) {
        setState(() {
<<<<<<< HEAD
          // _bookingRequests = bookingQuery.docs
          //     .map((doc) => {'id': doc.id, ...doc.data()})
          //     .toList();
=======
<<<<<<< HEAD
          // _bookingRequests = bookingQuery.docs
          //     .map((doc) => {'id': doc.id, ...doc.data()})
          //     .toList();
=======
<<<<<<< HEAD
<<<<<<< HEAD
          // _bookingRequests = bookingQuery.docs
          //     .map((doc) => {'id': doc.id, ...doc.data()})
          //     .toList();
=======
          _bookingRequests = bookingQuery.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList();
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
          // _bookingRequests = bookingQuery.docs
          //     .map((doc) => {'id': doc.id, ...doc.data()})
          //     .toList();
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
        });
      }
    } catch (e) {
      print("Failed to fetch booking requests: $e");
    }
  }

  Future<void> _loadDriver() async {
    try {
      Driver? fetchedDriver = await _fetchDriverByUserId();
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
      if (fetchedDriver != null) {
        await _fetchStudents(fetchedDriver.driverID);
        await _fetchBookingRequests(fetchedDriver.driverID);
      }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
  Future<void> _loadDriver() async {
    try {
      Driver? fetchedDriver = await _fetchDriverByUserId();
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
      setState(() {
        _driver = fetchedDriver;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
  Future<void> _respondToBooking(String bookingId, bool isAccepted) async {
    try {
      await _firestore.collection('booking_requests').doc(bookingId).update({
        'status': isAccepted ? 'accepted' : 'rejected',
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isAccepted
            ? 'Booking accepted successfully!'
            : 'Booking rejected.'),
      ));

      await _fetchBookingRequests(_driver!.driverID);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to respond to booking: $e')),
      );
    }
  }

<<<<<<< HEAD
  // fetch user
  Future<void> _fetchUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          setState(() {
            _user = UserModel.fromJson(userDoc.data()!);
          });
        }
      }
    } catch (e) {
      print("Failed to fetch user: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
=======
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
=======
<<<<<<< HEAD
<<<<<<< HEAD
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
=======
  @override
  Widget build(BuildContext context) {
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    return Scaffold(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
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
<<<<<<< HEAD
=======
        //menu icon button
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.menu),
          onPressed: () {
<<<<<<< HEAD
            _scaffoldKey.currentState!.openDrawer();
=======
            // Navigate to menu screen
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
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
      drawer: buildCustomDrawer(context, _user),
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _driver == null
              ? const Center(child: Text('No driver found.'))
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
<<<<<<< HEAD
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
=======
<<<<<<< HEAD
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
=======
<<<<<<< HEAD
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
<<<<<<< HEAD
=======
<<<<<<< HEAD
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                          _buildStudentsSection(_driver!.driverID),
                          const SizedBox(height: 20),
                          // _buildBookingRequestsSection(),
                          const SizedBox(height: 20),
                          _buildManageSection(screenWidth),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
                          _buildStudentsSection(),
                          const SizedBox(height: 20),
                          _buildBookingRequestsSection(),
                          const SizedBox(height: 20),
                          // _buildManageSection(),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
                          if (_isLoading) ...[
                            const LinearProgressIndicator(),
                            const SizedBox(height: 8),
                          ],
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
                          _buildRidesSection(),
                          const SizedBox(height: 20),
                          _buildManageSection(),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildProfileSection(Driver driver) {
    return Padding(
<<<<<<< HEAD
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
=======
<<<<<<< HEAD
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
=======
<<<<<<< HEAD
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
=======
<<<<<<< HEAD
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
=======
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.name,
<<<<<<< HEAD
                  style: const TextStyle(
=======
<<<<<<< HEAD
                  style: const TextStyle(
=======
<<<<<<< HEAD
                  style: const TextStyle(
=======
<<<<<<< HEAD
                  style: const TextStyle(
=======
                  style: TextStyle(
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${driver.rating} Rating',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Vehicle: ${driver.vehicleNumber}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
  Widget _buildStudentsSection(String driverId) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore
          .collection('users')
          .where('role', isEqualTo: 'student')
          .where('currentDriverId', isEqualTo: driverId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 200,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return SizedBox(
            height: 200,
            child: const Center(
              child: Text(
                'No rides',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        final students = snapshot.data!.docs.map((doc) => doc.data()).toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: students.length,
          itemBuilder: (context, index) {
            final student = students[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: Text(
                  student['name'] ?? 'Unknown',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Pickup: ${student['address'] ?? 'No Address'}'),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildManageSection(double screenWidth) {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
  Widget _buildStudentsSection() {
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
  Widget _buildRidesSection() {
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
<<<<<<< HEAD
<<<<<<< HEAD
          'Manage',
=======
          'Your Rides',
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
          'Your Rides',
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
<<<<<<< HEAD
<<<<<<< HEAD
=======
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _rides.length,
          itemBuilder: (context, index) {
            final ride = _rides[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: const Icon(Icons.directions_bus, color: Colors.blue),
                title: Text(
                  ride['studentName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pickup: ${ride['pickupLocation']}'),
                    Text('Drop: ${ride['destination']}'),
                    Text('Time: ${ride['time']}'),
                  ],
                ),
                trailing: Text(
                  ride['status'],
                  style: TextStyle(
                    fontSize: 12,
                    color: ride['status'] == 'Completed'
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Navigate to ride details screen
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildManageSection() {
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
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
<<<<<<< HEAD
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildManageCard(
=======
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildManageCard(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
              screenWidth: screenWidth,
              icon: Icons.map_outlined,
              label: 'Map View',
              onTap: () {
<<<<<<< HEAD
=======
                
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
              icon: Icons.map_outlined,
              label: 'Map View',
              onTap: () {
                // Navigate to map screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriverLiveLocation(
<<<<<<< HEAD
                              driverId: _driver!.driverID,
                            )));
              },
            ),
            buildManageCard(
              screenWidth: screenWidth,
=======
<<<<<<< HEAD
                              driverId: _driver!.driverID,
=======
<<<<<<< HEAD
                              driverId: _driver!.driverID,
=======
<<<<<<< HEAD
                              driverId: _driver!.driverID,
=======
                            driverId: _driver!.driverID,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                            )));
              },
            ),
            _buildManageCard(
<<<<<<< HEAD
              screenWidth: screenWidth,
=======
<<<<<<< HEAD
              screenWidth: screenWidth,
=======
<<<<<<< HEAD
              screenWidth: screenWidth,
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
              icon: Icons.schedule_outlined,
              label: 'Schedule',
              onTap: () {
                // Navigate to schedule screen
              },
            ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
<<<<<<< HEAD
            buildManageCard(
=======
            _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
              screenWidth: screenWidth,
              icon: Icons.book_outlined,
              label: 'Booking Requests',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingStudentReqeust()));
              },
            ),
<<<<<<< HEAD
            buildManageCard(
=======
            _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
              screenWidth: screenWidth,
              icon: Icons.history,
              label: 'Ride History',
              onTap: () {
                // Navigate to ride history screen
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
            _buildManageCard(
              icon: Icons.message_outlined,
              label: 'Messages',
              onTap: () {
                // Navigate to message screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
              },
            ),
          ],
        ),
<<<<<<< HEAD
        buildManageCard(
          screenWidth: screenWidth,
          icon: Icons.map_outlined,
          label: 'Pick Up',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DriverPickUpLocation(  
                    )
                    ));
          },
        ),
      ],
    );
  }
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
        _students.isEmpty
            ? SizedBox(
                height: 200,
                child: const Center(
                  child: Text(
                    'No rides',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: Text(
                        student['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Pickup: ${student['address']}'),
                    ),
                  );
                },
              ),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      ],
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
        ),
      ),
=======
<<<<<<< HEAD
        ),
      ),
=======
  Widget _buildBookingRequestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking Requests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _firestore
              .collection('booking_requests')
              .where('driver_id', isEqualTo: _driver?.driverID)
              .where('status', isEqualTo: 'pending')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching booking requests.'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'No booking requests at the moment.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }

            final bookingRequests = snapshot.data!.docs
                .map((doc) => {'id': doc.id, ...doc.data()})
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookingRequests.length,
              itemBuilder: (context, index) {
                final booking = bookingRequests[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading:
                        const Icon(Icons.directions_car, color: Colors.blue),
                    title: Text('Pickup: ${booking['pickup_location']}'),
                    subtitle: Text('Dropoff: ${booking['dropoff_location']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              _respondToBooking(booking['id'], true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Accept'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () =>
                              _respondToBooking(booking['id'], false),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Reject'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
=======
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 100,
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
        ),
      ),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    );
  }
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
}
