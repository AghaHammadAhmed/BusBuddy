// ignore_for_file: must_be_immutable, prefer_const_constructors

<<<<<<< HEAD
import 'dart:developer';

=======
<<<<<<< HEAD
import 'dart:developer';

=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

<<<<<<< HEAD
import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/LocationService.dart';
=======
<<<<<<< HEAD
import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/LocationService.dart';
=======

import '../../../models/driver.dart';
import '../../../models/user.dart';
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import '../../../services/driverService.dart';

class DriverBookingDetail extends StatefulWidget {
  final driverData;
  DriverBookingDetail({super.key, this.driverData});

  @override
  State<DriverBookingDetail> createState() => _DriverBookingDetailState();
}

class _DriverBookingDetailState extends State<DriverBookingDetail> {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DriverService _driverService = DriverService();
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  final LocationService _locationService = LocationService();
  // final CollectionReference _driverCollection =
  //     FirebaseFirestore.instance.collection('drivers');
  Map<String, dynamic>? userBooking;
  UserModel? _user;
<<<<<<< HEAD
=======
=======
  // final CollectionReference _driverCollection =
  //     FirebaseFirestore.instance.collection('drivers');
  Map<String, dynamic>? userBooking;
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

//initial state
  @override
  void initState() {
    super.initState();
    _fetchUserBookings();
  }

  final userID = FirebaseAuth.instance.currentUser!.uid;

<<<<<<< HEAD
  //fetch the user details

=======
<<<<<<< HEAD
  //fetch the user details

=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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

  void updatePrice() {
    FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(userBooking!['id'])
        .update(
            {'fare_proposed_by_driver': widget.driverData['estimatedPrice']});
    setState(() {});
  }

  Future<void> _fetchUserBookings() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
<<<<<<< HEAD
      _user =
          UserModel.fromMap(await _driverService.fetchUserDetails(user!.uid));
=======
<<<<<<< HEAD
      _user =
          UserModel.fromMap(await _driverService.fetchUserDetails(user!.uid));
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

      if (user == null) return;

      final bookings = await _driverService.fetchUserBooking(user.uid);
      setState(() {
        userBooking = bookings;
      });
      updatePrice();
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  Stream<Map<String, dynamic>> getBookingStream(String bookingId) {
    try {
      return FirebaseFirestore.instance
          .collection('booking_requests')
          .doc(bookingId)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          data['id'] = snapshot.id; // Add the document ID
          return data;
        } else {
          throw Exception('Booking not found');
        }
      });
    } catch (e) {
      throw Exception('Booking not found');
    }
  }

  Future<void> _acceptFare(String bookingId, double fare) async {
    try {
      await _driverService.acceptFare(bookingId, fare);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fare accepted and booking confirmed.')),
      );
      _fetchUserBookings(); // Refresh bookings
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept fare: $e')),
      );
    }
  }

  Future<void> _proposeCounterFare(String bookingId, double fare) async {
    try {
      await _driverService.proposeCounterFare(bookingId, fare);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Counter fare sent to the driver.')),
      );
      _fetchUserBookings(); // Refresh bookings
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to propose counter fare: $e')),
      );
    }
  }

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

  Future<double?> _showCounterFareDialog(BuildContext context) async {
    return showDialog<double>(
      context: context,
      builder: (context) {
        final TextEditingController fareController = TextEditingController();
        final GlobalKey<FormState> formKey = GlobalKey<FormState>();

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.price_change_outlined, color: Colors.blue),
              SizedBox(width: 10),
              Text(
                'Propose Counter Fare',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fareController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Counter Fare',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a fare';
                    }
                    final fareValue = double.tryParse(value);
                    if (fareValue == null || fareValue <= 0) {
                      return 'Please enter a valid fare';
                    }
                    return null;
                  },
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16),
                _buildFareRangeGuideline(),
              ],
            ),
          ),
          actions: [
            // Cancel and Propose Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final counterFare =
                            double.tryParse(fareController.text);
                        Navigator.of(context).pop(counterFare);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0047BA),
                    ),
                    child: const Text('Propose'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

// Fare Range Guideline Widget
  Widget _buildFareRangeGuideline() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Propose a fare within a reasonable range to increase acceptance.',
              style: TextStyle(
                color: Colors.blue[700],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingStream =
        userBooking != null ? getBookingStream(userBooking!['id']) : null;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Booking Details',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<UserModel?>(
              stream: _userStream(userID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading user data.'));
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No user data found.'));
                }

                UserModel user = snapshot.data!;
                String? driverId = user.currentDriverId;

                return StreamBuilder<Driver?>(
                  stream: _driverStream(driverId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return const Center(
                          child: Text('Error loading driver data.'));
                    }
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Center(child: Text('No driver data found.'));
                    }

                    Driver driver = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.02),
                          if (userBooking != null) ...[
                            _buildDriverCard(
                                driver, MediaQuery.of(context).size.width),
                            SizedBox(height: screenHeight * 0.02),
                            if (userBooking != null)
                              _buildBookingCard(bookingStream!, screenWidth),
                          ] else ...[
                            Center(
                              child: Text("No User Booking"),
                            )
                          ]
                        ],
                      ),
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  Widget _buildDriverCard(Driver driver, double screenWidth) {
    return Card(
      margin: EdgeInsets.only(bottom: screenWidth * 0.04),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section with Driver Profile
            Row(
              children: [
                // Profile Picture with Active Status Indicator
                Stack(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.1,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: screenWidth * 0.1,
                        color: Colors.grey[600],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: driver.isActive ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.04),

                // Driver Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),

                      // Driver Rating
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 18),
                          SizedBox(width: 4),
                          Text(
                            driver.rating != null
                                ? '${driver.rating?.toStringAsFixed(1)} / 5.0'
                                : 'No ratings yet',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: screenWidth * 0.04),

            // Driver Details Section
            _buildDetailRow(
              icon: Icons.car_rental,
              label: 'Vehicle Number',
              value: driver.vehicleNumber,
              screenWidth: screenWidth,
            ),
            _buildDetailRow(
              icon: Icons.chair,
              label: 'Available Seats',
              value: driver.seats.toString(),
              screenWidth: screenWidth,
            ),
            _buildDetailRow(
              icon: Icons.location_on,
              label: 'Service Areas',
              value: driver.areas.join(', '),
              screenWidth: screenWidth,
            ),

            SizedBox(height: screenWidth * 0.04),

            // Action Button
            ElevatedButton.icon(
              onPressed: () {
                // Implement phone dialer functionality
                _launchDialer(driver.phone);
              },
              icon: const Icon(Icons.phone),
              label: const Text('Call Driver'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF0047BA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50), // Full width button
              ),
            ),
            SizedBox(height: screenWidth * 0.02),
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  void _launchDialer(String phoneNumber) {}
=======
<<<<<<< HEAD
  void _launchDialer(String phoneNumber) {}
=======

  void _launchDialer(String phoneNumber) {

  }
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          SizedBox(width: screenWidth * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: screenWidth * 0.035,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(
      Stream<Map<String, dynamic>> bookingStream, double screenWidth) {
    return StreamBuilder<Map<String, dynamic>>(
      stream: bookingStream,
      builder: (context, snapshot) {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
     
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
      
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        if (snapshot.hasError) {
          return Center(
            child: Text("Error loading booking details: ${snapshot.error}"),
          );
        }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
    
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text("No booking details found."));
        }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
   
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        Map<String, dynamic> booking = snapshot.data!;
        String bookingId = booking['id'];
        String status = booking['status'];
        double driverProposedFare =
            (booking['fare_proposed_by_driver'] as num?)?.toDouble() ?? 0.0;
        double? studentCounterFare =
            (booking['fare_counter_by_student'] as num?)?.toDouble();

        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(
              vertical: screenWidth * 0.03, horizontal: screenWidth * 0.02),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: _getStatusColor(status), width: 1.5),
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
              
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Booking #${bookingId.substring(0, 6)}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035,
                        ),
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

                SizedBox(height: screenWidth * 0.04),

              
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                _buildDetailRowBook(
                  icon: Icons.location_on,
                  title: 'Pickup',
                  subtitle: booking['pickup_location'],
                  screenWidth: screenWidth,
                ),
                _buildDetailRowBook(
                  icon: Icons.location_off,
                  title: 'Dropoff',
                  subtitle: booking['dropoff_location'],
                  screenWidth: screenWidth,
                ),
<<<<<<< HEAD
                SizedBox(height: screenWidth * 0.04),
=======
<<<<<<< HEAD
                SizedBox(height: screenWidth * 0.04),
=======

                SizedBox(height: screenWidth * 0.04),

         
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                _buildFareSection(
                    driverProposedFare: driverProposedFare,
                    studentCounterFare: studentCounterFare,
                    screenWidth: screenWidth),
<<<<<<< HEAD
                SizedBox(height: screenWidth * 0.04),
=======
<<<<<<< HEAD
                SizedBox(height: screenWidth * 0.04),
=======

                SizedBox(height: screenWidth * 0.04),

           
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                _buildActionButtons(context, bookingId, status,
                    driverProposedFare, screenWidth),
              ],
            ),
          ),
        );
      },
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  Widget _buildDetailRowBook({
    required IconData icon,
    required String title,
    required String subtitle,
    required double screenWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 24),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: screenWidth * 0.035,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
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

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  Widget _buildFareSection({
    required double driverProposedFare,
    double? studentCounterFare,
    required double screenWidth,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fare Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04,
            ),
          ),
          SizedBox(height: screenWidth * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Driver Proposed',
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                'Rs${driverProposedFare.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          if (studentCounterFare != null) ...[
            SizedBox(height: screenWidth * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Counter',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  'Rs${studentCounterFare.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  Widget _buildActionButtons(BuildContext context, String bookingId,
      String status, double driverProposedFare, double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed:
                status == 'pending' ? () => _cancelBooking(bookingId) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Expanded(
          child: ElevatedButton(
            onPressed: status == 'pending'
                ? () =>
                    _showBookingOptions(context, bookingId, driverProposedFare)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Action'),
          ),
        ),
      ],
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  void _showBookingOptions(
      BuildContext context, String bookingId, double driverProposedFare) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Booking Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
              onPressed: () {
                final pickupCoordinates = {
                  'latitude': _user!.pickupLatitude,
                  'longitude': _user!.pickupLongitude,
                };
                final dropoffCoordinates = {
                  'latitude': _user!.dropOffLatitude,
                  'longitude': _user!.dropOffLongitude,
                };
                try {
                  _acceptFare(bookingId, driverProposedFare);
                  _driverService.allocateDriverToStudent(
                      _user!.currentDriverId!,
                      userID,
                      pickupCoordinates,
                      dropoffCoordinates);
                  _locationService.allocateDriverToStudent(
                      _user!.currentDriverId!,
                      userID,
                      pickupCoordinates,
                      dropoffCoordinates);
                } catch (e) {
                  log('Error allocating driver to student: $e');
                }
              },
<<<<<<< HEAD
=======
=======
              onPressed: () => _acceptFare(bookingId, driverProposedFare),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Accept Fare'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                final counterFare = await _showCounterFareDialog(context);
                if (counterFare != null) {
                  await _proposeCounterFare(bookingId, counterFare);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Propose Counter Fare'),
            ),
          ],
        ),
      ),
    );
  }
}
