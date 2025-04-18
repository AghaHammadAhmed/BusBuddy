<<<<<<< HEAD
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DriverService {
//   final CollectionReference _driverCollection =
//       FirebaseFirestore.instance.collection('drivers');
//   final CollectionReference _userCollection =
//       FirebaseFirestore.instance.collection('users');
//   final CollectionReference _bookingRequestCollection =
//       FirebaseFirestore.instance.collection('booking_requests');
//   final CollectionReference _ridesCollection =
//       FirebaseFirestore.instance.collection('rides');

//   //fetch user details
//   Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
//     try {
//       final userDoc = await _userCollection.doc(userId).get();
//       return userDoc.data() as Map<String, dynamic>;
//     } catch (e) {
//       throw Exception("Error fetching user details: $e");
//     }
//   }

//   // Add a new driver
//   Future<void> addDriver(String userID, Map<String, dynamic> driverData) async {
//     try {
//       // Create document reference with desired ID (userID in this case)
//       DocumentReference docRef = _driverCollection.doc(userID);

//       // Prepare driver data
//       driverData['createdAt'] = FieldValue.serverTimestamp();
//       driverData['updatedAt'] = FieldValue.serverTimestamp();
//       driverData['userID'] = userID;
//       driverData['driverID'] = docRef.id; // Same as document ID
//       driverData['faceImage'] = null;
//       driverData['cnicFrontImage'] = null;
//       driverData['cnicBackImage'] = null;
//       driverData['verificationStatus'] = 'pending';
//       driverData['carVanImages'] = [];

//       // Set data to the document reference
//       await docRef.set(driverData);
//     } catch (e) {
//       throw Exception("Error adding driver: $e");
//     }
//   }

//   //update new fields in driver
//   Future<void> updateDriverDetails(
//       String driverId, Map<String, dynamic> updatedData) async {
//     try {
//       updatedData['updatedAt'] = FieldValue.serverTimestamp();
//       await _driverCollection.doc(driverId).update(updatedData);
//     } catch (e) {
//       throw Exception("Error updating driver: $e");
//     }
//   }

//   Future<void> bookDriver(String userId, String driverId, String duration,
//       String pickup, String dropoff) async {
//     try {
//       await _userCollection.doc(userId).update({
//         'currentDriverId': driverId,
//       });

//       final bookingRequest = {
//         "student_id": FirebaseAuth.instance.currentUser!.uid,
//         "driver_id": driverId,
//         // "doc_id": _bookingRequestCollection.doc().id,
//         "status": "pending",
//         "duration": duration,
//         "pickup_location": pickup,
//         "dropoff_location": dropoff,
//         "fare_proposed_by_driver": 0.0,
//         "fare_counter_by_student": 0.0,
//         "fare_agreed": 0.0,
//         "timestamp": FieldValue.serverTimestamp(),
//       };

//       await _bookingRequestCollection.add(bookingRequest);
//     } catch (e) {
//       throw Exception('Failed to book driver: $e');
//     }
//   }

//   Future<void> respondToBookingByDriver(
//       String bookingId, double proposedFare) async {
//     await _bookingRequestCollection.doc(bookingId).update({
//       "fare_proposed_by_driver": proposedFare,
//       "status": "pending",
//     });
//   }

//   Future<void> proposeCounterFare(String bookingId, double fare) async {
//     await _bookingRequestCollection.doc(bookingId).update({
//       'fare_counter_by_student': fare,
//       'status': 'pending',
//     });
//   }

//   Future<void> negotiateFare(String bookingId, double newProposedFare) async {
//     try {
//       await _bookingRequestCollection.doc(bookingId).update({
//         "fare_proposed_by_driver": newProposedFare,
//         "status": "pending",
//         "last_updated_by": "driver",
//       });

//       // Optionally notify the student about the new proposed fare
//     } catch (e) {
//       throw Exception('Error negotiating fare: $e');
//     }
//   }

//   Future<void> allocateDriverToStudent(
//       String driverId,
//       String studentId,
//       Map<String, dynamic> coordinates,
//       Map<String, dynamic> dropoffCoordinates) async {
//     try {
//       await _ridesCollection
//           .doc(driverId)
//           .collection('students')
//           .doc(studentId)
//           .set({
//         'pickUpCoordinates': coordinates,
//         'dropOffCoordinates': dropoffCoordinates,
//         'status': 'active',
//         'allocatedAt': DateTime.now().toIso8601String(),
//       });
//       print('Driver allocated successfully to student.');
//     } catch (e) {
//       throw Exception('Failed to allocate driver to student: $e');
//     }
//   }

//   // Accept fare and confirm booking
//   // Future<void> acceptFare(String bookingId, double agreedFare) async {
//   //   try {
//   //     await _bookingRequestCollection.doc(bookingId).update({
//   //       "fare_agreed": agreedFare,
//   //       "status": "confirmed",
//   //     });
//   //   } catch (e) {
//   //     throw Exception('Error accepting fare: $e');
//   //   }
//   // }

//   Future<void> acceptFare(String bookingId, double agreedFare) async {
//     try {
//       await _bookingRequestCollection.doc(bookingId).update({
//         "fare_agreed": agreedFare,
//         "status": "student_accepted", // Updated status
//       });
//     } catch (e) {
//       throw Exception('Error accepting fare: $e');
//     }
//   }

//   Future<void> updateBookingStatus(
//       String bookingId, String status, double amount) async {
//     try {
//       await _bookingRequestCollection.doc(bookingId).update({
//         'status': status,
//         'payment_amount': amount,
//         'payment_timestamp': FieldValue.serverTimestamp(),
//       });

//       if (status == 'payment_success') {

//       }
//     } catch (e) {
//       throw Exception('Error updating booking status: $e');
//     }
//   }

// // Add method for driver's confirmation
//   Future<void> confirmBookingByDriver(String bookingId) async {
//     try {
//       await _bookingRequestCollection.doc(bookingId).update({
//         "status": "confirmed",
//       });
//     } catch (e) {
//       throw Exception('Error confirming booking: $e');
//     }
//   }

//   Future<void> rejectOffer(String bookingId) async {
//     try {
//       await _bookingRequestCollection.doc(bookingId).update({
//         "status": "cancelled",
//       });
//     } catch (e) {
//       throw Exception('Error rejecting offer: $e');
//     }
//   }

//   Future<void> addNegotiationStep(
//       String bookingId, double proposedFare, String proposedBy) async {
//     try {
//       DocumentReference negotiationDoc = _bookingRequestCollection
//           .doc(bookingId)
//           .collection('negotiation_history')
//           .doc();
//       await negotiationDoc.set({
//         "proposed_fare": proposedFare,
//         "proposed_by": proposedBy,
//         "timestamp": FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       throw Exception('Error adding negotiation step: $e');
//     }
//   }

//   // Fetch all drivers
//   Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
//     try {
//       final querySnapshot = await _driverCollection.get();
//       return querySnapshot.docs
//           .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
//           .toList();
//     } catch (e) {
//       throw Exception("Error fetching drivers: $e");
//     }
//   }

//   // Cancel a booking
//   Future<void> cancelBooking(String bookingId) async {
//     try {
//       await _bookingRequestCollection.doc(bookingId).update({
//         "status": "cancelled",
//       });
//       // update the user
//       await _userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
//         'currentDriverId': null,
//       });
//     } catch (e) {
//       throw Exception('Error cancelling booking: $e');
//     }
//   }

//   Future<Map<String, dynamic>> fetchUserBooking(String userId) async {
//     try {
//       final userDoc = await _userCollection.doc(userId).get();
//       final querySnapshot = await _bookingRequestCollection
//           .where("student_id", isEqualTo: userId)
//           .where("driver_id", isEqualTo: userDoc.get('currentDriverId'))
//           .orderBy("timestamp", descending: true)
//           .limit(1)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         final doc = querySnapshot.docs.first;
//         return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
//       } else {
//         throw Exception("No booking found for the user.");
//       }
//     } catch (e) {
//       throw Exception("Error fetching booking: $e");
//     }
//   }

//   // Fetch bookings for a specific driver
//   Future<List<Map<String, dynamic>>> fetchDriverBookings(
//       String driverId) async {
//     try {
//       final querySnapshot = await _bookingRequestCollection
//           .where("driver_id", isEqualTo: driverId)
//           .orderBy("timestamp", descending: true)
//           .get();
//       return querySnapshot.docs
//           .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
//           .toList();
//     } catch (e) {
//       throw Exception("Error fetching bookings: $e");
//     }
//   }

//   //fetch driver by userId
//   Future<Map<String, dynamic>> fetchDriverByUserId(String userId) async {
//     try {
//       final querySnapshot = await _driverCollection
//           .where('userID', isEqualTo: userId)
//           .limit(1)
//           .get();
//       if (querySnapshot.docs.isNotEmpty) {
//         final doc = querySnapshot.docs.first;
//         return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
//       } else {
//         throw Exception("Driver not found.");
//       }
//     } catch (e) {
//       throw Exception("Error fetching driver: $e");
//     }
//   }

//   // Update driver details
//   Future<void> updateDriver(
//       String driverId, Map<String, dynamic> updatedData) async {
//     try {
//       updatedData['updatedAt'] = FieldValue.serverTimestamp();
//       await _driverCollection.doc(driverId).update(updatedData);
//     } catch (e) {
//       throw Exception("Error updating driver: $e");
//     }
//   }

//   // Delete a driver
//   Future<void> deleteDriver(String driverId) async {
//     try {
//       await _driverCollection.doc(driverId).delete();
//     } catch (e) {
//       throw Exception("Error deleting driver: $e");
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _driverCollection => _firestore.collection('drivers');
  CollectionReference get _userCollection => _firestore.collection('users');
  CollectionReference get _bookingRequestCollection =>
      _firestore.collection('booking_requests');
  CollectionReference get _ridesCollection => _firestore.collection('rides');

  // Fetch user details
  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    try {
      final userDoc = await _userCollection.doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('User document not found');
      }
      return userDoc.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error fetching user details: ${e.toString()}');
    }
  }
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
class DriverService {
  final CollectionReference _driverCollection =
      FirebaseFirestore.instance.collection('drivers');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');
  final CollectionReference _ridesCollection =
      FirebaseFirestore.instance.collection('rides');
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');
<<<<<<< HEAD
  final CollectionReference _ridesCollection =
      FirebaseFirestore.instance.collection('rides');
=======
<<<<<<< HEAD
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  //fetch user details
  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    try {
      final userDoc = await _userCollection.doc(userId).get();
      return userDoc.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Error fetching user details: $e");
    }
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> _driverCollection1 =
      FirebaseFirestore.instance
          .collection('drivers')
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snapshot, _) => snapshot.data()!,
            toFirestore: (data, _) => data,
          );
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

  // Add a new driver
  Future<void> addDriver(String userID, Map<String, dynamic> driverData) async {
    try {
<<<<<<< HEAD
      final docRef = _driverCollection.doc(userID);

      await docRef.set({
        ...driverData,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'userID': userID,
        'driverID': docRef.id,
        'faceImage': null,
        'cnicFrontImage': null,
        'cnicBackImage': null,
        'verificationStatus': 'pending',
        'carVanImages': [],
        'isActive': false,
        'rating': 0.0,
      });
    } catch (e) {
      throw Exception('Error adding driver: ${e.toString()}');
    }
  }

  // Update driver details
  Future<void> updateDriverDetails(
      String driverId, Map<String, dynamic> updatedData) async {
    try {
      await _driverCollection.doc(driverId).update({
        ...updatedData,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error updating driver: ${e.toString()}');
    }
  }

  // Book a driver
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
    try {
      // Update user's current driver
      await _userCollection.doc(userId).update({'currentDriverId': driverId});

      // Create booking request
      await _bookingRequestCollection.add({
        "student_id": _auth.currentUser!.uid,
        "driver_id": driverId,
=======
<<<<<<< HEAD
      // Create document reference with desired ID (userID in this case)
      DocumentReference docRef = _driverCollection.doc(userID);

      // Prepare driver data
      driverData['createdAt'] = FieldValue.serverTimestamp();
      driverData['updatedAt'] = FieldValue.serverTimestamp();
      driverData['userID'] = userID;
      driverData['driverID'] = docRef.id; // Same as document ID
      driverData['faceImage'] = null;
      driverData['cnicFrontImage'] = null;
      driverData['cnicBackImage'] = null;
      driverData['verificationStatus'] = 'pending';
      driverData['carVanImages'] = [];

      // Set data to the document reference
      await docRef.set(driverData);
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      DocumentReference docRef = _driverCollection.doc();
      driverData['createdAt'] = FieldValue.serverTimestamp();
      driverData['updatedAt'] = FieldValue.serverTimestamp();
      driverData['userID'] = userID;
      driverData['driverID'] = docRef.id;
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
      driverData['createdAt'] = FieldValue.serverTimestamp();
      driverData['updatedAt'] = FieldValue.serverTimestamp();
      driverData['userID'] = userID;
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      await _driverCollection.add(driverData);
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    } catch (e) {
      throw Exception("Error adding driver: $e");
    }
  }

<<<<<<< HEAD
  //update new fields in driver
  Future<void> updateDriverDetails(
      String driverId, Map<String, dynamic> updatedData) async {
    try {
      updatedData['updatedAt'] = FieldValue.serverTimestamp();
      await _driverCollection.doc(driverId).update(updatedData);
    } catch (e) {
      throw Exception("Error updating driver: $e");
    }
  }

  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
<<<<<<< HEAD
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
<<<<<<< HEAD
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
<<<<<<< HEAD
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
<<<<<<< HEAD
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
<<<<<<< HEAD
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
<<<<<<< HEAD
  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
=======
  Future<void> bookDriver(String userId, String driverId) async {
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    try {
      await _userCollection.doc(userId).update({
        'currentDriverId': driverId,
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

      final bookingRequest = {
        "student_id": FirebaseAuth.instance.currentUser!.uid,
        "driver_id": driverId,
<<<<<<< HEAD
        // "doc_id": _bookingRequestCollection.doc().id,
=======
<<<<<<< HEAD
        // "doc_id": _bookingRequestCollection.doc().id,
=======
<<<<<<< HEAD
        // "doc_id": _bookingRequestCollection.doc().id,
=======
<<<<<<< HEAD
        // "doc_id": _bookingRequestCollection.doc().id,
=======
<<<<<<< HEAD
        // "doc_id": _bookingRequestCollection.doc().id,
=======
<<<<<<< HEAD
<<<<<<< HEAD
        // "doc_id": _bookingRequestCollection.doc().id,
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
        // "doc_id": _bookingRequestCollection.doc().id,
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        "status": "pending",
        "duration": duration,
        "pickup_location": pickup,
        "dropoff_location": dropoff,
        "fare_proposed_by_driver": 0.0,
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
        "fare_agreed": 0.0,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to book driver: ${e.toString()}');
    }
  }

  // Driver responds to booking
  Future<void> respondToBookingByDriver(
      String bookingId, double proposedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_proposed_by_driver": proposedFare,
        "status": "pending",
        "last_updated_by": "driver",
      });
    } catch (e) {
      throw Exception('Error responding to booking: ${e.toString()}');
    }
  }

  // Student proposes counter fare
  Future<void> proposeCounterFare(String bookingId, double fare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        'fare_counter_by_student': fare,
        'status': 'pending',
        'last_updated_by': 'student',
      });
    } catch (e) {
      throw Exception('Error proposing counter fare: ${e.toString()}');
    }
  }

  // Accept fare (student acceptance)
  Future<void> acceptFare(String bookingId, double agreedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_agreed": agreedFare,
        "status": "student_accepted",
      });
    } catch (e) {
      throw Exception('Error accepting fare: ${e.toString()}');
    }
  }

  //payment done
  Future<void> updateBookingStatus(
      String bookingId, String status, double amount) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        'status': status,
        'payment_amount': amount,
        'payment_timestamp': FieldValue.serverTimestamp(),
      });

      if (status == 'payment_success') {
        // Notify the driver about the payment
      }
    } catch (e) {
      throw Exception('Error updating booking status: ${e.toString()}');
    }
  }

  // Driver confirms booking
  // Future<void> confirmBookingByDriver(String bookingId) async {
  //   try {
  //     await _bookingRequestCollection.doc(bookingId).update({
  //       "status": "confirmed",
  //     });
  //   } catch (e) {
  //     throw Exception('Error confirming booking: ${e.toString()}');
  //   }
  // }

  // Driver confirms booking
  Future<void> confirmBookingByDriver(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "payment_pending",
      });
    } catch (e) {
      throw Exception('Error confirming booking: ${e.toString()}');
    }
  }

  // Reject offer
  Future<void> rejectOffer(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "cancelled",
      });
    } catch (e) {
      throw Exception('Error rejecting offer: ${e.toString()}');
    }
  }

  // Cancel booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      final userId = _auth.currentUser!.uid;

      await _bookingRequestCollection.doc(bookingId).update({
        "status": "cancelled",
      });

      await _userCollection.doc(userId).update({
        'currentDriverId': null,
      });
    } catch (e) {
      throw Exception('Error cancelling booking: ${e.toString()}');
    }
  }

  // Fetch driver by user ID
  Future<Map<String, dynamic>> fetchDriverByUserId(String userId) async {
    try {
      final query = await _driverCollection
          .where('userID', isEqualTo: userId)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        throw Exception('Driver not found for user: $userId');
      }

      return {
        'id': query.docs.first.id,
        ...query.docs.first.data() as Map<String, dynamic>
      };
    } catch (e) {
      throw Exception('Error fetching driver: ${e.toString()}');
    }
  }

  // Fetch active bookings for driver
  Future<List<Map<String, dynamic>>> fetchDriverBookings(
      String driverId) async {
    try {
      final query = await _bookingRequestCollection
          .where("driver_id", isEqualTo: driverId)
          .where("status", whereIn: ["pending", "student_accepted"])
          .orderBy("timestamp", descending: true)
          .get();

      return query.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception('Error fetching driver bookings: ${e.toString()}');
    }
  }

  // Allocate driver to student
  Future<void> allocateDriverToStudent(
    String driverId,
    String studentId,
    Map<String, dynamic> pickupCoords,
    Map<String, dynamic> dropoffCoords,
  ) async {
=======
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
=======
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
=======
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
=======
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
=======
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
=======
<<<<<<< HEAD
<<<<<<< HEAD
        "fare_counter_by_student": 0.0,
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
        "fare_counter_by_student": 0.0,
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        "fare_agreed": 0.0,
        "timestamp": FieldValue.serverTimestamp(),
      };

<<<<<<< HEAD
      await _bookingRequestCollection.add(bookingRequest);
=======
<<<<<<< HEAD
      await _bookingRequestCollection.add(bookingRequest);
=======
<<<<<<< HEAD
      await _bookingRequestCollection.add(bookingRequest);
=======
<<<<<<< HEAD
      await _bookingRequestCollection.add(bookingRequest);
=======
<<<<<<< HEAD
      await _bookingRequestCollection.add(bookingRequest);
=======
<<<<<<< HEAD
<<<<<<< HEAD
      await _bookingRequestCollection.add(bookingRequest);
=======
      await _bookingRequestCollection
          .add(bookingRequest);
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
      await _bookingRequestCollection.add(bookingRequest);
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    } catch (e) {
      throw Exception('Failed to book driver: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> respondToBookingByDriver(
      String bookingId, double proposedFare) async {
    await _bookingRequestCollection.doc(bookingId).update({
      "fare_proposed_by_driver": proposedFare,
      "status": "pending",
    });
  }

  Future<void> proposeCounterFare(String bookingId, double fare) async {
    await _bookingRequestCollection.doc(bookingId).update({
      'fare_counter_by_student': fare,
      'status': 'pending',
    });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
  Future<void> respondToBooking(String bookingId, double proposedFare) async {
    await _bookingRequestCollection
        .doc(bookingId)
        .update({
      "fare_proposed_by_driver": proposedFare,
      "status": "pending",
    });

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  }

  Future<void> negotiateFare(String bookingId, double newProposedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_proposed_by_driver": newProposedFare,
        "status": "pending",
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
<<<<<<< HEAD
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
        "last_updated_by": "driver",
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      });

      // Optionally notify the student about the new proposed fare
    } catch (e) {
      throw Exception('Error negotiating fare: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  // Future<void> finalizeAgreement(String bookingId, double agreedFare) async {
  //   try {
  //     await _bookingRequestCollection.doc(bookingId).update({
  //       "fare_agreed": agreedFare,
  //       "status": "confirmed",
  //     });
  //   } catch (e) {
  //     throw Exception('Error finalizing fare agreement: $e');
  //   }
  // }

>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> allocateDriverToStudent(
      String driverId,
      String studentId,
      Map<String, dynamic> coordinates,
      Map<String, dynamic> dropoffCoordinates) async {
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    try {
      await _ridesCollection
          .doc(driverId)
          .collection('students')
          .doc(studentId)
          .set({
<<<<<<< HEAD
        'pickUpCoordinates': pickupCoords,
        'dropOffCoordinates': dropoffCoords,
        'status': 'active',
        'allocatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Driver allocation failed: ${e.toString()}');
    }
  }

  // Add negotiation history
  Future<void> addNegotiationStep(
    String bookingId,
    double proposedFare,
    String proposedBy,
  ) async {
    try {
      await _bookingRequestCollection
          .doc(bookingId)
          .collection('negotiation_history')
          .add({
=======
        'pickUpCoordinates': coordinates,
        'dropOffCoordinates': dropoffCoordinates,
        'status': 'active',
        'allocatedAt': DateTime.now().toIso8601String(),
      });
      print('Driver allocated successfully to student.');
    } catch (e) {
      throw Exception('Failed to allocate driver to student: $e');
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
  Future<void> finalizeAgreement(String bookingId, double agreedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_agreed": agreedFare,
        "status": "confirmed",
      });
    } catch (e) {
      throw Exception('Error finalizing fare agreement: $e');
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    }
  }

  // Accept fare and confirm booking
<<<<<<< HEAD
  // Future<void> acceptFare(String bookingId, double agreedFare) async {
  //   try {
  //     await _bookingRequestCollection.doc(bookingId).update({
  //       "fare_agreed": agreedFare,
  //       "status": "confirmed",
  //     });
  //   } catch (e) {
  //     throw Exception('Error accepting fare: $e');
  //   }
  // }

=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
 // Accept fare and confirm booking
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> acceptFare(String bookingId, double agreedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_agreed": agreedFare,
<<<<<<< HEAD
        "status": "student_accepted", // Updated status
=======
        "status": "confirmed",
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      });
    } catch (e) {
      throw Exception('Error accepting fare: $e');
    }
  }

<<<<<<< HEAD
// Add method for driver's confirmation
  Future<void> confirmBookingByDriver(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "confirmed",
      });
    } catch (e) {
      throw Exception('Error confirming booking: $e');
    }
  }

=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> rejectOffer(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "cancelled",
      });
    } catch (e) {
      throw Exception('Error rejecting offer: $e');
    }
  }

  Future<void> addNegotiationStep(
      String bookingId, double proposedFare, String proposedBy) async {
    try {
      DocumentReference negotiationDoc = _bookingRequestCollection
          .doc(bookingId)
          .collection('negotiation_history')
          .doc();
      await negotiationDoc.set({
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        "proposed_fare": proposedFare,
        "proposed_by": proposedBy,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
<<<<<<< HEAD
      throw Exception('Error saving negotiation: ${e.toString()}');
    }
  }

  // Fetch user's current booking
  Future<Map<String, dynamic>> fetchUserBooking(String userId) async {
    try {
      final userDoc = await _userCollection.doc(userId).get();
      final driverId = userDoc.get('currentDriverId');

      if (driverId == null) {
        throw Exception('No active booking found');
      }

      final query = await _bookingRequestCollection
          .where("student_id", isEqualTo: userId)
          .where("driver_id", isEqualTo: driverId)
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        throw Exception('No booking found for user: $userId');
      }

      return {
        'id': query.docs.first.id,
        ...query.docs.first.data() as Map<String, dynamic>
      };
    } catch (e) {
      throw Exception('Error fetching booking: ${e.toString()}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
    try {
      final querySnapshot = await _driverCollection.get();
=======
      throw Exception('Error adding negotiation step: $e');
<<<<<<< HEAD
    }
  }

=======
<<<<<<< HEAD
    }
  }

=======
<<<<<<< HEAD
    }
  }

=======
<<<<<<< HEAD
    }
  }

=======
<<<<<<< HEAD
    }
  }

=======
<<<<<<< HEAD
=======
  Future<void> rejectBooking(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "rejected",
      });
    } catch (e) {
      throw Exception('Error rejecting booking: $e');
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
    }
  }

=======
    }
  }

=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  // Fetch all drivers
  Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
    try {
      final querySnapshot = await _driverCollection.get();
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
      print("querySnapshot: $querySnapshot.docs.length");
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception("Error fetching drivers: $e");
    }
  }
<<<<<<< HEAD
=======

<<<<<<< HEAD
  // Cancel a booking
=======
<<<<<<< HEAD
  // Cancel a booking
=======
<<<<<<< HEAD
  // Cancel a booking
=======
<<<<<<< HEAD
  // Cancel a booking
=======
<<<<<<< HEAD
  // Cancel a booking
=======
<<<<<<< HEAD
  // Cancel a booking
<<<<<<< HEAD
=======
   // Cancel a booking
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "cancelled",
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      // update the user
      await _userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'currentDriverId': null,
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    } catch (e) {
      throw Exception('Error cancelling booking: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<Map<String, dynamic>> fetchUserBooking(String userId) async {
    try {
      final userDoc = await _userCollection.doc(userId).get();
      final querySnapshot = await _bookingRequestCollection
          .where("student_id", isEqualTo: userId)
          .where("driver_id", isEqualTo: userDoc.get('currentDriverId'))
          .orderBy("timestamp", descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
      } else {
        throw Exception("No booking found for the user.");
      }
    } catch (e) {
      throw Exception("Error fetching booking: $e");
    }
  }

  // Fetch bookings for a specific driver
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

  Future<List<Map<String, dynamic>>> fetchUserBookings(String userId) async {
    try {
      final querySnapshot = await _bookingRequestCollection
          .where("student_id", isEqualTo: userId)
          .orderBy("timestamp", descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception("Error fetching bookings: $e");
    }
  }

   // Fetch bookings for a specific driver
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<List<Map<String, dynamic>>> fetchDriverBookings(
      String driverId) async {
    try {
      final querySnapshot = await _bookingRequestCollection
          .where("driver_id", isEqualTo: driverId)
          .orderBy("timestamp", descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception("Error fetching bookings: $e");
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  //fetch driver by userId
  Future<Map<String, dynamic>> fetchDriverByUserId(String userId) async {
    try {
      final querySnapshot = await _driverCollection
          .where('userID', isEqualTo: userId)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return {'id': doc.id, ...doc.data() as Map<String, dynamic>};
      } else {
        throw Exception("Driver not found.");
      }
    } catch (e) {
      throw Exception("Error fetching driver: $e");
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======



>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  // Update driver details
  Future<void> updateDriver(
      String driverId, Map<String, dynamic> updatedData) async {
    try {
      updatedData['updatedAt'] = FieldValue.serverTimestamp();
      await _driverCollection.doc(driverId).update(updatedData);
    } catch (e) {
      throw Exception("Error updating driver: $e");
    }
  }

  // Delete a driver
  Future<void> deleteDriver(String driverId) async {
    try {
      await _driverCollection.doc(driverId).delete();
    } catch (e) {
      throw Exception("Error deleting driver: $e");
    }
  }
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
}
