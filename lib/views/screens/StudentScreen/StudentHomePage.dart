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

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, dynamic>? userBooking;
  final DriverService _driverService = DriverService();
  final UserService _userService = UserService();
  final DatabaseReference _ridesRef =
      FirebaseDatabase.instance.ref().child('rides');
  final DatabaseReference _tripUpdate =
      FirebaseDatabase.instance.ref().child('tripUpdates');

  final DatabaseReference _reference = FirebaseDatabase.instance.ref();
  UserModel? _user;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');

  NotificationService notificationService = NotificationService();

  Future<void> fetchUser() async {
    final userDoc = await _userService.fetchUser(userId);
    setState(() {
      _user = userDoc;
    });
  }

  Future<void> _fetchUserBookings() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      if (user == null) return;

      final booking = await _driverService.fetchUserBooking(user.uid);
      setState(() {
        userBooking = booking;
      });
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  Future<String?> fetchCurrentDriverId(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data()?['currentDriverId'] as String?;
  }

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
  }

  @override
  void initState() {
    _fetchUserBookings();
    // _fetchUser();
    fetchUser();
    // fetchTripUpdates(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await fetchUser();
                                        await _fetchUserBookings();
                                      },
                                      child: Text('Retry'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF8A1538),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            final userBooking = snapshot.data;
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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri.parse(phoneNumber);

    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      // Handle the case where the phone call cannot be initiated
      throw 'Could not launch $phoneNumber';
    }
  }

  Widget _buildProfileSection(UserModel user, double screenWidth) {
    return Card(
      color: const Color(0xFF8A1538),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.01,
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
      ),
    );
  }

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
                setState(() {
                  userBooking = null;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAlocatedDriver() async {
    try {
      await _bookingRequestCollection.doc(userBooking?['id']).delete();
      await _ridesRef.child(_user!.currentDriverId!).child(userId).remove();
      await _userCollection.doc(userId).update({
        'currentDriverId': null,
      });
    } catch (e) {
      print("Error deleting driver: $e");
    }
  }

  Widget _buildDriverCard(
      Driver driver, double screenWidth, String estimateTime) {
    return InkWell(
      onLongPress: _showRemoveDriverDialog,
      child: Card(
        margin: EdgeInsets.only(bottom: screenWidth * 0.04),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey[300]!),
        ),
        elevation: 4, // Adds a subtle shadow for depth
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        MemoryImage(base64Decode(driver.faceImage)),
                    radius: screenWidth * 0.08,
                    backgroundColor: const Color(0xFFF5E9ED),
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
                    label: const Text(
                      'Call',
                      style: TextStyle(color: Colors.white),
                    ),
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
        ),
      ),
    );
  }

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
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
                    ],
                  ),
                ),
              ],
            ),
          ],
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
          spacing: screenWidth * 0.02,
          runSpacing: screenWidth * 0.02,
          children: [
            // Only show these cards when there's no booking or booking is rejected/expired
            if (userBooking == null ||
                (userBooking != null &&
                    userBooking!['status'] != 'pending' &&
                    userBooking!['status'] != 'confirmed')) ...[
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
            ],
            // Always show these cards
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DriverBookingDetail();
                }));
              },
              screenWidth: screenWidth,
            ),
            buildManageCard(
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
}
