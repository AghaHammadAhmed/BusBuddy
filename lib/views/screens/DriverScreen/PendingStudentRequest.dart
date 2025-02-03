// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../services/driverService.dart';

class PendingStudentReqeust extends StatefulWidget {
  const PendingStudentReqeust({super.key});

  @override
  State<PendingStudentReqeust> createState() => _PendingStudentReqeustState();
}

class _PendingStudentReqeustState extends State<PendingStudentReqeust> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DriverService _driverService = DriverService();
  // List<Map<String, dynamic>> _bookingRequests = [];
  // List<Map<String, dynamic>> _students = [];
  Driver? _driver;
  bool _isLoading = true;

  @override
  initState() {
    super.initState();
    _loadDriver();
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
        print("Driver: $_driver");
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
      Exception(e);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Student Request'),
      ),
      body: Container(
        child: _buildBookingRequestsSection(),
      ),
    );
  }

  //

  Widget _buildBookingRequestsSection() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore
          .collection('booking_requests')
          .where('driver_id', isEqualTo: _driver?.driverID)
          .where('status',
              whereIn: ['pending', 'student_accepted']) // Include both statuses
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error fetching booking requests.'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No booking requests found.'));
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
            final status = booking['status'];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
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
                    Text(
                      'Status: ${status.toUpperCase()}',
                      style: TextStyle(
                        color: _getStatusColor(status),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final proposedFare =
                                await _showFareDialog(context, 'Propose Fare');
                            if (proposedFare != null) {
                              await _respondToBookingByDriver(
                                  booking['id'], proposedFare);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Propose Fare', style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 3),
                        ElevatedButton(
                          onPressed: status == 'student_accepted'
                              ? () async {
                                  final agreedFare =
                                      (booking['fare_agreed'] as num)
                                          .toDouble();
                                  await _finalizeAgreement(
                                      booking['id'], agreedFare);
                                }
                              : null, // Disable if status is not 'student_accepted'
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Confirm' , style: TextStyle(color: Colors.white)),
                        ),
                        const SizedBox(width: 3),
                        ElevatedButton(
                          onPressed: () => _rejectOffer(booking['id']),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Reject' , style: TextStyle(color: Colors.white)),
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
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'student_accepted':
        return Colors.blue;
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
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

  // Future<void> _respondToBookingByDriver(
  //     String bookingId, double proposedFare) async {
  //   try {
  //     await _driverService.respondToBookingByDriver(bookingId, proposedFare);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Proposed fare sent to the student.')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to propose fare: $e')),
  //     );
  //   }
  // }

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

  // Future<void> _finalizeAgreement(String bookingId, double agreedFare) async {
  //   try {
  //     await _driverService.acceptFare(bookingId, agreedFare);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Fare accepted and booking confirmed.')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to accept fare: $e')),
  //     );
  //   }
  // }

  Future<void> _finalizeAgreement(String bookingId, double agreedFare) async {
    try {
      // Fetch the booking details to check the current status
      final bookingDoc =
          await _firestore.collection('booking_requests').doc(bookingId).get();
      final bookingData = bookingDoc.data() as Map<String, dynamic>;
      final status = bookingData['status'];

      if (status == 'student_accepted') {
        // Driver confirms the booking
        await _driverService.confirmBookingByDriver(bookingId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking confirmed by driver.')),
        );
      } else {
        // Student hasn't accepted yet, so only update the fare
        await _driverService.acceptFare(bookingId, agreedFare);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Fare accepted. Waiting for student confirmation.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to finalize agreement: $e')),
      );
    }
  }

// Reject the booking request
  // Future<void> _rejectOffer(String bookingId) async {
  //   try {
  //     await _driverService.rejectOffer(bookingId);
  //     // update the user current driver id to null
  //     await _firestore
  //         .collection("drivers")
  //         .where("userID", isEqualTo: _auth.currentUser!.uid)
  //         .get()
  //         .then((value) {
  //       value.docs.forEach((element) async {
  //         print("Driver ID: ${element.id}");
  //         await _firestore
  //             .collection("users")
  //             .where("currentDriverId", isEqualTo: element.id)
  //             .get()
  //             .then((value) => value.docs.forEach((element) {
  //                   print("User ID: ${element.id}");
  //                   _firestore.collection("users").doc(element.id).update({
  //                     "currentDriverId": null,
  //                   });
  //                 }));
  //       });
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Booking rejected.')),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to reject booking: $e')),
  //     );
  //   }
  // }

  Future<void> _rejectOffer(String bookingId) async {
    try {
      await _driverService.rejectOffer(bookingId);
      // Update the user's current driver ID to null
      await _firestore
          .collection("drivers")
          .where("userID", isEqualTo: _auth.currentUser!.uid)
          .get()
          .then((value) {
        value.docs.forEach((element) async {
          await _firestore
              .collection("users")
              .where("currentDriverId", isEqualTo: element.id)
              .get()
              .then((value) => value.docs.forEach((element) {
                    _firestore.collection("users").doc(element.id).update({
                      "currentDriverId": null,
                    });
                  }));
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking rejected.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject booking: $e')),
      );
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
}
