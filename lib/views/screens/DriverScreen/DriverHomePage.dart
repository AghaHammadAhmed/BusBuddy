<<<<<<< HEAD
// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import 'DriverMapView.dart';
import 'PendingStudentRequest.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import 'DriverMapView.dart';
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
<<<<<<< HEAD
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final DriverService _driverService = DriverService();
  // List<Map<String, dynamic>> _students = [];
  // List<Map<String, dynamic>> _bookingRequests = [];

  Driver? _driver;
  bool _isLoading = true;
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

  @override
  void initState() {
    super.initState();
    _loadDriver();
  }

<<<<<<< HEAD
=======
  Driver? _driver; // Driver instance
  bool _isLoading = true; // Loading state

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
  Future<Driver?> _fetchDriverByUserId() async {
    try {
      QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
          .collection('drivers')
<<<<<<< HEAD
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
=======
          .where('userID', isEqualTo: userCredential.currentUser!.uid)
          .limit(1) // Fetch only one document
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
          .get();

      if (driverQuery.docs.isNotEmpty) {
        final driverData = driverQuery.docs.first.data();
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
    } catch (e) {
      print("Failed to fetch driver: $e");
      return null;
    }
  }

<<<<<<< HEAD
  Future<void> _fetchStudents(String driverId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> studentQuery = await _firestore
          .collection('users')
          .where('role', isEqualTo: 'student')
          .where('currentDriverId', isEqualTo: driverId)
          .get();

      if (studentQuery.docs.isNotEmpty) {
        setState(() {
          // _students = studentQuery.docs.map((doc) => doc.data()).toList();
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
          // _bookingRequests = bookingQuery.docs
          //     .map((doc) => {'id': doc.id, ...doc.data()})
          //     .toList();
        });
      }
    } catch (e) {
      print("Failed to fetch booking requests: $e");
    }
  }

  Future<void> _loadDriver() async {
    try {
      Driver? fetchedDriver = await _fetchDriverByUserId();
      if (fetchedDriver != null) {
        await _fetchStudents(fetchedDriver.driverID);
        await _fetchBookingRequests(fetchedDriver.driverID);
      }
=======
  Future<void> _loadDriver() async {
    try {
      Driver? fetchedDriver = await _fetchDriverByUserId();
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
=======
  @override
  Widget build(BuildContext context) {
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
        elevation: 0,
<<<<<<< HEAD
=======
        //menu icon button
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Navigate to menu screen
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
                          _buildStudentsSection(_driver!.driverID),
                          const SizedBox(height: 20),
                          // _buildBookingRequestsSection(),
                          const SizedBox(height: 20),
                          _buildManageSection(screenWidth),
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
                  style: TextStyle(
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
=======
  Widget _buildRidesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Rides',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildManageCard(
<<<<<<< HEAD
              screenWidth: screenWidth,
              icon: Icons.map_outlined,
              label: 'Map View',
              onTap: () {
                
=======
              icon: Icons.map_outlined,
              label: 'Map View',
              onTap: () {
                // Navigate to map screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriverLiveLocation(
<<<<<<< HEAD
                              driverId: _driver!.driverID,
=======
                            driverId: _driver!.driverID,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
                            )));
              },
            ),
            _buildManageCard(
<<<<<<< HEAD
              screenWidth: screenWidth,
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
              icon: Icons.schedule_outlined,
              label: 'Schedule',
              onTap: () {
                // Navigate to schedule screen
              },
            ),
<<<<<<< HEAD
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildManageCard(
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
            _buildManageCard(
              screenWidth: screenWidth,
              icon: Icons.history,
              label: 'Ride History',
              onTap: () {
                // Navigate to ride history screen
=======
            _buildManageCard(
              icon: Icons.message_outlined,
              label: 'Messages',
              onTap: () {
                // Navigate to message screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildManageCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
<<<<<<< HEAD
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
    );
  }
}
