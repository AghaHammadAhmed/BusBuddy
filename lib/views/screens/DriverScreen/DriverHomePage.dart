// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../../models/driver.dart';
// import 'DriverMapView.dart';

// class DriverHomePage extends StatefulWidget {
//   const DriverHomePage({super.key});

//   @override
//   _DriverHomePageState createState() => _DriverHomePageState();
// }

// class _DriverHomePageState extends State<DriverHomePage> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   FirebaseAuth userCredential = FirebaseAuth.instance;
//   List<Map<String, dynamic>> _students = []; // List of students
//   @override
//   void initState() {
//     super.initState();
//     _loadDriver();
//   }

//   Driver? _driver; // Driver instance
//   bool _isLoading = true; // Loading state

//   Future<Driver?> _fetchDriverByUserId() async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
//           .collection('drivers')
//           .where('userID', isEqualTo: userCredential.currentUser!.uid)
//           .limit(1) // Fetch only one document
//           .get();

//       if (driverQuery.docs.isNotEmpty) {
//         final driverData = driverQuery.docs.first.data();
//         print("Driver fetched: ${driverData}");
//         return Driver.fromJson(driverData); // Convert to Driver object
//       }
//       print("No driver found.");
//       return null; // No driver found
//     } catch (e) {
//       print("Failed to fetch driver: $e");
//       return null;
//     }
//   }

//   Future<void> _fetchStudents(String driverId) async {
//     try {
//       QuerySnapshot<Map<String, dynamic>> studentQuery = await _firestore
//           .collection('users')
//           .where('role', isEqualTo: 'student') // Filter by role
//           .where('currentDriverId', isEqualTo: driverId) // Match driver ID
//           .get();

//       if (studentQuery.docs.isNotEmpty) {
//         setState(() {
//           _students = studentQuery.docs
//               .map((doc) => doc.data()) // Convert documents to map
//               .toList();
//         });
//         print("Students fetched: ${_students.length}");
//       } else {
//         print("No students found.");
//       }
//     } catch (e) {
//       print("Failed to fetch students: $e");
//     }
//   }

//   Future<void> _loadDriver() async {
//     try {
//       Driver? fetchedDriver = await _fetchDriverByUserId();

//       if (fetchedDriver != null) {
//         await _fetchStudents(fetchedDriver.driverID);
//       }
//       setState(() {
//         _driver = fetchedDriver;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         toolbarHeight: 50,
//         elevation: 0,
//         leading: IconButton(
//           color: Colors.black,
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             // Navigate to menu screen
//           },
//         ),
//         actions: [
//           IconButton(
//             color: Colors.black,
//             icon: const Icon(Icons.notifications_none),
//             onPressed: () {
//               // Navigate to notifications screen
//             },
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _driver == null
//               ? const Center(child: Text('No driver found.'))
//               : SafeArea(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildProfileSection(_driver!),
//                           const SizedBox(height: 20),
//                           _buildStudentsSection(),
//                           const SizedBox(height: 20),
//                           _buildManageSection(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//     );
//   }

//   Widget _buildStudentsSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Your Rides',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         _students.isEmpty
//             ? //placeholder for no students allocated with 200 height
//             SizedBox(height: 200, child: const Center(child: Text('No rides', style: TextStyle(fontSize: 16))))
//             : SizedBox(
//                 height: 320,
//                 child: SingleChildScrollView(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: _students.length,
//                     itemBuilder: (context, index) {
//                       final student = _students[index];
//                       return Card(
//                           elevation: 2,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8)),
//                           child: ListTile(
//                               leading:
//                                   const Icon(Icons.person, color: Colors.blue),
//                               title: Text(
//                                 student['name'],
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               subtitle: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('pick Up: ${student['address']}'),
//                                   //button to call on left and track on right
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           // Call student
//                                         },
//                                         //elevated Style
//                                         style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(8),
//                                           ),
//                                         ),
//                                         child: const Text('Call'),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               )));
//                     },
//                   ),
//                 ),
//               ),
//       ],
//     );
//   }

//   Widget _buildProfileSection(Driver driver) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//       child: Row(
//         children: [
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   driver.name,
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Icon(Icons.star, color: Colors.orange, size: 16),
//                     SizedBox(width: 4),
//                     Text(
//                       '${driver.rating} Rating',
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   'Vehicle: ${driver.vehicleNumber}',
//                   style: TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildManageSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Manage',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildManageCard(
//               icon: Icons.map_outlined,
//               label: 'Map View',
//               onTap: () {
//                 // Navigate to map screen
//                 print("Driver ID: ${_driver!.driverID}");
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DriverLiveLocation(
//                               driverId: _driver!.driverID,
//                             )));
//               },
//             ),
//             _buildManageCard(
//               icon: Icons.schedule_outlined,
//               label: 'Schedule',
//               onTap: () {
//                 // Navigate to schedule screen
//               },
//             ),
//             _buildManageCard(
//               icon: Icons.message_outlined,
//               label: 'Messages',
//               onTap: () {
//                 // Navigate to message screen
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildManageCard({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: SizedBox(
//           width: 100,
//           height: 100,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 30, color: Colors.blue),
//               const SizedBox(height: 8),
//               Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../services/driverService.dart';
import 'DriverMapView.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DriverService _driverService = DriverService();
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> _bookingRequests = [];

  Driver? _driver;
  bool _isLoading = true;

  // Handle proposing a fare by the driver
  Future<void> _respondToBookingByDriver(
      String bookingId, double proposedFare) async {
    try {
      await _driverService.respondToBookingByDriver(bookingId, proposedFare);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proposed fare sent to the student.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to propose fare: $e')),
      );
    }
  }

// Finalize the booking agreement
  Future<void> _finalizeAgreement(String bookingId, double agreedFare) async {
    try {
      await _driverService.acceptFare(bookingId, agreedFare);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fare accepted and booking confirmed.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept fare: $e')),
      );
    }
  }

// Reject the booking request
  Future<void> _rejectOffer(String bookingId) async {
    try {
      await _driverService.rejectOffer(bookingId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking rejected.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject booking: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDriver();
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
          _students = studentQuery.docs.map((doc) => doc.data()).toList();
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
          _bookingRequests = bookingQuery.docs
              .map((doc) => {'id': doc.id, ...doc.data()})
              .toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
        elevation: 0,
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
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
                          _buildStudentsSection(),
                          const SizedBox(height: 20),
                          _buildBookingRequestsSection(),
                          const SizedBox(height: 20),
                          // _buildManageSection(),
                        ],
                      ),
                    ),
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

  Widget _buildStudentsSection() {
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
        _students.isEmpty
            ? SizedBox(
                height: 200,
                child: const Center(
                  child: Text(
                    'No rides',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _students.length,
                itemBuilder: (context, index) {
                  final student = _students[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.blue),
                      title: Text(
                        student['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Pickup: ${student['address']}'),
                    ),
                  );
                },
              ),
      ],
    );
  }

  Widget _buildBookingRequestsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Booking Requests',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _firestore
              .collection('booking_requests')
              .where('driver_id', isEqualTo: _driver?.driverID)
              .where('status', whereIn: ['pending']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching booking requests.'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'No booking requests at the moment.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            }

            final bookingRequests = snapshot.data!.docs
                .map((doc) => {'id': doc.id, ...doc.data()})
                .toList();

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookingRequests.length,
              itemBuilder: (context, index) {
                final booking = bookingRequests[index];

                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pickup: ${booking['pickup_location']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Dropoff: ${booking['dropoff_location']}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Proposed Fare by Driver: ${booking['fare_proposed_by_driver'].toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Proposed Fare by Student: ${booking['fare_counter_by_student'].toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final proposedFare = await _showFareDialog(
                                    context, 'Propose Fare');
                                if (proposedFare != null) {
                                  await _respondToBookingByDriver(
                                      booking['id'], proposedFare);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text('Propose Fare'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () async {
                                final agreedFare =
                                    booking['fare_proposed_by_student'];
                                await _finalizeAgreement(
                                    booking['id'], agreedFare);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('Accept'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _rejectOffer(booking['id']),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Reject'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Future<double?> _showFareDialog(BuildContext context, String title) async {
    final TextEditingController fareController = TextEditingController();
    return showDialog<double>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: fareController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Fare',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final fare = double.tryParse(fareController.text);
                if (fare != null && fare > 0) {
                  Navigator.of(context).pop(fare);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please enter a valid fare.'),
                  ));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Widget _buildBookingRequestsSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'Booking Requests',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 12),
  //       StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  //         stream: _firestore
  //             .collection('booking_requests')
  //             .where('driver_id', isEqualTo: _driver?.driverID)
  //             .where('status', isEqualTo: 'pending')
  //             .snapshots(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const Center(child: CircularProgressIndicator());
  //           }

  //           if (snapshot.hasError) {
  //             return const Center(
  //               child: Text('Error fetching booking requests.'),
  //             );
  //           }

  //           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //             return const SizedBox(
  //               height: 200,
  //               child: Center(
  //                 child: Text(
  //                   'No booking requests at the moment.',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //               ),
  //             );
  //           }

  //           final bookingRequests = snapshot.data!.docs
  //               .map((doc) => {'id': doc.id, ...doc.data()})
  //               .toList();

  //           return ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: bookingRequests.length,
  //             itemBuilder: (context, index) {
  //               final booking = bookingRequests[index];
  //               return Card(
  //                 elevation: 2,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: ListTile(
  //                   leading:
  //                       const Icon(Icons.directions_car, color: Colors.blue),
  //                   title: Text('Pickup: ${booking['pickup_location']}'),
  //                   subtitle: Text('Dropoff: ${booking['dropoff_location']}'),
  //                   trailing: Row(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       ElevatedButton(
  //                         onPressed: () =>
  //                             _respondToBooking(booking['id'], true),
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.green,
  //                         ),
  //                         child: const Text('Accept'),
  //                       ),
  //                       const SizedBox(width: 8),
  //                       ElevatedButton(
  //                         onPressed: () =>
  //                             _respondToBooking(booking['id'], false),
  //                         style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.red,
  //                         ),
  //                         child: const Text('Reject'),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }
}
