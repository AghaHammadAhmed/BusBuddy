<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/user.dart';
import '../../services/AuthService.dart';

class TrackDriver extends StatefulWidget {
  const TrackDriver({super.key});

  @override
  State<TrackDriver> createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
  late GoogleMapController _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
  final DatabaseReference _ridesRef = FirebaseDatabase.instance.ref('rides');
  final UserService _userService = UserService();
  LatLng? driverPosition;
  LatLng? studentPosition;

  String? currentDriverId;
  String studentId = FirebaseAuth.instance.currentUser!.uid;
  String userId = FirebaseAuth.instance.currentUser!.uid;

  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _studentIcon;
  double? distanceInMeters;

  @override
  void initState() {
    super.initState();
    initializeState();
    _loadCustomMarkers();
  }

  void initializeState() async {
    // Fetch user and update state
    UserModel? user = await _userService.fetchUser(userId);
    if (user != null) {
      setState(() {
        studentId = user.userID;
        currentDriverId = user.currentDriverId;
      });
    }
    fetchCurrentDriverId();
    listenToDriverLocation();
    listenToStudentLocation();
  }

  void _loadCustomMarkers() async {
    final driverIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/driver_marker.png',
    );
    final studentIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(5, 5)),
      'assets/student_marker.png',
    );

    setState(() {
      _driverIcon = driverIcon;
      _studentIcon = studentIcon;
    });
  }

  void fetchCurrentDriverId() async {
    try {
      final rideSnapshot = await _ridesRef.once();
      final Map ridesData = rideSnapshot.snapshot.value as Map;

      // Find the current driver for the student
      ridesData.forEach((driverId, studentData) {
        if (studentData[studentId] != null) {
          setState(() {
            currentDriverId = driverId;
            final coordinates = studentData[studentId]['coordinates'];
            studentPosition = LatLng(
              coordinates['latitude'],
              coordinates['longitude'],
            );
          });
        }
      });
    } catch (e) {
      print('Error fetching ride data: $e');
    }
  }

  void listenToStudentLocation() {
    FirebaseDatabase.instance
        .ref('studentLocations')
        .child(studentId)
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        final updatedPosition = LatLng(data['latitude'], data['longitude']);
        if (studentPosition == null || studentPosition != updatedPosition) {
          setState(() {
            studentPosition = updatedPosition;
          });
          updateDistance(); // Update distance when student location changes
        }
      }
    });
  }

  void listenToDriverLocation() {
    if (currentDriverId == null) return;

    _driverLocationsRef.child(currentDriverId!).onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          driverPosition = LatLng(data['latitude'], data['longitude']);
        });
        updateDistance(); // Update distance when driver location changes
      }
    });
  }

  void updateDistance() {
    if (driverPosition != null && studentPosition != null) {
      final distance = Geolocator.distanceBetween(
        driverPosition!.latitude,
        driverPosition!.longitude,
        studentPosition!.latitude,
        studentPosition!.longitude,
      );

      setState(() {
        distanceInMeters = distance;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) => _mapController = controller,
            initialCameraPosition: CameraPosition(
              target: studentPosition ??
                  const LatLng(25.3855763128842, 68.32784470170736),
              zoom: 15,
            ),
            markers: {
              if (studentPosition != null)
                Marker(
                  markerId: const MarkerId('student'),
                  position: studentPosition!,
                  icon: _studentIcon ??
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                  infoWindow: const InfoWindow(title: 'You'),
                ),
              if (driverPosition != null)
                Marker(
                  zIndex: 1,
                  markerId: const MarkerId('driver'),
                  position: driverPosition!,
                  icon: _driverIcon ??
                      BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                  infoWindow: const InfoWindow(title: 'Driver'),
                ),
            },
          ),
          if (distanceInMeters != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Distance Between Driver and Student',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Distance: ${(distanceInMeters! / 1000).toStringAsFixed(2)} km',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
=======
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OngoingTrip extends StatefulWidget {
  const OngoingTrip({super.key});

  @override
  State<OngoingTrip> createState() => _OngoingTripState();
}

class _OngoingTripState extends State<OngoingTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Text")),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
    );
  }
}
