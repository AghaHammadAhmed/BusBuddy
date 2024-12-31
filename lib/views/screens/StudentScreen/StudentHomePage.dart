<<<<<<< HEAD
import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/driverService.dart';
import 'OngoingTrip.dart';
import 'SafetyScreen.dart';
=======
import 'package:busbuddy/services/AuthService.dart';
import 'package:busbuddy/services/driverService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../models/user.dart';
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0

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
  // String status = 'pending';

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
    }
  }

  @override
  void initState() {
<<<<<<< HEAD
    _fetchUserBookings();
=======
    _fetchUserData();
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
=======
    return Scaffold(
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
<<<<<<< HEAD
            _scaffoldKey.currentState!.openDrawer();
=======
            // Navigate to menu screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
                Driver? driver = driverSnapshot.data;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProfileSection(user, screenWidth),
                        SizedBox(height: screenHeight * 0.03),
                        if (driverId == null)
                          _buildDriverCardPlaceholder(screenWidth),
                        if (driver != null)
                          _buildDriverCardPending(driver, screenWidth),
                        // if (driver != null && status == 'confirmed')
                        // _buildDriverCard(driver, screenWidth),

                        SizedBox(height: screenHeight * 0.02),
                        _buildManageSection(screenWidth),
                      ],
                    ),
                  ),
                );
              },
            );
          },
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

  Widget _buildProfileSection(UserModel user, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Row(
        children: [
  
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
<<<<<<< HEAD
                  user.name,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
<<<<<<< HEAD
        padding: EdgeInsets.all(screenWidth * 0.04),
=======
        padding: const EdgeInsets.all(16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
<<<<<<< HEAD
                  radius: screenWidth * 0.08,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                SizedBox(width: screenWidth * 0.04),
=======
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                const SizedBox(width: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
<<<<<<< HEAD
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
=======
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
                      Text(
                        'Vehicle: ${driver.vehicleNumber}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
<<<<<<< HEAD
                      SizedBox(height: screenWidth * 0.02),
=======
                      const SizedBox(height: 4),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
            const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
<<<<<<< HEAD
                  onPressed: () {},
=======
                  onPressed: () {
                    // Handle call action
                  },
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
<<<<<<< HEAD
=======
                  child: const Text('Track Your Driver'),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
  Widget _buildDriverCardPlaceholder() {
    return Container(
      height: 150,
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
<<<<<<< HEAD
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
        ),
      ),
    );
  }
<<<<<<< HEAD

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
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
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
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'john.doe@example.com',
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
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
}
