import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverService {
  final CollectionReference _driverCollection =
      FirebaseFirestore.instance.collection('drivers');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _bookingRequestCollection =
      FirebaseFirestore.instance.collection('booking_requests');

  //fetch user details
  Future<Map<String, dynamic>> fetchUserDetails(String userId) async {
    try {
      final userDoc = await _userCollection.doc(userId).get();
      return userDoc.data() as Map<String, dynamic>;
    } catch (e) {
      throw Exception("Error fetching user details: $e");
    }
  }

  // Add a new driver
  Future<void> addDriver(String userID, Map<String, dynamic> driverData) async {
    try {
      DocumentReference docRef = _driverCollection.doc();
      driverData['createdAt'] = FieldValue.serverTimestamp();
      driverData['updatedAt'] = FieldValue.serverTimestamp();
      driverData['userID'] = userID;
      driverData['driverID'] = docRef.id;
      await _driverCollection.add(driverData);
    } catch (e) {
      throw Exception("Error adding driver: $e");
    }
  }

  Future<void> bookDriver(String userId, String driverId, String duration,
      String pickup, String dropoff) async {
    try {
      await _userCollection.doc(userId).update({
        'currentDriverId': driverId,
      });

      final bookingRequest = {
        "student_id": FirebaseAuth.instance.currentUser!.uid,
        "driver_id": driverId,
        // "doc_id": _bookingRequestCollection.doc().id,
        "status": "pending",
        "duration": duration,
        "pickup_location": pickup,
        "dropoff_location": dropoff,
        "fare_proposed_by_driver": 0.0,
        "fare_counter_by_student": 0.0,
        "fare_agreed": 0.0,
        "timestamp": FieldValue.serverTimestamp(),
      };

      await _bookingRequestCollection.add(bookingRequest);
    } catch (e) {
      throw Exception('Failed to book driver: $e');
    }
  }

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
  }

  Future<void> negotiateFare(String bookingId, double newProposedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_proposed_by_driver": newProposedFare,
        "status": "pending",
        "last_updated_by": "driver",
      });

      // Optionally notify the student about the new proposed fare
    } catch (e) {
      throw Exception('Error negotiating fare: $e');
    }
  }

  Future<void> finalizeAgreement(String bookingId, double agreedFare) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "fare_agreed": agreedFare,
        "status": "confirmed",
      });
    } catch (e) {
      throw Exception('Error finalizing fare agreement: $e');
    }
  }

  // Accept fare and confirm booking
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
    }
  }

  // Fetch all drivers
  Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
    try {
      final querySnapshot = await _driverCollection.get();
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception("Error fetching drivers: $e");
    }
  }

  // Cancel a booking
  Future<void> cancelBooking(String bookingId) async {
    try {
      await _bookingRequestCollection.doc(bookingId).update({
        "status": "cancelled",
      });
      // update the user
      await _userCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'currentDriverId': null,
      });
    } catch (e) {
      throw Exception('Error cancelling booking: $e');
    }
  }

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
