<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:busbuddy/models/user.dart';
import 'package:busbuddy/services/AuthService.dart';
import 'package:busbuddy/views/screens/StudentScreen/DriverBookingDetail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../models/driver.dart';
import '../../../services/driverService.dart';
import 'dart:math';
=======
import 'package:busbuddy/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/LocationService.dart';
import '../../../services/driverService.dart';
import '../DriverScreen/DriverInfo.dart';
import 'PaymentScreen.dart';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e

class AvailableDriversScreen extends StatefulWidget {
  const AvailableDriversScreen({Key? key}) : super(key: key);

  @override
  _AvailableDriversScreenState createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
<<<<<<< HEAD
 
  List<String> areas = [];
  String? selectedArea;

  final TextEditingController _searchController = TextEditingController();
  String _searchType = 'name';

  final FocusNode _focusNode = FocusNode();
  bool _isDropdownVisible = false;
  final DriverService _driverService = DriverService();

  String _searchTerm = '';
  final UserService _userService = UserService();
  List<Driver> drivers = [];
  List<Map<String, dynamic>> availableDrivers = [];
  Map<String, dynamic>? userBooking;
  bool isLoading = false;
  String currentAddress = '';
  String dropOffLocation = '';
  UserModel? _user;
=======
  String selectedArea = 'All Areas';
  final List<String> areas = [
    'All Areas',
    'North Campus',
    'South Campus',
    'City Center'
  ];
  final DriverService _driverService = DriverService();
  final LocationService _locationService = LocationService();
  final UserService _userService = UserService();
  List<Driver> drivers = [];
  List<Map<String, dynamic>> availableDrivers = [];
  List<Map<String, dynamic>> userBookings = [];
  bool isLoading = false;
  String currentAddress = '';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e

  //fetch user
  Future<void> _fetchUser() async {
    try {
      final user =
          await _userService.fetchUser(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        currentAddress = user!.address!;
<<<<<<< HEAD
        dropOffLocation = user.dropOffLocation!;
        _user = user;
      
=======
        print(currentAddress);
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      });
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
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
      
=======
    _fetchAvailableDrivers();
    _fetchUserBookings();
    _fetchUser();
  }

  Future<void> _fetchAvailableDrivers() async {
    setState(() {
      isLoading = true;
    });

    try {
      final drivers = await _driverService.fetchAllDrivers();
      setState(() {
        availableDrivers = drivers;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching drivers: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
    }
  }

<<<<<<< HEAD
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
=======
  Future<void> _bookDriver(String driverId) async {
    final TextEditingController durationController = TextEditingController();
    final TextEditingController pickupController =
        TextEditingController(text: currentAddress);
    final TextEditingController dropoffController = TextEditingController();
  
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Driver'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: durationController,
              decoration:
                  const InputDecoration(labelText: 'Duration (in Months)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              //unselected text
              readOnly: true,
              controller: pickupController,
              decoration: const InputDecoration(labelText: 'Pickup Location'),
            ),
            TextField(
              controller: dropoffController,
              decoration: const InputDecoration(labelText: 'Dropoff Location'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await _driverService.bookDriver(
                  FirebaseAuth.instance.currentUser!.uid,
                  driverId,
                  durationController.text,
                  pickupController.text,
                  dropoffController.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Driver booked successfully')),
                );
                _fetchUserBookings(); // Refresh user bookings
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to book driver: $e')),
                );
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
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
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
      );
    }
  }

<<<<<<< HEAD
=======
  // Future<void> _loadDrivers() async {
  //   try {
  //     final driverData = await _driverService.fetchAllDrivers();
  //     setState(() {
  //       drivers = driverData.map((data) => Driver.fromMap(data)).toList();
  //       print(drivers);
  //     });
  //   } catch (e) {
  //     print('Error loading drivers: $e');
  //   }
  // }

  // @override
  // void initState() {
  //   _loadDrivers();
  //   super.initState();
  // }
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e

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
<<<<<<< HEAD
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
            itemBuilder: (context) => [
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
=======
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Show filter options
            },
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
<<<<<<< HEAD
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
                            final driver =
                                Driver.fromMap(availableDrivers[index]);
                            return _buildDriverCard(driver);
                          },
                        ),
=======
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search drivers...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF0047BA), width: 2),
                ),
              ),
            ),
          ),
          // Area Filter
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: areas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(areas[index]),
                    selected: selectedArea == areas[index],
                    onSelected: (bool selected) {
                      setState(() {
                        selectedArea = areas[index];
                      });
                    },
                    backgroundColor: Colors.grey[50],
                    selectedColor: const Color(0xFF0047BA).withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: selectedArea == areas[index]
                          ? const Color(0xFF0047BA)
                          : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: selectedArea == areas[index]
                            ? const Color(0xFF0047BA)
                            : Colors.grey[300]!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Drivers List
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: MediaQuery.of(context).size.height - 250,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: availableDrivers.length,
                    itemBuilder: (context, index) {
                      final driver = Driver.fromMap(availableDrivers[index]);
                      return _buildDriverCard(driver);
                    },
                  ),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
                ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Driver driver) {
<<<<<<< HEAD
    final driverData = availableDrivers
        .firstWhere((d) => d['driverID'] == driver.driverID, orElse: () {
      return {
        'estimatedPrice': 3000.0,
        'totalRouteDistance': 2.0,
        'distanceToPickup': 1.0,
        'distanceToDropOff': 1.0
      };
    });

=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
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
<<<<<<< HEAD
                      const SizedBox(height: 4),
                      Row(
                        children: [
=======
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(
                            ' ${driver.rating}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
                          Icon(Icons.airline_seat_recline_normal,
                              size: 16, color: Colors.grey[600]),
                          Text(
                            ' ${driver.seats} seats',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
<<<<<<< HEAD
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
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
<<<<<<< HEAD
                      'Est '
                      '${driverData['estimatedPrice'].toStringAsFixed(0)} PKR/mo',
=======
                      '\$${driver.monthlyFee}/mo',
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0047BA),
                      ),
                    ),
<<<<<<< HEAD
                    Text(
                      '${driverData['totalRouteDistance'].toStringAsFixed(1)} km total',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
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
<<<<<<< HEAD
                    print("driver: ${driverData['estimatedPrice']}");
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
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
<<<<<<< HEAD
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
=======
                  onPressed: () => _bookDriver(driver.driverID),
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
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
<<<<<<< HEAD

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
      const double basePrice = 4000.0; // PKR
      const double pricePerKm = 1500.0; // PKR per additional km

      for (var driver in drivers) {
        // Null safety checks for driver's location
        final driverLat = driver['latitude'];
        final driverLon = driver['longitude'];

        if (driverLat == null || driverLon == null) {
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
        const maxDistance = 200;
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


=======
}

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../../../services/driverService.dart';

// class AvailableDriverScreen extends StatefulWidget {
//   const AvailableDriverScreen({Key? key}) : super(key: key);

//   @override
//   State<AvailableDriverScreen> createState() => _AvailableDriverScreenState();
// }

// class _AvailableDriverScreenState extends State<AvailableDriverScreen> {
//   final DriverService _driverService = DriverService();
//   List<Map<String, dynamic>> availableDrivers = [];
//   List<Map<String, dynamic>> userBookings = [];
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _fetchAvailableDrivers();
//     _fetchUserBookings();
//   }

//   Future<void> _fetchAvailableDrivers() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final drivers = await _driverService.fetchAllDrivers();
//       setState(() {
//         availableDrivers = drivers;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error fetching drivers: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _fetchUserBookings() async {
//     try {
//       final FirebaseAuth _auth = FirebaseAuth.instance;
//       final User? user = _auth.currentUser;

//       if (user == null) return;

//       final bookings = await _driverService.fetchUserBookings(user.uid);
//       setState(() {
//         userBookings = bookings;
//       });
//     } catch (e) {
//       print("Error fetching bookings: $e");
//     }
//   }

//   Future<void> _bookDriver(String driverId) async {
//     final TextEditingController durationController = TextEditingController();
//     final TextEditingController pickupController = TextEditingController();
//     final TextEditingController dropoffController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Book Driver'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: durationController,
//               decoration: const InputDecoration(labelText: 'Duration (in Months)'),
//               keyboardType: TextInputType.number,
//             ),
//             TextField(
//               controller: pickupController,
//               decoration: const InputDecoration(labelText: 'Pickup Location'),
//             ),
//             TextField(
//               controller: dropoffController,
//               decoration: const InputDecoration(labelText: 'Dropoff Location'),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.of(context).pop();
//               try {
//                 await _driverService.bookDriver(
//                   FirebaseAuth.instance.currentUser!.uid,
//                   driverId,
//                   durationController.text,
//                   pickupController.text,
//                   dropoffController.text,
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Driver booked successfully')),
//                 );
//                 _fetchUserBookings(); // Refresh user bookings
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Failed to book driver: $e')),
//                 );
//               }
//             },
//             child: const Text('Confirm'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _cancelBooking(String bookingId) async {
//     try {
//       await _driverService.cancelBooking(bookingId);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Booking successfully canceled')),
//       );
//       _fetchUserBookings(); // Refresh bookings
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to cancel booking: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Available Drivers'),
//         centerTitle: true,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Expanded(
//                   child: availableDrivers.isEmpty
//                       ? const Center(
//                           child: Text('No available drivers at the moment'),
//                         )
//                       : ListView.builder(
//                           itemCount: availableDrivers.length,
//                           itemBuilder: (context, index) {
//                             final driver = availableDrivers[index];
//                             return ListTile(
//                               leading: const Icon(Icons.drive_eta),
//                               title: Text(driver['name'] ?? 'Driver Name'),
//                               subtitle:
//                                   Text('Rating: ${driver['rating'] ?? 'N/A'}'),
//                               trailing: ElevatedButton(
//                                 onPressed: () => _bookDriver(driver['id']),
//                                 child: const Text('Book'),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//                 const Divider(),
//                 Expanded(
//                   child: userBookings.isEmpty
//                       ? const Center(
//                           child: Text('No bookings found'),
//                         )
//                       : ListView.builder(
//                           itemCount: userBookings.length,
//                           itemBuilder: (context, index) {
//                             final booking = userBookings[index];
//                             return ListTile(
//                               leading: const Icon(Icons.book_online),
//                               title: Text('Driver ID: ${booking['driver_id']}'),
//                               subtitle: Text(
//                                   'Status: ${booking['status']}\nPickup: ${booking['pickup_location']}\nDropoff: ${booking['dropoff_location']}'),
//                               trailing: booking['status'] == 'pending'
//                                   ? ElevatedButton(
//                                       onPressed: () =>
//                                           _cancelBooking(booking['id']),
//                                       child: const Text('Cancel'),
//                                     )
//                                   : null,
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
