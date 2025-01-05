import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
class DriverService {
  final CollectionReference _driverCollection =
      FirebaseFirestore.instance.collection('drivers');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
<<<<<<< HEAD
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');
  final CollectionReference _ridesCollection =
      FirebaseFirestore.instance.collection('rides');
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

  // Add a new driver
  Future<void> addDriver(String userID, Map<String, dynamic> driverData) async {
    try {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      DocumentReference docRef = _driverCollection.doc();
      driverData['createdAt'] = FieldValue.serverTimestamp();
      driverData['updatedAt'] = FieldValue.serverTimestamp();
      driverData['userID'] = userID;
      driverData['driverID'] = docRef.id;
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
      await _driverCollection.add(driverData);
    } catch (e) {
      throw Exception("Error adding driver: $e");
    }
  }

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
    try {
      await _userCollection.doc(userId).update({
        'currentDriverId': driverId,
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

      final bookingRequest = {
        "student_id": FirebaseAuth.instance.currentUser!.uid,
        "driver_id": driverId,
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
        "status": "pending",
        "duration": duration,
        "pickup_location": pickup,
        "dropoff_location": dropoff,
        "fare_proposed_by_driver": 0.0,
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
        "fare_agreed": 0.0,
        "timestamp": FieldValue.serverTimestamp(),
      };

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
    } catch (e) {
      throw Exception('Failed to book driver: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
        "last_updated_by": "driver",
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
        "last_updated_by": "driver",
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      });

      // Optionally notify the student about the new proposed fare
    } catch (e) {
      throw Exception('Error negotiating fare: $e');
    }
  }

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

  Future<void> allocateDriverToStudent(
      String driverId,
      String studentId,
      Map<String, dynamic> coordinates,
      Map<String, dynamic> dropoffCoordinates) async {
    try {
      await _ridesCollection
          .doc(driverId)
          .collection('students')
          .doc(studentId)
          .set({
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
    }
  }

  // Accept fare and confirm booking
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
 // Accept fare and confirm booking
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  Future<void> acceptFare(String bookingId, double agreedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_agreed": agreedFare,
        "status": "confirmed",
      });
    } catch (e) {
      throw Exception('Error accepting fare: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
        "proposed_fare": proposedFare,
        "proposed_by": proposedBy,
        "timestamp": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error adding negotiation step: $e');
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
  // Fetch all drivers
  Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
    try {
      final querySnapshot = await _driverCollection.get();
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
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception("Error fetching drivers: $e");
    }
  }

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
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "cancelled",
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      // update the user
      await _userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'currentDriverId': null,
      });
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    } catch (e) {
      throw Exception('Error cancelling booking: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
=======



>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
}
