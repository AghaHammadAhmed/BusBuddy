import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  /// Update the driver's location in Realtime Database
  Future<void> updateDriverLocation(String driverId, Position position) async {
    try {
      await _database.ref('driverLocations/$driverId').set({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'timestamp': ServerValue.timestamp, // Realtime Database timestamp
      });
    } catch (e) {
      throw Exception("Error updating driver location: $e");
    }
  }

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
  }
}
