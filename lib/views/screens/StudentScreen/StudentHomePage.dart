import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/driverService.dart';
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
    }
  }

  @override
  void initState() {
    _fetchUserBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
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

  Widget _buildDriverCardPending(Driver driver, double screenWidth) {
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
    );
  }

  Widget _buildManageCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
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
        ),
      ),
    );
  }

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
}
