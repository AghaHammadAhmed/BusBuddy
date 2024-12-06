import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class DriverService {
  final CollectionReference _driverCollection =
      FirebaseFirestore.instance.collection('drivers');
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final auth = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  final CollectionReference<Map<String, dynamic>> _driverCollection1 =
      FirebaseFirestore.instance
          .collection('drivers')
          .withConverter<Map<String, dynamic>>(
            fromFirestore: (snapshot, _) => snapshot.data()!,
            toFirestore: (data, _) => data,
          );

  // Add a new driver
  Future<void> addDriver(String userID, Map<String, dynamic> driverData) async {
    try {
      driverData['createdAt'] = FieldValue.serverTimestamp();
      driverData['updatedAt'] = FieldValue.serverTimestamp();
      driverData['userID'] = userID;
      await _driverCollection.add(driverData);
    } catch (e) {
      throw Exception("Error adding driver: $e");
    }
  }

  Future<void> bookDriver(String userId, String driverId) async {
    try {
      await _userCollection.doc(userId).update({
        'currentDriverId': driverId,
      });
    } catch (e) {
      throw Exception('Failed to book driver: $e');
    }
  }

  // Fetch all drivers
  Future<List<Map<String, dynamic>>> fetchAllDrivers() async {
    try {
      final querySnapshot = await _driverCollection.get();
      print("querySnapshot: $querySnapshot.docs.length");
      return querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();
    } catch (e) {
      throw Exception("Error fetching drivers: $e");
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
