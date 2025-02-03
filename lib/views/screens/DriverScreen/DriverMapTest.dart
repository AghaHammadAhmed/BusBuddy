import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
class DriverLiveLocationTest extends StatefulWidget {
  final String driverId;
  const DriverLiveLocationTest({Key? key, required this.driverId})
      : super(key: key);

  @override
  _DriverLiveLocationTestState createState() => _DriverLiveLocationTestState();
}

class _DriverLiveLocationTestState extends State<DriverLiveLocationTest> {
<<<<<<< HEAD
=======
=======
class DriverLiveLocation extends StatefulWidget {
  final String driverId;
  const DriverLiveLocation({Key? key, required this.driverId})
      : super(key: key);

  @override
  _DriverLiveLocationState createState() => _DriverLiveLocationState();
}

class _DriverLiveLocationState extends State<DriverLiveLocation> {
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  late GoogleMapController _mapController;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<LatLng> polylineCoordinates = [];
  LatLng _driverLocation = const LatLng(0.0, 0.0);
  Map<String, StudentInfo> _studentLocations = {};
  bool _isLocationLoading = true;
  final double driverRadius = 10000.0; // Set to 10 meters for pickup radius
  MapType _currentMapType = MapType.normal;
  bool _showTraffic = false;
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
    _fetchStudentLocations();
  }

  Future<void> _startLocationTracking() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorSnackBar('Location permission denied');
        setState(() => _isLocationLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _updateDriverLocation(position);

      Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen(
        _updateDriverLocation,
        onError: (error) =>
            _showErrorSnackBar('Location tracking error: $error'),
      );
    } catch (e) {
      _showErrorSnackBar('Failed to start location tracking: $e');
      setState(() => _isLocationLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _updateDriverLocation(Position position) {
    setState(() {
      _driverLocation = LatLng(position.latitude, position.longitude);
      _isLocationLoading = false;
    });

    try {
      _updateDriverLocationInFirestore();
      if (_studentLocations.isNotEmpty) {
        _fetchRoute(_studentLocations.entries.first.value.location);
      }
    } catch (e) {
      _showErrorSnackBar('Error updating location: $e');
    }
  }

  Future<void> _updateDriverLocationInFirestore() async {
    try {
      await _firestore.collection('drivers').doc(widget.driverId).update({
        'recentlatitude': _driverLocation.latitude,
        'recentlongitude': _driverLocation.longitude,
      });
    } catch (e) {
      _showErrorSnackBar('Error updating driver location: $e');
    }
  }

  void _fetchStudentLocations() {
    _database.child('rides/${widget.driverId}').onValue.listen(
      (event) {
        if (event.snapshot.value != null) {
          final Map ridesData = event.snapshot.value as Map;
          final Map<String, StudentInfo> students = {};

          ridesData.forEach((studentId, studentData) {
            final coordinates = studentData['coordinates'];
            students[studentId] = StudentInfo(
              location: LatLng(
                coordinates['latitude'],
                coordinates['longitude'],
              ),
              name: studentData['name'] ?? 'Student $studentId',
              status: studentData['status'] ?? 'Waiting',
            );
          });
          if (mounted) {
            setState(() => _studentLocations = students);
          }
        }
      },
      onError: (error) =>
          _showErrorSnackBar('Error fetching student locations: $error'),
    );
  }

  LatLng? _destinationLocation; // Add this to track the destination

  Future<void> _fetchRoute(LatLng destination) async {
    const String apiKey = 'AIzaSyAZK08jqjlFmCVI2eIVK1TJ-kHYKEwROy4';
<<<<<<< HEAD
    
=======
<<<<<<< HEAD
    
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    final Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_driverLocation.latitude},${_driverLocation.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey');

    try {
      final response = await http.get(uri);
      final data = json.decode(response.body);
      log('Route data: $data');

      if (data['status'] == 'OK') {
        List<LatLng> points = PolylinePoints()
            .decodePolyline(data['routes'][0]['overview_polyline']['points'])
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();

        String distance = data['routes'][0]['legs'][0]['distance']['text'];
        String duration = data['routes'][0]['legs'][0]['duration']['text'];

        setState(() {
          _routePoints = points;
          if (_studentLocations.isNotEmpty) {
            _studentLocations[_studentLocations.keys.first] =
                _studentLocations[_studentLocations.keys.first]!.copyWith(
              distance: distance,
              time: duration,
            );
          } else {
            // Set destination location for marker
            _destinationLocation = destination;
          }
        });
      } else {
        _showErrorSnackBar('Failed to fetch route: ${data['status']}');
      }
    } catch (e) {
      _showErrorSnackBar('Error fetching route: $e');
    }
  }

  Widget _buildStudentMarkers() {
    return Column(
      children: _studentLocations.entries.map((entry) {
        final student = entry.value;
        final isNear = _isWithinRadius(student.location, driverRadius);
        return ListTile(
          title: Text(student.name),
          subtitle: Text(
              'Distance: ${student.distance ?? '--'}, Time: ${student.time ?? '--'}'),
          trailing: isNear
              ? ElevatedButton(
                  onPressed: () {
                    _markStudentAsPickedUp(entry.key);
                  },
                  child: const Text('Pickup'),
                )
              : null,
        );
      }).toList(),
    );
  }

  bool _isWithinRadius(LatLng studentLocation, double radius) {
    final distance = Geolocator.distanceBetween(
      _driverLocation.latitude,
      _driverLocation.longitude,
      studentLocation.latitude,
      studentLocation.longitude,
    );
    return distance <= radius;
  }

  void _markStudentAsPickedUp(String studentId) async {
    try {
      // Remove the student from the current list
      final pickedUpStudent = _studentLocations.remove(studentId);

      // Update the student's status in Firebase
      await _database.child('rides/${widget.driverId}/$studentId').update({
        'status': 'Picked Up',
      });

      // Log the ride completion in Firestore or Firebase Realtime Database
      await _firestore.collection('completedRides').add({
        'driverId': widget.driverId,
        'studentId': studentId,
        'studentName': pickedUpStudent?.name,
        'timestamp': DateTime.now().toIso8601String(),
      });

      setState(() {
        _studentLocations = _studentLocations;
      });

      if (_studentLocations.isNotEmpty) {
        _fetchRoute(_studentLocations.entries.first.value.location);
      } else {
        // All students picked up; navigate to the final destination
        _showErrorSnackBar(
            'All students picked up! Navigating to destination.');
        final driverData =
            await _firestore.collection('drivers').doc(widget.driverId).get();
        final destination = LatLng(
          driverData.data()?['latitude'] ?? 0.0,
          driverData.data()?['longitude'] ?? 0.0,
        );
        log('Destination: $destination');
        _fetchRoute(destination);
      }
    } catch (e) {
      _showErrorSnackBar('Error marking student as picked up: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLocationLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Getting location...'),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                    child: GoogleMap(
                  mapType: _currentMapType,
                  trafficEnabled: _showTraffic,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: _driverLocation,
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route'),
                      points: _routePoints,
                      color: Colors.blue,
                      width: 5,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId("driver"),
                      position: _driverLocation,
                      infoWindow: const InfoWindow(title: "My Location"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    ),
                    ..._studentLocations.entries.map((entry) {
                      return Marker(
                        markerId: MarkerId(entry.key),
                        position: entry.value.location,
                        infoWindow: InfoWindow(
                          title: entry.value.name,
                          snippet: 'Status: ${entry.value.status}',
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueOrange,
                        ),
                      );
                    }),
                    if (_destinationLocation != null)
                      Marker(
                        markerId: const MarkerId("destination"),
                        position: _destinationLocation!,
                        infoWindow:
                            const InfoWindow(title: "Final Destination"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen,
                        ),
                      ),
                  },
                )),
                _buildStudentMarkers(),
              ],
            ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }
}

class StudentInfo {
  final LatLng location;
  final String name;
  final String status;
  final String? distance;
  final String? time;

  StudentInfo({
    required this.location,
    required this.name,
    required this.status,
    this.distance,
    this.time,
  });

  StudentInfo copyWith({
    LatLng? location,
    String? name,
    String? status,
    String? distance,
    String? time,
  }) {
    return StudentInfo(
      location: location ?? this.location,
      name: name ?? this.name,
      status: status ?? this.status,
      distance: distance ?? this.distance,
      time: time ?? this.time,
    );
  }
}
