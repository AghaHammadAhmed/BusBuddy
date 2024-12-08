// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:firebase_database/firebase_database.dart';

// import '../../../services/LocationService.dart';

// class DriverLiveLocation extends StatefulWidget {
//   final String driverId;
//   const DriverLiveLocation({Key? key, required this.driverId})
//       : super(key: key);
//   @override
//   _DriverLiveLocationState createState() => _DriverLiveLocationState();
// }

// class _DriverLiveLocationState extends State<DriverLiveLocation> {
//   late GoogleMapController _mapController;
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   final LocationService _locationService = LocationService();
//   LatLng _currentLocation = const LatLng(0.0, 0.0); // Initial LatLng
//   bool _isLocationLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _startLocationTracking();
//   }

//   Future<void> _startLocationTracking() async {
//     // Check permission
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       setState(() {
//         _isLocationLoading = false;
//       });
//       return;
//     }

//     // Get initial position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     _updateLocation(position);

//     // Listen for location updates
//     Geolocator.getPositionStream(
//         locationSettings: const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 1, // Update location every 10 meters
//     )).listen((Position position) {
//       _updateLocation(position);
//     });
//   }

//   void _updateLocation(Position position) {
//     setState(() {
//       _currentLocation = LatLng(position.latitude, position.longitude);
//       _isLocationLoading = false;
//     });
//     try {
//       print("Updating driver location: ${widget.driverId}");
//       _locationService.updateDriverLocation(widget.driverId, position);
//     } catch (e) {
//       print("Error updating driver location: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Driver Live Location"),
//       ),
//       body: _isLocationLoading
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               compassEnabled: false,
//               initialCameraPosition: CameraPosition(
//                 target: _currentLocation,
//                 zoom: 15,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _mapController = controller;
//               },
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("driver"),
//                   position: _currentLocation,
//                   infoWindow: const InfoWindow(title: "Driver Location"),
//                 ),
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../services/LocationService.dart';

class DriverLiveLocation extends StatefulWidget {
  final String driverId;
  const DriverLiveLocation({Key? key, required this.driverId})
      : super(key: key);

  @override
  _DriverLiveLocationState createState() => _DriverLiveLocationState();
}

class _DriverLiveLocationState extends State<DriverLiveLocation> {
  late GoogleMapController _mapController;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final LocationService _locationService = LocationService();

  LatLng _driverLocation = const LatLng(0.0, 0.0); // Initial driver location
  Map<String, LatLng> _studentLocations =
      {}; // Map of student IDs to their coordinates
  bool _isLocationLoading = true;

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
    _fetchStudentLocations();
  }

  Future<void> _startLocationTracking() async {
    // Request location permissions
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        _isLocationLoading = false;
      });
      return;
    }

    // Get the initial driver position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _updateDriverLocation(position);

    // Listen for location updates
    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    )).listen((Position position) {
      _updateDriverLocation(position);
    });
  }

  void _updateDriverLocation(Position position) {
    setState(() {
      _driverLocation = LatLng(position.latitude, position.longitude);
      _isLocationLoading = false;
    });

    // Update driver's location in the database
    try {
      _locationService.updateDriverLocation(widget.driverId, position);
    } catch (e) {
      print("Error updating driver location: $e");
    }
  }

  void _fetchStudentLocations() {
    // Listen for changes in the rides/<driverId> node
    _database.child('rides/${widget.driverId}').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final Map ridesData = event.snapshot.value as Map;
        
        final Map<String, LatLng> students = {};
        ridesData.forEach((studentId, studentData) {
          final coordinates = studentData['coordinates'];
          students[studentId] = LatLng(
            coordinates['latitude'],
            coordinates['longitude'],
          );
        });

        setState(() {
          _studentLocations = students; // Update student locations
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Live Location"),
      ),
      body: _isLocationLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              compassEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _driverLocation,
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: {
                // Add driver's marker
                Marker(
                  markerId: const MarkerId("driver"),
                  position: _driverLocation,
                  infoWindow: const InfoWindow(title: "Driver Location"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue,
                  ),
                ),
                // Add student markers
                ..._studentLocations.entries.map((entry) {
                  return Marker(
                    markerId: MarkerId(entry.key),
                    position: entry.value,
                    infoWindow: InfoWindow(title: "Student ${entry.key}"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen,
                    ),
                  );
                }),
              },
            ),
    );
  }
}
