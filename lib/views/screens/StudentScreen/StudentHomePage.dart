<<<<<<< HEAD
// import 'dart:convert';
// import 'dart:developer';

// import 'package:busbuddy/services/AuthService.dart';
// import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
// import 'package:busbuddy/views/widgets/CustomAppBar.dart';
// import 'package:busbuddy/views/widgets/CustomDrawer.dart';
// import 'package:busbuddy/views/widgets/ManageCard.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../models/driver.dart';
// import '../../../models/user.dart';
// import '../../../services/driverService.dart';
// import 'LocationSelection.dart';
// import 'OngoingTrip.dart';
// import 'SafetyScreen.dart';

// class StudentHomePage extends StatefulWidget {
//   const StudentHomePage({super.key});

//   @override
//   _StudentHomePageState createState() => _StudentHomePageState();
// }

// class _StudentHomePageState extends State<StudentHomePage> {
//   String userId = FirebaseAuth.instance.currentUser!.uid;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   Map<String, dynamic>? userBooking;
//   final DriverService _driverService = DriverService();
//   final UserService _userService = UserService();
//   final DatabaseReference _ridesRef =
//       FirebaseDatabase.instance.ref().child('rides');
//   final DatabaseReference _tripUpdate =
//       FirebaseDatabase.instance.ref().child('tripUpdates');

//   final DatabaseReference _reference = FirebaseDatabase.instance.ref();
//   UserModel? _user;
//   final CollectionReference _userCollection =
//       FirebaseFirestore.instance.collection('users');
//   final CollectionReference _bookingRequestCollection =
//       FirebaseFirestore.instance.collection('booking_requests');

//   Future<void> fetchUser() async {
//     final userDoc = await _userService.fetchUser(userId);
//     setState(() {
//       _user = userDoc;
//     });
//   }

//   Future<void> _fetchUserBookings() async {
//     try {
//       final FirebaseAuth auth = FirebaseAuth.instance;
//       final User? user = auth.currentUser;
//       if (user == null) return;

//       final booking = await _driverService.fetchUserBooking(user.uid);
//       setState(() {
//         userBooking = booking;
//       });
//     } catch (e) {
//       print("Error fetching bookings: $e");
//     }
//   }

//   Future<String?> fetchCurrentDriverId(String userId) async {
//     final userDoc =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     return userDoc.data()?['currentDriverId'] as String?;
//   }

//   //stream the data from the realtime database to get the estimated time of arrival

//   Stream<Map<String, dynamic>?> streamUserBooking(String userId) async* {
//     final currentDriverId = await fetchCurrentDriverId(userId);
//     if (currentDriverId == null) {
//       yield null; // No driver assigned, stream emits null
//       return;
//     }

//     yield* _userCollection
//         .where("userID", isEqualTo: userId)
//         .where("currentDriverId", isEqualTo: currentDriverId)
//         .limit(1)
//         .snapshots()
//         .asyncMap((querySnapshot) async {
//       log("QuerySnapshot: ${querySnapshot.docs.length}");
//       if (querySnapshot.docs.isNotEmpty) {
//         final doc = querySnapshot.docs.first;
//         final data = {'id': doc.id, ...doc.data() as Map<String, dynamic>};
//         // log("Data: $data");
//         // Fetch trip updates from Realtime Database
//         final tripUpdates = await fetchTripUpdates(userId);
//         if (tripUpdates != null) {
//           data['tripUpdates'] = tripUpdates;
//           log("Trip ${tripUpdates['estimatedTime']}");
//         }

//         return data;
//       }
//       return null;
//     });
//   }

//   Future<Map<String, dynamic>?> fetchTripUpdates(String userId) async {
//     try {
//       final snapshot = await _reference.child("tripUpdates/$userId").get();
//       log("Snapshot: ${snapshot.value}");
//       if (snapshot.exists) {
//         return snapshot.value as Map<String, dynamic>;
//       }
//     } catch (e) {
//       log("Error fetching trip updates: $e");
//     }
//     return null;
//   }

//   @override
//   void initState() {
//     _fetchUserBookings();
//     // _fetchUser();
//     fetchUser();
//     // fetchTripUpdates(userId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: buildCustomDrawer(context, _user),
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () async {
//             await fetchUser();
//             await _fetchUserBookings();
//           },
//           child: Column(
//             children: [
//               customAppBar(screenWidth, screenHeight, _scaffoldKey),
//               Expanded(
//                 child: StreamBuilder<UserModel?>(
//                   stream: _userStream(userId),
//                   builder: (context, userSnapshot) {
//                     if (userSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (userSnapshot.hasError) {
//                       return const Center(
//                           child: Text('Error loading user data.'));
//                     }
//                     if (!userSnapshot.hasData || userSnapshot.data == null) {
//                       return const Center(child: Text('No user data found.'));
//                     }

//                     UserModel user = userSnapshot.data!;
//                     String? driverId = user.currentDriverId;

//                     return StreamBuilder<Driver?>(
//                       stream: _driverStream(driverId),
//                       builder: (context, driverSnapshot) {
//                         if (driverSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//                         if (driverSnapshot.hasError) {
//                           return const Center(
//                               child: Text('Error loading driver data.'));
//                         }
//                         Driver? driver = driverSnapshot.data;

//                         return StreamBuilder<Map<String, dynamic>?>(
//                           stream: streamUserBooking(userId),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                   child: CircularProgressIndicator());
//                             }
//                             if (snapshot.hasError) {
//                               return Center(
//                                   child: Text("Error: ${snapshot.error}"));
//                             }
//                             final userBooking = snapshot.data;
//                             log("UserBooking: $userBooking");
//                             final tripUpdates = userBooking?["tripUpdates"]
//                                 as Map<String, dynamic>?;
//                             log("TripUpdates: $tripUpdates");
//                             final estimatedTime =
//                                 tripUpdates?['estimatedTime'] ?? "N/A";

//                             return Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: screenWidth * 0.04,
//                                 vertical: screenWidth * 0.04,
//                               ),
//                               child: Column(
//                                 // crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   _buildProfileSection(user, screenWidth),
//                                   const SizedBox(height: 10),
//                                   if (userBooking != null &&
//                                       userBooking['status'] == 'pending')
//                                     _buildDriverCardPending(screenWidth)
//                                   else if (driver != null ||
//                                       userBooking != null)
//                                     _buildDriverCard(
//                                         driver!, screenWidth, estimatedTime)
//                                   else
//                                     _buildDriverCardPlaceholder(screenWidth),
//                                   const SizedBox(height: 10),
//                                   _buildManageSection(screenWidth),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Stream<UserModel?> _userStream(String userId) {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .doc(userId)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.exists ? UserModel.fromMap(snapshot.data()!) : null);
//   }

//   Stream<Driver?> _driverStream(String? driverId) {
//     if (driverId == null || driverId.isEmpty) {
//       return Stream.value(null);
//     }
//     return FirebaseFirestore.instance
//         .collection('drivers')
//         .doc(driverId)
//         .snapshots()
//         .map((snapshot) =>
//             snapshot.exists ? Driver.fromMap(snapshot.data()!) : null);
//   }

//   Future<void> _makePhoneCall(String phoneNumber) async {
//     final Uri callUri = Uri.parse(phoneNumber);

//     if (await canLaunchUrl(callUri)) {
//       await launchUrl(callUri);
//     } else {
//       // Handle the case where the phone call cannot be initiated
//       throw 'Could not launch $phoneNumber';
//     }
//   }

//   Widget _buildProfileSection(UserModel user, double screenWidth) {
//     return Card(
//       color: const Color(0xFF8A1538),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.04,
//           vertical: screenWidth * 0.03,
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundImage: user.profilePicture != null
//                   ? MemoryImage(base64Decode(user.profilePicture!))
//                   : null,
//               radius: screenWidth * 0.08,
//               //image is 8bit image
//               backgroundColor: Colors.white,
//             ),
//             SizedBox(width: screenWidth * 0.04),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     user.name,
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.05,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: screenWidth * 0.02),
//                   Text(
//                     'PickUp: ${user.address}',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.035,
//                       color: Colors.white70,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: screenWidth * 0.01),
//                   Text(
//                     'Destination: ${user.school}',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.035,
//                       color: Colors.white70,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _showRemoveDriverDialog() async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button to dismiss
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text(
//             'Remove Driver',
//             style: TextStyle(color: const Color(0xFF8A1538)),
//           ),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('Do you want to remove the driver?',
//                     style: TextStyle(color: const Color(0xFF8A1538))),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel',
//                   style: TextStyle(color: const Color(0xFF8A1538))),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             InkWell(
//               child: Ink(
//                 color: const Color(0xFF8A1538),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     'Remove',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               onTap: () async {
//                 await _deleteAlocatedDriver();
//                 setState(() {
//                   userBooking = null;
//                 });
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _deleteAlocatedDriver() async {
//     try {
//       await _bookingRequestCollection.doc(userBooking?['id']).delete();
//       await _ridesRef.child(_user!.currentDriverId!).child(userId).remove();
//       await _userCollection.doc(userId).update({
//         'currentDriverId': null,
//       });
//     } catch (e) {
//       print("Error deleting driver: $e");
//     }
//   }

//   Widget _buildDriverCard(
//       Driver driver, double screenWidth, String estimateTime) {
//     return InkWell(
//       onLongPress: _showRemoveDriverDialog,
//       child: Card(
//         margin: EdgeInsets.only(bottom: screenWidth * 0.04),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//           side: BorderSide(color: Colors.grey[300]!),
//         ),
//         elevation: 4, // Adds a subtle shadow for depth
//         child: Padding(
//           padding: EdgeInsets.all(screenWidth * 0.04),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     radius: screenWidth * 0.08,
//                     backgroundColor: const Color(0xFFF5E9ED),
//                     child: const Icon(
//                       Icons.person,
//                       size: 40,
//                       color: Color(0xFF8A1538),
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.04),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           driver.name,
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.05,
//                             fontWeight: FontWeight.bold,
//                             color: const Color(0xFF8A1538),
//                           ),
//                         ),
//                         SizedBox(height: screenWidth * 0.01),
//                         Text(
//                           'Vehicle: ${driver.vehicleNumber}',
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.04,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         SizedBox(height: screenWidth * 0.01),
//                         Text(
//                           'Available Seats: ${driver.seats}',
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.04,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Text(
//                     'Est Time: $estimateTime',
//                     style: TextStyle(
//                       fontSize: screenWidth * 0.04,
//                       color: Colors.grey[600],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: screenWidth * 0.04),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       _makePhoneCall("tel:+92${driver.phone}");
//                     },
//                     icon: const Icon(Icons.phone, color: Colors.white),
//                     label: const Text(
//                       'Call',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF8A1538),
//                       elevation: 3,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return const TrackDriver();
//                       }));
//                     },
//                     style: ElevatedButton.styleFrom(
//                       elevation: 4,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: screenWidth * 0.05,
//                         vertical: screenWidth * 0.03,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       backgroundColor: const Color(0xFF8A1538),
//                       foregroundColor: Colors.white,
//                     ),
//                     child: Row(
//                       children: const [
//                         Icon(Icons.location_on, color: Colors.white),
//                         SizedBox(width: 8),
//                         Text(
//                           'Track Driver',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDriverCardPlaceholder(double screenWidth) {
//     return Container(
//       height: screenWidth * 0.3,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: EdgeInsets.only(bottom: screenWidth * 0.04),
//       child: const Center(
//         child: Text(
//           "No Driver Selected",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   Widget _buildDriverCardPending(double screenWidth) {
//     return Container(
//       height: screenWidth * 0.3,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.grey[200],
//         borderRadius: BorderRadius.circular(12),
//       ),
//       margin: EdgeInsets.only(bottom: screenWidth * 0.04),
//       child: const Center(
//         child: Text(
//           "No Driver Selected",
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   Widget _buildManageSection(double screenWidth) {
//     return StreamBuilder<Object>(
//         stream: null,
//         builder: (context, snapshot) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Manage',
//                 style: TextStyle(
//                   fontSize: screenWidth * 0.05,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: screenWidth * 0.03),
//               Wrap(
//                   spacing: screenWidth * 0.02,
//                   runSpacing: screenWidth * 0.02,
//                   children: [
//                     if (userBooking == null) ...[
//                       // If there are no bookings, show the "Find Driver" and "Set Pickup Point" cards.
//                       buildManageCard(
//                         icon: Icons.search_outlined,
//                         label: 'Find Driver',
//                         onTap: () {
//                           Navigator.pushNamed(context, '/availableDrivers');
//                         },
//                         screenWidth: screenWidth,
//                       ),
//                       buildManageCard(
//                         icon: Icons.location_on_outlined,
//                         label: 'Set Pickup Point',
//                         onTap: () {
//                           Navigator.pushNamed(context, '/locationSelection');
//                         },
//                         screenWidth: screenWidth,
//                       ),
//                     ] else if (userBooking?['status'] != 'confirmed') ...[
//                       // If bookings exist but the status is not 'confirmed', show the same cards.
//                       buildManageCard(
//                         icon: Icons.search_outlined,
//                         label: 'Find Driver',
//                         onTap: () {
//                           Navigator.pushNamed(context, '/availableDrivers');
//                         },
//                         screenWidth: screenWidth,
//                       ),
//                       buildManageCard(
//                         icon: Icons.location_on_outlined,
//                         label: 'Set Pickup Point',
//                         onTap: () {
//                           Navigator.pushNamed(context, '/locationSelection');
//                         },
//                         screenWidth: screenWidth,
//                       )
//                     ],
//                     buildManageCard(
//                       icon: Icons.schedule_outlined,
//                       label: 'Schedule Ride',
//                       onTap: () {
//                         Navigator.pushNamed(context, '/schedule');
//                       },
//                       screenWidth: screenWidth,
//                     ),
//                     buildManageCard(
//                       icon: Icons.history_outlined,
//                       label: 'Ride History',
//                       onTap: () {
//                         Navigator.pushNamed(context, '/rideHistory');
//                       },
//                       screenWidth: screenWidth,
//                     ),
//                     buildManageCard(
//                       icon: Icons.book_outlined,
//                       label: 'Booking Requests',
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return DriverBookingDetail();
//                         }));
//                       },
//                       screenWidth: screenWidth,
//                     ),
//                     buildManageCard(
//                       icon: Icons.safety_check_outlined,
//                       label: 'Safety',
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return SafetyScreen();
//                         }));
//                       },
//                       screenWidth: screenWidth,
//                     ),
//                   ]),
//               if (userBooking != null &&
//                   userBooking?['status'] == 'confirmed') ...[
//                 InkWell(
//                   onTap: () => Navigator.push(context,
//                       MaterialPageRoute(builder: (context) {
//                     return const LocationPickerScreen();
//                   })),
//                   child: Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.only(top: screenWidth * 0.04),
//                     padding: EdgeInsets.symmetric(
//                       vertical: screenWidth * 0.04,
//                       horizontal: screenWidth * 0.03,
//                     ),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF8A1538),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: const Color(0xFFB23254)),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.location_on_outlined,
//                           size: screenWidth * 0.08,
//                           color: Colors.white,
//                         ),
//                         SizedBox(width: screenWidth * 0.07),
//                         Text(
//                           "Set Pick Up Point and Destination",
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.04,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ],
//           );
//         });
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:busbuddy/services/AuthService.dart';
import 'package:busbuddy/services/NotificationService.dart';
=======
<<<<<<< HEAD
import 'dart:convert';
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
import 'dart:developer';

import 'package:busbuddy/services/AuthService.dart';
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:busbuddy/views/widgets/CustomAppBar.dart';
import 'package:busbuddy/views/widgets/CustomDrawer.dart';
import 'package:busbuddy/views/widgets/ManageCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/driverService.dart';
import 'LocationSelection.dart';
import 'OngoingTrip.dart';
import 'SafetyScreen.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? userBooking;
  final DriverService _driverService = DriverService();
  final UserService _userService = UserService();
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  final DatabaseReference _ridesRef =
      FirebaseDatabase.instance.ref().child('rides');
  final DatabaseReference _tripUpdate =
      FirebaseDatabase.instance.ref().child('tripUpdates');
<<<<<<< HEAD

  final DatabaseReference _reference = FirebaseDatabase.instance.ref();
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
  final DatabaseReference _ridesRef =
      FirebaseDatabase.instance.ref().child('rides');
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  UserModel? _user;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');

<<<<<<< HEAD
  NotificationService notificationService = NotificationService();

=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> fetchUser() async {
    final userDoc = await _userService.fetchUser(userId);
    setState(() {
      _user = userDoc;
    });
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  Future<void> _fetchUserBookings() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user == null) return;

      final booking = await _driverService.fetchUserBooking(user.uid);
      setState(() {
        userBooking = booking;
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      });
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<String?> fetchCurrentDriverId(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data()?['currentDriverId'] as String?;
  }

<<<<<<< HEAD
  //stream the data from the realtime database to get the estimated time of arrival

  Stream<Map<String, dynamic>?> streamUserBooking(String userId) async* {
    try {
      //fetch the Booking requests
      final currentDriverId = await fetchCurrentDriverId(userId);
      if (currentDriverId == null) {
        yield null; // No driver assigned, stream emits null
        return;
      }
      yield* _bookingRequestCollection
          .doc(userBooking?['id'])
          .snapshots()
          .map((snapshot) => snapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  Future<Map<String, dynamic>?> fetchTripUpdates(String userId) async {
    try {
      final snapshot = await _reference.child("tripUpdates/$userId").get();
      log("Snapshot: ${snapshot.value}");
      if (snapshot.exists) {
        return snapshot.value as Map<String, dynamic>;
      }
    } catch (e) {
      log("Error fetching trip updates: $e");
    }
    return null;
=======
<<<<<<< HEAD
  //stream the data from the realtime database to get the estimated time of arrival

=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  Stream<Map<String, dynamic>?> streamUserBooking(String userId) async* {
    final currentDriverId = await fetchCurrentDriverId(userId);
    if (currentDriverId == null) {
      yield null; // No driver assigned, stream emits null
      return;
    }

    yield* _userCollection
        .where("student_id", isEqualTo: userId)
        .where("driver_id", isEqualTo: currentDriverId)
        .orderBy("timestamp", descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
      }
      return null;
    });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  }

  @override
  void initState() {
<<<<<<< HEAD
    _fetchUserBookings();
    // _fetchUser();
    fetchUser();
    // fetchTripUpdates(userId);
=======
<<<<<<< HEAD
    _fetchUserBookings();
    // _fetchUser();
    fetchUser();
=======
<<<<<<< HEAD
    _fetchUserBookings();
    // _fetchUser();
    fetchUser();
=======
<<<<<<< HEAD
    _fetchUserBookings();
    // _fetchUser();
    fetchUser();
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
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
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      key: _scaffoldKey,
      drawer: buildCustomDrawer(context, _user),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await fetchUser();
            await _fetchUserBookings();
          },
          child: Column(
            children: [
              customAppBar(screenWidth, screenHeight, _scaffoldKey),
              Expanded(
                child: StreamBuilder<UserModel?>(
                  stream: _userStream(userId),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (userSnapshot.hasError) {
                      return const Center(
                          child: Text('Error loading user data.'));
                    }
                    if (!userSnapshot.hasData || userSnapshot.data == null) {
                      return const Center(child: Text('No user data found.'));
                    }

                    UserModel user = userSnapshot.data!;
                    String? driverId = user.currentDriverId;

                    return StreamBuilder<Driver?>(
                      stream: _driverStream(driverId),
                      builder: (context, driverSnapshot) {
                        if (driverSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (driverSnapshot.hasError) {
                          return const Center(
                              child: Text('Error loading driver data.'));
                        }
                        Driver? driver = driverSnapshot.data;

                        return StreamBuilder<Map<String, dynamic>?>(
                          stream: streamUserBooking(userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snapshot.hasError) {
                              return Center(
                                  child: Text("Error: ${snapshot.error}"));
                            }
                            final userBooking = snapshot.data;
<<<<<<< HEAD
                            log("UserBooking: $userBooking");
                            final tripUpdates = userBooking?["tripUpdates"]
                                as Map<String, dynamic>?;
                            log("TripUpdates: $tripUpdates");
                            final estimatedTime =
                                tripUpdates?['estimatedTime'] ?? "N/A";

                            return StreamBuilder<Map<String, dynamic>?>(
                                stream: _tripUpdatesStream(userId),
                                builder: (context, tripSnapshot) {
                                  final tripUpdates = tripSnapshot.data;
                                  final estimatedTime =
                                      tripUpdates?['estimatedTime'] ?? 'N/A';
                                  final distance =
                                      tripUpdates?['distance']?.toString() ??
                                          '0';

                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04,
                                      vertical: screenWidth * 0.04,
                                    ),
                                    child: Column(
                                      children: [
                                        _buildProfileSection(user, screenWidth),
                                        const SizedBox(height: 10),
                                        if (userBooking != null)
                                          if (userBooking!['status'] ==
                                              'pending')
                                            _buildDriverCardPending(screenWidth)
                                          else if (userBooking!['status'] ==
                                                  'confirmed' &&
                                              driver != null)
                                            _buildDriverCard(driver!,
                                                screenWidth, estimatedTime)
                                          else
                                            _buildDriverCardPlaceholder(
                                                screenWidth)
                                        else
                                          _buildDriverCardPlaceholder(
                                              screenWidth),
                                        // const SizedBox(height: 5),
                                        _buildManageSection(screenWidth),
                                      ],
                                    ),
                                  );
                                });
=======
<<<<<<< HEAD

                            return Padding(
=======
                            return SingleChildScrollView(
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenWidth * 0.04,
                              ),
                              child: Column(
<<<<<<< HEAD
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildProfileSection(user, screenWidth),
                                  const SizedBox(height: 10),
=======
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildProfileSection(user, screenWidth),
                                  const SizedBox(height: 16),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                                  if (userBooking != null &&
                                      userBooking['status'] == 'pending')
                                    _buildDriverCardPending(screenWidth)
                                  else if (driver != null ||
                                      userBooking != null)
<<<<<<< HEAD
                                    _buildDriverCard(
                                        driver!, screenWidth, "10 mins")
                                  else
                                    _buildDriverCardPlaceholder(screenWidth),
                                  const SizedBox(height: 10),
=======
                                    _buildDriverCard(driver!, screenWidth)
                                  else
                                    _buildDriverCardPlaceholder(screenWidth),
                                  const SizedBox(height: 16),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                                  _buildManageSection(screenWidth),
                                ],
                              ),
                            );
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri.parse(phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Handle the case where the phone call cannot be initiated
      throw 'Could not launch $phoneNumber';
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Widget _buildProfileSection(UserModel user, double screenWidth) {
    return Card(
      color: const Color(0xFF8A1538),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
<<<<<<< HEAD
          vertical: screenWidth * 0.01,
=======
          vertical: screenWidth * 0.03,
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: user.profilePicture != null
                  ? MemoryImage(base64Decode(user.profilePicture!))
                  : null,
              radius: screenWidth * 0.08,
              //image is 8bit image
              backgroundColor: Colors.white,
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Text(
                    'PickUp: ${user.address}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    'Destination: ${user.school}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.white70,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
  Widget _buildProfileSection(UserModel user, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        children: [
<<<<<<< HEAD
          SizedBox(width: screenWidth * 0.04),
=======
<<<<<<< HEAD
          SizedBox(width: screenWidth * 0.04),
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      ),
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> _showRemoveDriverDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Remove Driver',
            style: TextStyle(color: const Color(0xFF8A1538)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you want to remove the driver?',
                    style: TextStyle(color: const Color(0xFF8A1538))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel',
                  style: TextStyle(color: const Color(0xFF8A1538))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            InkWell(
              child: Ink(
                color: const Color(0xFF8A1538),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Remove',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () async {
                await _deleteAlocatedDriver();
<<<<<<< HEAD
                setState(() {
                  userBooking = null;
                });
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> _deleteAlocatedDriver() async {
    try {
      await _bookingRequestCollection.doc(userBooking?['id']).delete();
      await _ridesRef.child(_user!.currentDriverId!).child(userId).remove();
      await _userCollection.doc(userId).update({
        'currentDriverId': null,
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
  Future<void> _deleteAlocatedDriver() async {
    try {
      await _bookingRequestCollection.doc(userBooking?['id']).delete();
      await _userCollection.doc(userId).update({
        'currentDriverId': null,
      });
      await _ridesRef.child(userId).remove();
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    } catch (e) {
      print("Error deleting driver: $e");
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Widget _buildDriverCard(
      Driver driver, double screenWidth, String estimateTime) {
    return InkWell(
      onLongPress: _showRemoveDriverDialog,
<<<<<<< HEAD
=======
=======
  Widget _buildDriverCard(Driver driver, double screenWidth) {
    return InkWell(
      onLongPress: (() async {
        await _deleteAlocatedDriver();
      }),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      child: Card(
        margin: EdgeInsets.only(bottom: screenWidth * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey[300]!),
        ),
<<<<<<< HEAD
        elevation: 4, // Adds a subtle shadow for depth
=======
<<<<<<< HEAD
        elevation: 4, // Adds a subtle shadow for depth
=======
        elevation: 4, // Adds subtle shadow
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
<<<<<<< HEAD
                    backgroundImage:
                        MemoryImage(base64Decode(driver.faceImage)),
                    radius: screenWidth * 0.08,
                    backgroundColor: const Color(0xFFF5E9ED),
=======
                    radius: screenWidth * 0.08,
<<<<<<< HEAD
                    backgroundColor: const Color(0xFFF5E9ED),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Color(0xFF8A1538),
                    ),
=======
                    backgroundColor:
                        const Color(0xFFF5E9ED), // Light background
                    child: const Icon(Icons.person,
                        size: 40, color: Color(0xFF8A1538)),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
                            color: const Color(0xFF8A1538),
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.01),
                        Text(
                          'Vehicle: ${driver.vehicleNumber}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.01),
                        Text(
                          'Available Seats: ${driver.seats}',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
<<<<<<< HEAD
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenWidth * 0.01,
                    ),
                   
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: Colors.pink[50],
                    ),
                    child: Text(
                      estimateTime,
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
=======
<<<<<<< HEAD
                  Text(
                    'Est Time: $estimateTime',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.grey[600],
                    ),
                  ),
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                ],
              ),
              SizedBox(height: screenWidth * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _makePhoneCall("tel:+92${driver.phone}");
                    },
                    icon: const Icon(Icons.phone, color: Colors.white),
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                    label: const Text(
                      'Call',
                      style: TextStyle(color: Colors.white),
                    ),
<<<<<<< HEAD
=======
=======
                    label: const Text('Call',
                        style: TextStyle(color: Colors.white)),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8A1538),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const TrackDriver();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 4,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenWidth * 0.03,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: const Color(0xFF8A1538),
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Track Driver',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        ),
      ),
    );
  }

<<<<<<< HEAD
  Stream<Map<String, dynamic>?> _tripUpdatesStream(String userId) {
    return FirebaseDatabase.instance
        .ref()
        .child('tripUpdates/$userId')
        .onValue
        .map((event) {
      final snapshotValue = event.snapshot.value;
      if (snapshotValue != null) {
        final data = Map<String, dynamic>.from(snapshotValue as Map);
        _checkForArrivalNotification(data);
        return data;
      }
      return null;
    });
  }

  void _checkForArrivalNotification(Map<String, dynamic> tripData) {
    final estimatedTime = tripData['estimatedTime']?.toString() ?? '';
    final status = tripData['status']?.toString() ?? '';

    // Extract numerical value from estimated time string
    final RegExp regExp = RegExp(r'(\d+)');
    final match = regExp.firstMatch(estimatedTime);
    if (match != null) {
      final minutes = int.tryParse(match.group(1)!) ?? 0;

      if (status.toLowerCase() == 'ongoing' && minutes <= 5) {
        notificationService.showNotification(
          id: 1,
          title: 'Ride Arrival',
          body: 'Your ride will arrive in $minutes minutes.',
        );
      }
    }
  }

=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Widget _buildDriverCardPlaceholder(double screenWidth) {
    return Container(
      height: screenWidth * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      child: const Center(
        child: Text(
          "No Driver Selected",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDriverCardPending(double screenWidth) {
<<<<<<< HEAD
    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.orange.withOpacity(0.3)),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.timer, color: Colors.orange, size: 40),
                SizedBox(width: screenWidth * 0.04),
=======
    return Container(
      height: screenWidth * 0.3,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
<<<<<<< HEAD
                        'Request Pending',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Text(
                        'Your driver request is being processed. '
                        'Please wait for confirmation.',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Colors.grey[600],
                        ),
                      ),
=======
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
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                    ],
                  ),
                ),
              ],
            ),
<<<<<<< HEAD
=======
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
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildManageSection(double screenWidth) {
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
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
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
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
<<<<<<< HEAD
    return StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
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
                  spacing: screenWidth * 0.02,
                  runSpacing: screenWidth * 0.02,
                  children: [
                    if (userBooking == null) ...[
                      // If there are no bookings, show the "Find Driver" and "Set Pickup Point" cards.
                      buildManageCard(
                        icon: Icons.search_outlined,
                        label: 'Find Driver',
                        onTap: () {
                          Navigator.pushNamed(context, '/availableDrivers');
                        },
                        screenWidth: screenWidth,
                      ),
                      buildManageCard(
                        icon: Icons.location_on_outlined,
                        label: 'Set Pickup Point',
                        onTap: () {
                          Navigator.pushNamed(context, '/locationSelection');
                        },
                        screenWidth: screenWidth,
                      ),
                    ] else if (userBooking?['status'] != 'confirmed') ...[
                      // If bookings exist but the status is not 'confirmed', show the same cards.
                      buildManageCard(
                        icon: Icons.search_outlined,
                        label: 'Find Driver',
                        onTap: () {
                          Navigator.pushNamed(context, '/availableDrivers');
                        },
                        screenWidth: screenWidth,
                      ),
                      buildManageCard(
                        icon: Icons.location_on_outlined,
                        label: 'Set Pickup Point',
                        onTap: () {
                          Navigator.pushNamed(context, '/locationSelection');
                        },
                        screenWidth: screenWidth,
                      )
                    ],
                    buildManageCard(
                      icon: Icons.schedule_outlined,
                      label: 'Schedule Ride',
                      onTap: () {
                        Navigator.pushNamed(context, '/schedule');
                      },
                      screenWidth: screenWidth,
                    ),
                    buildManageCard(
                      icon: Icons.history_outlined,
                      label: 'Ride History',
                      onTap: () {
                        Navigator.pushNamed(context, '/rideHistory');
                      },
                      screenWidth: screenWidth,
                    ),
                    buildManageCard(
                      icon: Icons.book_outlined,
                      label: 'Booking Requests',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DriverBookingDetail();
                        }));
                      },
                      screenWidth: screenWidth,
                    ),
                    buildManageCard(
                      icon: Icons.safety_check_outlined,
                      label: 'Safety',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SafetyScreen();
                        }));
                      },
                      screenWidth: screenWidth,
                    ),
                  ]),
              if (userBooking != null &&
                  userBooking?['status'] == 'confirmed') ...[
                InkWell(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const LocationPickerScreen();
                  })),
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: screenWidth * 0.04),
                    padding: EdgeInsets.symmetric(
                      vertical: screenWidth * 0.04,
                      horizontal: screenWidth * 0.03,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8A1538),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFB23254)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: screenWidth * 0.08,
                          color: Colors.white,
                        ),
                        SizedBox(width: screenWidth * 0.07),
                        Text(
                          "Set Pick Up Point and Destination",
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ],
          );
        });
  }
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
          children: [
            // Only show these cards when there's no booking or booking is rejected/expired
            if (userBooking == null ||
                (userBooking != null &&
                    userBooking!['status'] != 'pending' &&
                    userBooking!['status'] != 'confirmed')) ...[
              buildManageCard(
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
            spacing: screenWidth * 0.02,
            runSpacing: screenWidth * 0.02,
            children: [
              if (userBooking == null) ...[
                // If there are no bookings, show the "Find Driver" and "Set Pickup Point" cards.
<<<<<<< HEAD
                buildManageCard(
=======
<<<<<<< HEAD
                buildManageCard(
=======
                _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                  icon: Icons.search_outlined,
                  label: 'Find Driver',
                  onTap: () {
                    Navigator.pushNamed(context, '/availableDrivers');
                  },
                  screenWidth: screenWidth,
                ),
<<<<<<< HEAD
                buildManageCard(
=======
<<<<<<< HEAD
                buildManageCard(
=======
                _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                  icon: Icons.location_on_outlined,
                  label: 'Set Pickup Point',
                  onTap: () {
                    Navigator.pushNamed(context, '/locationSelection');
                  },
                  screenWidth: screenWidth,
                ),
              ] else if (userBooking?['status'] != 'confirmed') ...[
                // If bookings exist but the status is not 'confirmed', show the same cards.
<<<<<<< HEAD
                buildManageCard(
=======
<<<<<<< HEAD
                buildManageCard(
=======
                _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                  icon: Icons.search_outlined,
                  label: 'Find Driver',
                  onTap: () {
                    Navigator.pushNamed(context, '/availableDrivers');
                  },
                  screenWidth: screenWidth,
                ),
<<<<<<< HEAD
                buildManageCard(
=======
<<<<<<< HEAD
                buildManageCard(
=======
                _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                  icon: Icons.location_on_outlined,
                  label: 'Set Pickup Point',
                  onTap: () {
                    Navigator.pushNamed(context, '/locationSelection');
                  },
                  screenWidth: screenWidth,
                )
              ],
<<<<<<< HEAD
              buildManageCard(
=======
<<<<<<< HEAD
              buildManageCard(
=======
              _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                icon: Icons.schedule_outlined,
                label: 'Schedule Ride',
                onTap: () {
                  Navigator.pushNamed(context, '/schedule');
                },
                screenWidth: screenWidth,
              ),
<<<<<<< HEAD
              buildManageCard(
=======
<<<<<<< HEAD
              buildManageCard(
=======
              _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                icon: Icons.history_outlined,
                label: 'Ride History',
                onTap: () {
                  Navigator.pushNamed(context, '/rideHistory');
                },
                screenWidth: screenWidth,
              ),
<<<<<<< HEAD
              buildManageCard(
=======
<<<<<<< HEAD
              buildManageCard(
=======
              _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                icon: Icons.book_outlined,
                label: 'Booking Requests',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DriverBookingDetail();
                  }));
                },
                screenWidth: screenWidth,
              ),
<<<<<<< HEAD
              buildManageCard(
=======
<<<<<<< HEAD
              buildManageCard(
=======
              _buildManageCard(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
=======
<<<<<<< HEAD
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
=======
            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) {
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
    );
  }
=======
<<<<<<< HEAD
      ],
    );
  }
=======
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
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                icon: Icons.search_outlined,
                label: 'Find Driver',
                onTap: () {
                  Navigator.pushNamed(context, '/availableDrivers');
                },
                screenWidth: screenWidth,
              ),
<<<<<<< HEAD
              buildManageCard(
=======
              _buildManageCard(
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                icon: Icons.location_on_outlined,
                label: 'Set Pickup Point',
                onTap: () {
                  Navigator.pushNamed(context, '/locationSelection');
                },
                screenWidth: screenWidth,
              ),
<<<<<<< HEAD
            ],
            // Always show these cards
            buildManageCard(
=======
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
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
              icon: Icons.schedule_outlined,
              label: 'Schedule Ride',
              onTap: () {
                Navigator.pushNamed(context, '/schedule');
<<<<<<< HEAD
              },
              screenWidth: screenWidth,
            ),
            buildManageCard(
=======
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
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
              icon: Icons.history_outlined,
              label: 'Ride History',
              onTap: () {
                Navigator.pushNamed(context, '/rideHistory');
              },
              screenWidth: screenWidth,
            ),
<<<<<<< HEAD
            buildManageCard(
=======
            _buildManageCard(
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
              icon: Icons.book_outlined,
              label: 'Booking Requests',
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DriverBookingDetail();
                }));
              },
              screenWidth: screenWidth,
            ),
<<<<<<< HEAD
            buildManageCard(
=======
            _buildManageCard(
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
<<<<<<< HEAD
        // Show set pickup button only for confirmed rides
        if (userBooking != null && userBooking!['status'] == 'confirmed')
          InkWell(
            onTap: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const LocationPickerScreen();
            })),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: screenWidth * 0.02),
              padding: EdgeInsets.symmetric(
                vertical: screenWidth * 0.04,
                horizontal: screenWidth * 0.03,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF8A1538),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFB23254)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: screenWidth * 0.08,
                    color: Colors.white,
                  ),
                  SizedBox(width: screenWidth * 0.07),
                  Text(
                    "Set Pick Up Point and Destination",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }
=======
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
}
