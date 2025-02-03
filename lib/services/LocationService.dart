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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
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
<<<<<<< HEAD
import 'dart:developer';

=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
=======
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

class LocationService {
  final DatabaseReference _ridesRef =
      FirebaseDatabase.instance.ref().child('rides');
  final DatabaseReference _driverRef =
      FirebaseDatabase.instance.ref().child('driverLocations');
  final DatabaseReference _studentRef =
      FirebaseDatabase.instance.ref().child('studentLocations');
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
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  Future<void> allocateDriverToStudent(
      String driverId,
      String studentId,
      Map<String, dynamic> coordinates,
      Map<String, dynamic> dropoffCoordinates) async {
    try {
      await _ridesRef.child(driverId).child(studentId).set({
        'coordinates': coordinates,
        'dropOffLocation': dropoffCoordinates,
        'status': 'active',
        'allocatedAt': DateTime.now().toIso8601String(),
      });
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
<<<<<<< HEAD
      log('Driver allocated successfully to student.');
    } catch (e) {
      
=======
  Future<void> allocateDriverToStudent(String driverId, String studentId,
      Map<String, dynamic> coordinates) async {
    try {
      await _ridesRef.child(driverId).child(studentId).set({
        'coordinates': coordinates,
        'status': 'active',
        'allocatedAt': DateTime.now().toIso8601String(),
      });
      print('Driver allocated successfully to student.');
    } catch (e) {
      print('Error allocating driver: $e');
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
      print('Driver allocated successfully to student.');
    } catch (e) {
      
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      throw Exception('Failed to allocate driver to student: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllocatedStudents(
      String driverId) async {
    try {
      final snapshot = await _ridesRef.child(driverId).get();
      if (snapshot.exists) {
        return (snapshot.value as Map).entries.map((e) {
          final studentData = e.value as Map<String, dynamic>;
          return {
            'studentId': e.key,
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
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
            'coordinates': studentData['coordinates'],
            'status': studentData['status'],
          };
        }).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch allocated students: $e');
    }
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  // //update each student coordinates from ridecollection
  // Future<void> updateStudentCoordinates(
  //     String driverId, String studentId, Map<String, dynamic> newCoordinates) async {
  //   try {
  //     await _ridesRef
  //         .child(driverId)
  //         .child(studentId)
  //         .child('coordinates')
  //         .set(newCoordinates);
  //   } catch (e) {
  //     throw Exception('Failed to update student coordinates: $e');
  //   }
  // }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  Stream<DatabaseEvent> getDriverLocationUpdates(String driverId) {
    return _driverRef.child(driverId).onValue;
  }

  Stream<DatabaseEvent> getStudentLocationUpdates(String studentId) {
    return _studentRef.child(studentId).onValue;
  }

  Future<void> updateStudentLocation(
      String studentId, Map<String, dynamic> coordinates) async {
    try {
      await _studentRef.child(studentId).set({
        'latitude': coordinates['latitude'],
        'longitude': coordinates['longitude'],
        'timestamp': ServerValue.timestamp, // Realtime Database timestamp
      });
    } catch (e) {
      throw Exception("Error updating student location: $e");
    }
  }

  Future<void> updateDriverLocation(String driverId, Position position) async {
    try {
      await _driverRef.child(driverId).set({
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
=======
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  /// Update the driver's location in Realtime Database
  Future<void> updateDriverLocation(String driverId, Position position) async {
    try {
      await _database.ref('driverLocations/$driverId').set({
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': ServerValue.timestamp, // Realtime Database timestamp
      });
    } catch (e) {
      throw Exception("Error updating driver location: $e");
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
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  Future<Map<String, dynamic>?> fetchStudentCoordinates(
      String studentId) async {
    try {
      final snapshot = await _studentRef.child(studentId).get();
      if (snapshot.exists) {
        return {
          'latitude': snapshot.child('latitude').value,
          'longitude': snapshot.child('longitude').value,
          'timestamp': snapshot.child('timestamp').value,
        };
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch student coordinates: $e');
    }
  }

  Future<Map<String, dynamic>> fetchAssignedDriver(String studentId) async {
    try {
      final query = await _ridesRef.orderByChild(studentId).once();
      for (var snapshot in query.snapshot.children) {
        if (snapshot.child(studentId).exists) {
          return {
            'driverId': snapshot.key,
            'studentDetails': snapshot.child(studentId).value,
          };
        }
      }
      return {};
    } catch (e) {
      throw Exception('Failed to fetch assigned driver: $e');
    }
  }

  Future<void> updateStudentCoordinates(String driverId, String studentId,
      Map<String, dynamic> newCoordinates) async {
    try {
      await _ridesRef
          .child(driverId)
          .child(studentId)
          .child('coordinates')
          .set(newCoordinates);
    } catch (e) {
      throw Exception('Failed to update student coordinates: $e');
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
=======
<<<<<<< HEAD
=======
=======
  /// Update the student's location in Realtime Database
  Future<void> updateStudentLocation(String studentId, LatLng latLng) async {
    try {
      await _database.ref('studentLocations/$studentId').set({
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
        'timestamp': ServerValue.timestamp, // Realtime Database timestamp
      });
    } catch (e) {
      throw Exception("Error updating student location: $e");
    }
  }

  /// Get real-time updates for a driver's location
  Stream<DatabaseEvent> getDriverLocationUpdates(String driverId) {
    return _database.ref('driverLocations/$driverId').onValue;
  }

  /// Get real-time updates for a student's location
  Stream<DatabaseEvent> getStudentLocationUpdates(String studentId) {
    return _database.ref('studentLocations/$studentId').onValue;
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  }
}
