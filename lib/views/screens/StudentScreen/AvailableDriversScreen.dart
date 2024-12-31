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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../services/driverService.dart';
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0

class AvailableDriversScreen extends StatefulWidget {
  const AvailableDriversScreen({Key? key}) : super(key: key);

  @override
  _AvailableDriversScreenState createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
<<<<<<< HEAD
  // String selectedArea = 'All Areas';
  // final List<String> areas = [
  //   'All Areas',
  //   'North Campus',
  //   'South Campus',
  //   'City Center'
  // ];
  List<String> areas = [];
  String? selectedArea;

  final TextEditingController _searchController = TextEditingController();
  String _searchType = 'name';
  List<Map<String, dynamic>> _filteredDrivers = [];
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
=======
  String selectedArea = 'All Areas';
  final List<String> areas = [
    'All Areas',
    'North Campus',
    'South Campus',
    'City Center'
  ];

  // Sample drivers data
  // List<Driver> drivers = [
  //   Driver(
  //     driverID: 'D001',
  //     name: 'John Smith',
  //     age: 35,
  //     phone: '+1 (555) 123-4567',
  //     drivingLicenseNumber: 'DL12345678',
  //     rating: 4.8,
  //     seats: 12,
  //     userID: 'U001',
  //     monthlyFee: 150,
  //     vehicleNumber: 'VAN-123',
  //     areas: ['North Campus', 'City Center'],
  //   ),
  //   Driver(
  //     driverID: 'D002',
  //     name: 'Sarah Wilson',
  //     age: 32,
  //     phone: '+1 (555) 987-6543',
  //     drivingLicenseNumber: 'DL87654321',
  //     rating: 4.9,
  //     seats: 8,
  //     userID: 'U002',
  //     monthlyFee: 140,
  //     vehicleNumber: 'VAN-456',
  //     areas: ['South Campus', 'City Center'],
  //   ),
  //   // Add more sample drivers as needed
  // ];

  final DriverService _driverService = DriverService();
  List<Driver> drivers = [];

  Future<void> _loadDrivers() async {
    try {
      final driverData = await _driverService.fetchAllDrivers();
      setState(() {
        drivers = driverData.map((data) => Driver.fromMap(data)).toList();
        print(drivers);
      });
    } catch (e) {
      print('Error loading drivers: $e');
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
    }
  }

  @override
  void initState() {
<<<<<<< HEAD
    super.initState();
    _fetchUserBookings();
    _fetchNearestDrivers();
    _fetchUser();
    _filteredDrivers = availableDrivers;
    _focusNode.addListener(() {
      setState(() {
        _isDropdownVisible = _focusNode.hasFocus;
      });
    });
  }

  void filterDrivers(String searchTerm) {
    setState(() {
      _searchTerm = searchTerm;
      if (searchTerm.isEmpty) {
        _filteredDrivers = availableDrivers;
        return;
      }

      _filteredDrivers = availableDrivers.where((driver) {
        switch (_searchType) {
          case 'name':
            return driver['name']
                .toString()
                .toLowerCase()
                .contains(searchTerm.toLowerCase());
          case 'vehicle':
            return driver['vehicleNumber']
                .toString()
                .toLowerCase()
                .contains(searchTerm.toLowerCase());
          case 'area':
            List<String> areas = List<String>.from(driver['areas'] ?? []);
            return areas.any((area) =>
                area.toLowerCase().contains(searchTerm.toLowerCase()));
          default:
            return false;
        }
      }).toList();
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


=======
    _loadDrivers();
    super.initState();
  }

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
                onChanged: filterDrivers,
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
          Container(
            height: MediaQuery.of(context).size.height - 250,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index];
                print(drivers.length);
                if (drivers.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return _buildDriverCard(driver);
              },
            ),
          ),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
<<<<<<< HEAD
                    print("driver: ${driverData['estimatedPrice']}");
                    await _confirmDriverBooking(context, driver.driverID, "1")
                        .then((value) => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DriverBookingDetail(
                                driverData: driverData,
                              );
                            })));
=======
                    try {
                      String userid = FirebaseAuth.instance.currentUser!.uid;
                      print("current user id: $userid");
                      print("available driver id: ${driver.driverID}");
                      await _driverService
                          .bookDriver(userid, driver.driverID)
                          .then((value) => print("Driver booked"));
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/mainNavigation", (route) => false);
                    } catch (e) {
                      print(e);
                    }
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
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
      const double basePrice = 3000.0; // PKR
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
        const maxDistance = 5;
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

  Widget _buildDropdownItem(String value, String label) {
    return InkWell(
      onTap: () {
        setState(() {
          _searchType = value;
          _isDropdownVisible = false;
          filterDrivers(_searchController.text);
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: _searchType == value ? Colors.blue[50] : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color:
                    _searchType == value ? Colors.blue[900] : Colors.grey[800],
                fontWeight:
                    _searchType == value ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (_searchType == value)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: Colors.blue[900],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DriverSearchScreen extends StatefulWidget {
//   @override
//   _DriverSearchScreenState createState() => _DriverSearchScreenState();
// }

// class _DriverSearchScreenState extends State<DriverSearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchType = 'name';
//   List<DocumentSnapshot> _allDrivers = [];
//   List<DocumentSnapshot> _filteredDrivers = [];
//   bool _isLoading = false;
//   final FocusNode _focusNode = FocusNode();
//   bool _isDropdownVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     loadAllDrivers();
//     _focusNode.addListener(() {
//       setState(() {
//         _isDropdownVisible = _focusNode.hasFocus;
//       });
//     });
//   }

//   Future<void> loadAllDrivers() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('drivers')
//           .orderBy('name')
//           .get();

//       setState(() {
//         _allDrivers = querySnapshot.docs;
//         _filteredDrivers = _allDrivers;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error loading drivers: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   void filterDrivers(String searchTerm) {
//     if (searchTerm.isEmpty) {
//       setState(() {
//         _filteredDrivers = _allDrivers;
//       });
//       return;
//     }

//     setState(() {
//       _filteredDrivers = _allDrivers.where((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         switch (_searchType) {
//           case 'name':
//             return data['name']
//                 .toString()
//                 .toLowerCase()
//                 .contains(searchTerm.toLowerCase());
//           case 'vehicle':
//             return data['vehicleNumber']
//                 .toString()
//                 .toLowerCase()
//                 .contains(searchTerm.toLowerCase());
//           case 'area':
//             List<String> areas = List<String>.from(data['areas'] ?? []);
//             return areas.any((area) =>
//                 area.toLowerCase().contains(searchTerm.toLowerCase()));
//           default:
//             return false;
//         }
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Drivers'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Stack(
//               children: [
//                 // Custom Search Bar
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     focusNode: _focusNode,
//                     decoration: InputDecoration(
//                       hintText: 'Search drivers...',
//                       prefixIcon: Icon(Icons.search),
//                       suffixIcon: Container(
//                         width: 100,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             VerticalDivider(
//                               thickness: 1,
//                               indent: 10,
//                               endIndent: 10,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _isDropdownVisible = !_isDropdownVisible;
//                                   });
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       _searchType.capitalize(),
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                     Icon(
//                                       _isDropdownVisible
//                                           ? Icons.arrow_drop_up
//                                           : Icons.arrow_drop_down,
//                                       color: Colors.grey[600],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     onChanged: filterDrivers,
//                   ),
//                 ),
//                 // Custom Dropdown Menu
//                 if (_isDropdownVisible)
//                   Positioned(
//                     top: 60,
//                     right: 0,
//                     child: Container(
//                       width: 150,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           _buildDropdownItem('name', 'Name'),
//                           _buildDropdownItem('vehicle', 'Vehicle'),
//                           _buildDropdownItem('area', 'Area'),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           // Driver List
//           Expanded(
//             child: _isLoading
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//                     itemCount: _filteredDrivers.length,
//                     itemBuilder: (context, index) {
//                       final driver = _filteredDrivers[index].data()
//                           as Map<String, dynamic>;
//                       return Card(
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             backgroundColor: Colors.blue[100],
//                             child: Icon(
//                               Icons.person,
//                               color: Colors.blue[900],
//                             ),
//                           ),
//                           title: Text(
//                             driver['name'] ?? 'N/A',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           subtitle: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Vehicle: ${driver['vehicleNumber'] ?? 'N/A'}',
//                                 style: TextStyle(color: Colors.grey[700]),
//                               ),
//                               Text(
//                                 'Areas: ${(driver['areas'] as List?)?.join(', ') ?? 'N/A'}',
//                                 style: TextStyle(color: Colors.grey[700]),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Navigator.pop(context, driver);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDropdownItem(String value, String label) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _searchType = value;
//           _isDropdownVisible = false;
//           filterDrivers(_searchController.text);
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: _searchType == value ? Colors.blue[50] : Colors.white,
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey[200]!,
//               width: 1,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color:
//                     _searchType == value ? Colors.blue[900] : Colors.grey[800],
//                 fontWeight:
//                     _searchType == value ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//             if (_searchType == value)
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Icon(
//                   Icons.check,
//                   size: 16,
//                   color: Colors.blue[900],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
// }

// // Extension to capitalize first letter
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }

// import 'package:flutter/material.dart';

// class DriverSearchScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> availableDrivers;

//   const DriverSearchScreen({
//     Key? key,
//     required this.availableDrivers,
//   }) : super(key: key);

//   @override
//   _DriverSearchScreenState createState() => _DriverSearchScreenState();
// }

// class _DriverSearchScreenState extends State<DriverSearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchType = 'name';
//   List<Map<String, dynamic>> _filteredDrivers = [];
//   final FocusNode _focusNode = FocusNode();
//   bool _isDropdownVisible = false;

//   @override
//   void initState() {
//     super.initState();
//     _filteredDrivers = widget.availableDrivers;
//     _focusNode.addListener(() {
//       setState(() {
//         _isDropdownVisible = _focusNode.hasFocus;
//       });
//     });
//   }

//   void filterDrivers(String searchTerm) {
//     if (searchTerm.isEmpty) {
//       setState(() {
//         _filteredDrivers = widget.availableDrivers;
//       });
//       return;
//     }

//     setState(() {
//       _filteredDrivers = widget.availableDrivers.where((driver) {
//         switch (_searchType) {
//           case 'name':
//             return driver['name'].toString().toLowerCase()
//                 .contains(searchTerm.toLowerCase());
//           case 'vehicle':
//             return driver['vehicleNumber'].toString().toLowerCase()
//                 .contains(searchTerm.toLowerCase());
//           case 'area':
//             List<String> areas = List<String>.from(driver['areas'] ?? []);
//             return areas.any((area) =>
//                 area.toLowerCase().contains(searchTerm.toLowerCase()));
//           default:
//             return false;
//         }
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Available Drivers'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Stack(
//               children: [
//                 // Custom Search Bar
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 8,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     focusNode: _focusNode,
//                     decoration: InputDecoration(
//                       hintText: 'Search drivers...',
//                       prefixIcon: Icon(Icons.search),
//                       suffixIcon: Container(
//                         width: 100,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             VerticalDivider(
//                               thickness: 1,
//                               indent: 10,
//                               endIndent: 10,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8.0),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     _isDropdownVisible = !_isDropdownVisible;
//                                   });
//                                 },
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       _searchType.capitalize(),
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                     Icon(
//                                       _isDropdownVisible
//                                           ? Icons.arrow_drop_up
//                                           : Icons.arrow_drop_down,
//                                       color: Colors.grey[600],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide.none,
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                     onChanged: filterDrivers,
//                   ),
//                 ),
//                 // Custom Dropdown Menu
//                 if (_isDropdownVisible)
//                   Positioned(
//                     top: 60,
//                     right: 0,
//                     child: Container(
//                       width: 150,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         children: [
//                           _buildDropdownItem('name', 'Name'),
//                           _buildDropdownItem('vehicle', 'Vehicle'),
//                           _buildDropdownItem('area', 'Area'),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           // Driver List
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredDrivers.length,
//               itemBuilder: (context, index) {
//                 final driver = _filteredDrivers[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.blue[100],
//                       child: Icon(
//                         Icons.person,
//                         color: Colors.blue[900],
//                       ),
//                     ),
//                     title: Text(
//                       driver['name'] ?? 'N/A',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Vehicle: ${driver['vehicleNumber'] ?? 'N/A'}',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                         Text(
//                           'Areas: ${(driver['areas'] as List?)?.join(', ') ?? 'N/A'}',
//                           style: TextStyle(color: Colors.grey[700]),
//                         ),
//                         Text(
//                           'Distance: ${driver['distance']?.toStringAsFixed(2) ?? 'N/A'} km',
//                           style: TextStyle(
//                             color: Colors.blue[700],
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                     onTap: () {
//                       Navigator.pop(context, driver);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDropdownItem(String value, String label) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _searchType = value;
//           _isDropdownVisible = false;
//           filterDrivers(_searchController.text);
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         decoration: BoxDecoration(
//           color: _searchType == value ? Colors.blue[50] : Colors.white,
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey[200]!,
//               width: 1,
//             ),
//           ),
//         ),
//         child: Row(
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color: _searchType == value ? Colors.blue[900] : Colors.grey[800],
//                 fontWeight: _searchType == value ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//             if (_searchType == value)
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: Icon(
//                   Icons.check,
//                   size: 16,
//                   color: Colors.blue[900],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _focusNode.dispose();
//     super.dispose();
//   }
// }

// // Extension to capitalize first letter
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${this.substring(1)}";
//   }
// }
=======
}
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
