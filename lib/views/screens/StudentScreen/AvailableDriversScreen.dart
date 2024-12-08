import 'package:busbuddy/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../models/user.dart';
import '../../../services/LocationService.dart';
import '../../../services/driverService.dart';
import '../DriverScreen/DriverInfo.dart';
import 'PaymentScreen.dart';

class AvailableDriversScreen extends StatefulWidget {
  const AvailableDriversScreen({Key? key}) : super(key: key);

  @override
  _AvailableDriversScreenState createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
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

  //fetch user
  Future<void> _fetchUser() async {
    try {
      final user =
          await _userService.fetchUser(FirebaseAuth.instance.currentUser!.uid);
      setState(() {
        currentAddress = user!.address!;
        print(currentAddress);
      });
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  @override
  void initState() {
    super.initState();
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
      });
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

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
      );
    }
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Driver driver) {
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
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(
                            ' ${driver.rating}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.airline_seat_recline_normal,
                              size: 16, color: Colors.grey[600]),
                          Text(
                            ' ${driver.seats} seats',
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
                      '\$${driver.monthlyFee}/mo',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0047BA),
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
                  onPressed: () => _bookDriver(driver.driverID),
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
