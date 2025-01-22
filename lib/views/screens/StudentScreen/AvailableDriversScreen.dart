// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:busbuddy/models/user.dart';
import 'package:busbuddy/services/AuthService.dart';
import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import '../../../services/driverService.dart';
import 'dart:math';

class AvailableDriversScreen extends StatefulWidget {
  const AvailableDriversScreen({Key? key}) : super(key: key);

  @override
  _AvailableDriversScreenState createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
  List<String> areas = [];
  String? selectedArea;

  final TextEditingController _searchController = TextEditingController();
  String _searchType = 'name';

  final FocusNode _focusNode = FocusNode();
  bool _isDropdownVisible = false;
  final DriverService _driverService = DriverService();
  List<String> schools = [];
  String? selectedSchool;
  String _searchTerm = '';
  final UserService _userService = UserService();
  List<Driver> drivers = [];
  List<Map<String, dynamic>> availableDrivers = [];
  Map<String, dynamic>? userBooking;
  bool isLoading = false;
  String currentAddress = '';
  String dropOffLocation = '';
  UserModel? _user;

  //fetch user
  Future<void> _fetchUser() async {
    try {
      final user =
          await _userService.fetchUser(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        currentAddress = user!.address!;
        dropOffLocation = user.dropOffLocation!;
        _user = user;
      });
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserBookings();
    _fetchNearestDrivers();
    _fetchUser();

    _focusNode.addListener(() {
      setState(() {
        _isDropdownVisible = _focusNode.hasFocus;
      });
    });
  }

  Future<void> _fetchUserBookings() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;

      if (user == null) return;

      final bookings = await _driverService.fetchUserBooking(user.uid);
      setState(() {
        userBooking = bookings;
      });
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

// Booking Confirmation Method
  Future<void> _confirmDriverBooking(
      BuildContext context, String driverId, String months) async {
    try {
      await _driverService.bookDriver(
        FirebaseAuth.instance.currentUser!.uid,
        driverId,
        months,
        currentAddress,
        dropOffLocation,
      );

      // Success Feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Driver Request Sent!'),
          backgroundColor: Colors.green,
        ),
      );

      // Refresh bookings
      _fetchUserBookings();
    } catch (e) {
      // Error Handling
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to book driver: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Available Drivers',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _searchType = value;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'name',
                child: Text('Search by Name'),
              ),
              PopupMenuItem(
                value: 'vehicle',
                child: Text('Search by Vehicle'),
              ),
              PopupMenuItem(
                value: 'area',
                child: Text('Search by Area'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                // Custom Search Bar
                Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Search drivers...',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Container(
                    width: 100,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchTerm = value;
                  });
                },
              ),
            ),
          ),
          // Drivers List
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child:
                      //  _filteredDrivers.isEmpty
                      //     ? Center(
                      //         child: Text('No drivers found'),
                      //       )
                      //     :
                      ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: availableDrivers.length,
                    itemBuilder: (context, index) {
                      final driver = Driver.fromMap(availableDrivers[index]);
                      return _buildDriverCard(driver);
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Driver driver) {
    final driverData = availableDrivers
        .firstWhere((d) => d['driverID'] == driver.driverID, orElse: () {
      return {
        'estimatedPrice': 3000.0,
        'totalRouteDistance': 2.0,
        'distanceToPickup': 1.0,
        'distanceToDropOff': 1.0
      };
    });

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        driver.vehicleNumber,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.airline_seat_recline_normal,
                              size: 16, color: Colors.grey[600]),
                          Text(
                            ' ${driver.seats} seats',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(
                            ' ${driver.rating}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Est '
                      '${driverData['estimatedPrice'].toStringAsFixed(0)} PKR/mo',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0047BA),
                      ),
                    ),
                    Text(
                      '${driverData['totalRouteDistance'].toStringAsFixed(1)} km total',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: driver.areas.map((area) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    area,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle call action
                    print("driver: ${driverData['estimatedPrice']}");
                  },
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
                ElevatedButton(
                  onPressed: () async {
                    print("driver: ${driverData['estimatedPrice']}");
                    await _confirmDriverBooking(context, driver.driverID, "1")
                        .then((value) => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DriverBookingDetail(
                                driverData: driverData,
                              );
                            })));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047BA),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    const double earthRadius = 6371; // Earth radius in kilometers
    final double dLat = (endLatitude - startLatitude) * (pi / 180);
    final double dLon = (endLongitude - startLongitude) * (pi / 180);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(startLatitude * (pi / 180)) *
            cos(endLatitude * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c; // Distance in kilometers
  }

  Future<void> _fetchNearestDrivers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final drivers = await _driverService.fetchAllDrivers();
      final List<Map<String, dynamic>> nearestDrivers = [];

      // Ensure user location is available
      if (_user?.pickupLatitude == null ||
          _user?.pickupLongitude == null ||
          _user?.dropOffLatitude == null ||
          _user?.dropOffLongitude == null) {
        throw Exception('User location information is incomplete');
      }

      // Constants for pricing
      const double baseDistance = 2.0; // km
      const double basePrice = 3000.0; // PKR
      const double pricePerKm = 1500.0; // PKR per additional km

      for (var driver in drivers) {
        // Null safety checks for driver's location
        final driverLat = driver['latitude'];
        final driverLon = driver['longitude'];
        final driverSchool = driver['school'];

        if (driverLat == null || driverLon == null || driverSchool == null) {
          continue;
        }

        if (driverSchool != _user!.school) {
          continue;
        }

        // Calculate distances
        final distanceToPickup = calculateDistance(
          _user!.pickupLatitude!,
          _user!.pickupLongitude!,
          driverLat,
          driverLon,
        );

        final distanceToDropOff = calculateDistance(
          _user!.dropOffLatitude!,
          _user!.dropOffLongitude!,
          driverLat,
          driverLon,
        );

        // Calculate total route distance
        final totalRouteDistance = distanceToPickup + distanceToDropOff;

        // Calculate estimated price
        double estimatedPrice;
        if (totalRouteDistance <= baseDistance) {
          estimatedPrice = basePrice;
        } else {
          final additionalDistance = totalRouteDistance - baseDistance;
          estimatedPrice = basePrice + (additionalDistance * pricePerKm);
        }
        const maxDistance = 10;
        // Skip drivers that are too far away

        if (distanceToPickup <= maxDistance &&
            distanceToDropOff <= maxDistance) {
          nearestDrivers.add({
            ...driver,
            'distanceToPickup': distanceToPickup,
            'distanceToDropOff': distanceToDropOff,
            'totalRouteDistance': totalRouteDistance,
            'estimatedPrice': estimatedPrice
          });
        }
      }

      // Sort drivers by total route distance
      nearestDrivers.sort(
          (a, b) => a['totalRouteDistance'].compareTo(b['totalRouteDistance']));

      setState(() {
        availableDrivers = nearestDrivers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching nearest drivers: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
