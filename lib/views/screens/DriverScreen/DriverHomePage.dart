// ignore_for_file: prefer_const_constructors
import 'package:busbuddy/models/user.dart';
// import 'package:busbuddy/views/screens/DriverScreen/DriverPickUpLocation.dart';
import 'package:busbuddy/views/widgets/CustomAppBar.dart';
import 'package:busbuddy/views/widgets/CustomDrawer.dart';
import 'package:busbuddy/views/widgets/ManageCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import 'DriverMapView.dart';
import 'PendingStudentRequest.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final DriverService _driverService = DriverService();
  // List<Map<String, dynamic>> _students = [];
  // List<Map<String, dynamic>> _bookingRequests = [];
  UserModel? _user;

  Driver? _driver;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDriver();
    _fetchUser();
  }

  Future<Driver?> _fetchDriverByUserId() async {
    try {
      QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
          .collection('drivers')
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
          .get();

      if (driverQuery.docs.isNotEmpty) {
        final driverData = driverQuery.docs.first.data();
        return Driver.fromJson(driverData);
      }
      return null;
    } catch (e) {
      print("Failed to fetch driver: $e");
      return null;
    }
  }

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
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: buildCustomDrawer(context, _user),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _driver == null
              ? const Center(child: Text('No driver found.'))
              : SafeArea(
                  child: Column(
                    children: [
                      customAppBar(screenWidth, screenHeight, _scaffoldKey),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            _buildProfileSection(_driver!),
                            const SizedBox(height: 20),
                            _buildStudentsSection(_driver!.driverID),
                            const SizedBox(height: 20),
                            // _buildBookingRequestsSection(),
                            const SizedBox(height: 20),
                            _buildManageSection(screenWidth),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileSection(Driver driver) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.name,
                  style: const TextStyle(
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

        return Ink(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = UserModel.fromJson(students[index]);
              return Card(
                color: Color(0xFF8A1538),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListTile(
                  leading: const Icon(Icons.person, color: Colors.white),
                  title: Text(
                    student.name,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Pickup: ${student.address ?? 'No Address'}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildManageSection(double screenWidth) {
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
            buildManageCard(
              screenWidth: screenWidth,
              icon: Icons.map_outlined,
              label: 'Map View',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriverLiveLocation()));
              },
            ),
            buildManageCard(
              screenWidth: screenWidth,
              icon: Icons.schedule_outlined,
              label: 'Schedule',
              onTap: () {
                // Navigate to schedule screen
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildManageCard(
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
            buildManageCard(
              screenWidth: screenWidth,
              icon: Icons.history,
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
}
