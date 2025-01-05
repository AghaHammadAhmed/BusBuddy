<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
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

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:firebase_database/firebase_database.dart';
<<<<<<< HEAD
=======

>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final LocationService _locationService = LocationService();

<<<<<<< HEAD
//   LatLng _driverLocation = const LatLng(0.0, 0.0);
//   Map<String, StudentInfo> _studentLocations = {};
//   bool _isLocationLoading = true;
//   // bool _isMapFullScreen = false;
//   final double driverRadius = 2000;
//   MapType _currentMapType = MapType.normal;
//   bool _showTraffic = false;

=======
//   LatLng _driverLocation = const LatLng(0.0, 0.0); // Initial driver location
//   Map<String, LatLng> _studentLocations =
//       {}; // Map of student IDs to their coordinates
//   bool _isLocationLoading = true;
//   final double driverRadius = 2000;
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
//   @override
//   void initState() {
//     super.initState();
//     _startLocationTracking();
//     _fetchStudentLocations();
//   }

//   Future<void> _startLocationTracking() async {
<<<<<<< HEAD
//     try {
//       LocationPermission permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         _showErrorSnackBar('Location permission denied');
//         setState(() => _isLocationLoading = false);
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       _updateDriverLocation(position);

//       Geolocator.getPositionStream(
//         locationSettings: const LocationSettings(
//           accuracy: LocationAccuracy.high,
//           distanceFilter: 1,
//         ),
//       ).listen(
//         _updateDriverLocation,
//         onError: (error) =>
//             _showErrorSnackBar('Location tracking error: $error'),
//       );
//     } catch (e) {
//       _showErrorSnackBar('Failed to start location tracking: $e');
//       setState(() => _isLocationLoading = false);
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
=======
//     // Request location permissions
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       setState(() {
//         _isLocationLoading = false;
//       });
//       return;
//     }

//     // Get the initial driver position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     _updateDriverLocation(position);

//     // Listen for location updates
//     Geolocator.getPositionStream(
//         locationSettings: const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 1,
//     )).listen((Position position) {
//       _updateDriverLocation(position);
//     });
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
//   }

//   void _updateDriverLocation(Position position) {
//     setState(() {
//       _driverLocation = LatLng(position.latitude, position.longitude);
//       _isLocationLoading = false;
//     });

<<<<<<< HEAD
//     try {
//       _locationService.updateDriverLocation(widget.driverId, position);
//       _updateDriverLocationInFirestore();
//     } catch (e) {
//       _showErrorSnackBar('Error updating location: $e');
//     }
//   }

//   Future<void> _updateDriverLocationInFirestore() async {
//     try {
//       await _firestore.collection('drivers').doc(widget.driverId).update({
//         'latitude': _driverLocation.latitude,
//         'longitude': _driverLocation.longitude,
//         'lastUpdated': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       _showErrorSnackBar('Error updating driver location: $e');
//     }
//   }

//   void _fetchStudentLocations() {
//     _database.child('rides/${widget.driverId}').onValue.listen(
//       (event) {
//         if (event.snapshot.value != null) {
//           final Map ridesData = event.snapshot.value as Map;
//           final Map<String, StudentInfo> students = {};

//           ridesData.forEach((studentId, studentData) {
//             final coordinates = studentData['coordinates'];
//             students[studentId] = StudentInfo(
//               location: LatLng(
//                 coordinates['latitude'],
//                 coordinates['longitude'],
//               ),
//               name: studentData['name'] ?? 'Student $studentId',
//               status: studentData['status'] ?? 'Waiting',
//             );
//           });

//           setState(() => _studentLocations = students);
//         }
//       },
//       onError: (error) =>
//           _showErrorSnackBar('Error fetching student locations: $error'),
//     );
=======
//     // Update driver's location in the database
//     try {
//       _locationService.updateDriverLocation(widget.driverId, position);
//       addlongLat(_driverLocation.latitude, _driverLocation.longitude);
//     } catch (e) {
//       print("Error updating driver location: $e");
//     }
//   }

//   //update the latidude and longitude of the driver
//   void addlongLat(double latitude, double longitude) async {
//     await _firestore.collection('drivers').doc(widget.driverId).update({
//       'latitude': latitude,
//       'longitude': longitude,
//     });
//   }

//   void _fetchStudentLocations() {
//     // Listen for changes in the rides/<driverId> node
//     _database.child('rides/${widget.driverId}').onValue.listen((event) {
//       if (event.snapshot.value != null) {
//         final Map ridesData = event.snapshot.value as Map;

//         final Map<String, LatLng> students = {};
//         ridesData.forEach((studentId, studentData) {
//           final coordinates = studentData['coordinates'];
//           students[studentId] = LatLng(
//             coordinates['latitude'],
//             coordinates['longitude'],
//           );
//         });

//         setState(() {
//           _studentLocations = students; // Update student locations
//         });
//       }
//     });
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
//   }

//   Set<Circle> _createCircles() {
//     return {
//       Circle(
<<<<<<< HEAD
//         circleId: const CircleId("driver_radius"),
//         center: _driverLocation,
//         radius: driverRadius,
//         fillColor: Colors.green.withOpacity(0.2),
//         strokeColor: Colors.green,
=======
//         circleId: CircleId("driver_radius"),
//         center: _driverLocation,
//         radius: driverRadius,
//         fillColor: Color.fromARGB(255, 81, 255, 0).withOpacity(0.2),
//         strokeColor: Color.fromARGB(255, 81, 255, 0),
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
//         strokeWidth: 2,
//       ),
//     };
//   }

<<<<<<< HEAD
//   void _centerOnDriver() {
//     _mapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: _driverLocation,
//           zoom: 15,
//         ),
//       ),
//     );
//   }

=======
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
<<<<<<< HEAD
//         title: const Text("Live Location Tracking"),
//         actions: [
//           IconButton(
//             icon: Icon(_showTraffic ? Icons.traffic : Icons.traffic_outlined),
//             onPressed: () => setState(() => _showTraffic = !_showTraffic),
//             tooltip: 'Toggle traffic view',
//           ),
//           PopupMenuButton<MapType>(
//             icon: const Icon(Icons.layers),
//             tooltip: 'Change map type',
//             onSelected: (MapType type) =>
//                 setState(() => _currentMapType = type),
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: MapType.normal,
//                 child: Text('Normal'),
//               ),
//               const PopupMenuItem(
//                 value: MapType.satellite,
//                 child: Text('Satellite'),
//               ),
//               const PopupMenuItem(
//                 value: MapType.hybrid,
//                 child: Text('Hybrid'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: _isLocationLoading
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children:const [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text('Getting location...'),
//                 ],
//               ),
//             )
//           : Stack(
//               children: [
//                 GoogleMap(
//                   circles: _createCircles(),
//                   compassEnabled: true,
//                   mapType: _currentMapType,
//                   trafficEnabled: _showTraffic,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   zoomControlsEnabled: false,
//                   initialCameraPosition: CameraPosition(
//                     target: _driverLocation,
//                     zoom: 15,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _mapController = controller;
//                   },
//                   markers: {
//                     Marker(
//                       markerId: const MarkerId("driver"),
//                       position: _driverLocation,
//                       infoWindow: const InfoWindow(title: "My Location"),
//                       icon: BitmapDescriptor.defaultMarkerWithHue(
//                         BitmapDescriptor.hueBlue,
//                       ),
//                     ),
//                     ..._studentLocations.entries.map((entry) {
//                       return Marker(
//                         markerId: MarkerId(entry.key),
//                         position: entry.value.location,
//                         infoWindow: InfoWindow(
//                           title: entry.value.name,
//                           snippet: 'Status: ${entry.value.status}',
//                         ),
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                           _getMarkerColor(entry.value.status),
//                         ),
//                       );
//                     }),
//                   },
//                 ),
//                 Positioned(
//                   right: 16,
//                   bottom: 16,
//                   child: Column(
//                     children: [
//                       FloatingActionButton(
//                         heroTag: 'centerLocation',
//                         onPressed: _centerOnDriver,
//                         tooltip: 'Center on my location',
//                         child: const Icon(Icons.my_location),
//                       ),
//                       const SizedBox(height: 8),
//                       FloatingActionButton(
//                         heroTag: 'toggleSheet',
//                         onPressed: () {
//                           showModalBottomSheet(
//                             context: context,
//                             builder: (context) => DraggableScrollableSheet(
//                               initialChildSize: 0.25,
//                               minChildSize: 0.1,
//                               maxChildSize: 0.4,
//                               builder: (context, scrollController) => Container(
//                                 decoration: BoxDecoration(
//                                   color: Theme.of(context).cardColor,
//                                   borderRadius: const BorderRadius.vertical(
//                                     top: Radius.circular(16),
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.1),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, -2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ListView(
//                                   controller: scrollController,
//                                   padding: const EdgeInsets.all(16),
//                                   children: [
//                                     const Center(
//                                       child: Text(
//                                         'Student Locations',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                     const Divider(),
//                                     ..._studentLocations.entries.map((entry) {
//                                       return ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundColor: _getStatusColor(
//                                               entry.value.status),
//                                           child: const Icon(
//                                             Icons.person,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         title: Text(entry.value.name),
//                                         subtitle: Text(
//                                             'Status: ${entry.value.status}'),
//                                         trailing: IconButton(
//                                           icon: const Icon(Icons.directions),
//                                           onPressed: () =>
//                                               _mapController.animateCamera(
//                                             CameraUpdate.newLatLng(
//                                               entry.value.location,
//                                             ),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                         tooltip: 'Show student locations',
//                         child: const Icon(Icons.list),
//                       ),
//                     ],
//                   ),
//                 ),
//                 DraggableScrollableSheet(
//                   initialChildSize: 0.25,
//                   minChildSize: 0.1,
//                   maxChildSize: 0.4,
//                   builder: (context, scrollController) => Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).cardColor,
//                       borderRadius:
//                           const BorderRadius.vertical(top: Radius.circular(16)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 10,
//                           offset: const Offset(0, -2),
//                         ),
//                       ],
//                     ),
//                     child: ListView(
//                       controller: scrollController,
//                       padding: const EdgeInsets.all(16),
//                       children: [
//                         const Center(
//                           child: Text(
//                             'Student Locations',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const Divider(),
//                         ..._studentLocations.entries.map((entry) => ListTile(
//                               leading: CircleAvatar(
//                                 backgroundColor:
//                                     _getStatusColor(entry.value.status),
//                                 child: const Icon(Icons.person,
//                                     color: Colors.white),
//                               ),
//                               title: Text(entry.value.name),
//                               subtitle: Text('Status: ${entry.value.status}'),
//                               trailing: IconButton(
//                                 icon: const Icon(Icons.directions),
//                                 onPressed: () => _mapController.animateCamera(
//                                   CameraUpdate.newLatLng(entry.value.location),
//                                 ),
//                               ),
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }

//   double _getMarkerColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'picked_up':
//         return BitmapDescriptor.hueGreen;
//       case 'waiting':
//         return BitmapDescriptor.hueOrange;
//       default:
//         return BitmapDescriptor.hueRed;
//     }
//   }

//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'picked_up':
//         return Colors.green;
//       case 'waiting':
//         return Colors.orange;
//       default:
//         return Colors.red;
//     }
//   }
// }

// class StudentInfo {
//   final LatLng location;
//   final String name;
//   final String status;

//   StudentInfo({
//     required this.location,
//     required this.name,
//     required this.status,
//   });
// }

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
=======
//         title: const Text("Driver Live Location"),
//       ),
//       body: _isLocationLoading
//           ? const Center(child: CircularProgressIndicator())
//           : GoogleMap(
//               circles: _createCircles(),
//               compassEnabled: false,
//               initialCameraPosition: CameraPosition(
//                 target: _driverLocation,
//                 zoom: 15,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _mapController = controller;
//               },
//               markers: {
//                 // Add driver's marker
//                 Marker(
//                   markerId: const MarkerId("driver"),
//                   position: _driverLocation,
//                   infoWindow: const InfoWindow(title: "Driver Location"),
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueBlue,
//                   ),
//                 ),
//                 // Add student markers
//                 ..._studentLocations.entries.map((entry) {
//                   return Marker(
//                     markerId: MarkerId(entry.key),
//                     position: entry.value,
//                     infoWindow: InfoWindow(title: "Student ${entry.key}"),
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueGreen,
//                     ),
//                   );
//                 }),
//               },
//             ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
<<<<<<< HEAD
<<<<<<< HEAD
=======

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
=======
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import '../../../services/LocationService.dart';

class DriverLiveLocation extends StatefulWidget {
  final String driverId;
  const DriverLiveLocation({Key? key, required this.driverId})
      : super(key: key);
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  @override
  _DriverLiveLocationState createState() => _DriverLiveLocationState();
}

class _DriverLiveLocationState extends State<DriverLiveLocation> {
  late GoogleMapController _mapController;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
<<<<<<< HEAD
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();
  List<LatLng> polylineCoordinates = [];
  LatLng _driverLocation = const LatLng(0.0, 0.0);
  Map<String, StudentInfo> _studentLocations = {};
  bool _isLocationLoading = true;
  final double driverRadius = 2000;
  MapType _currentMapType = MapType.normal;
  bool _showTraffic = false;
  List<LatLng> _routePoints = [];
=======
<<<<<<< HEAD
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final LocationService _locationService = LocationService();

  LatLng _driverLocation = const LatLng(0.0, 0.0);
  Map<String, StudentInfo> _studentLocations = {};
  bool _isLocationLoading = true;
  // bool _isMapFullScreen = false;
  final double driverRadius = 2000;
  MapType _currentMapType = MapType.normal;
  bool _showTraffic = false;
=======
  final LocationService _locationService = LocationService();
<<<<<<< HEAD

  LatLng _driverLocation = const LatLng(0.0, 0.0); // Initial driver location
  Map<String, LatLng> _studentLocations =
      {}; // Map of student IDs to their coordinates
  bool _isLocationLoading = true;
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
  LatLng _currentLocation = const LatLng(0.0, 0.0); // Initial LatLng
  bool _isLocationLoading = true;
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  @override
  void initState() {
    super.initState();
    _startLocationTracking();
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    _fetchStudentLocations();
  }

  Future<void> _startLocationTracking() async {
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
          distanceFilter: 1,
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
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
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  }

  void _updateDriverLocation(Position position) {
    setState(() {
      _driverLocation = LatLng(position.latitude, position.longitude);
      _isLocationLoading = false;
    });

<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    try {
      _locationService.updateDriverLocation(widget.driverId, position);
      _updateDriverLocationInFirestore();
    } catch (e) {
      _showErrorSnackBar('Error updating location: $e');
    }
  }

  Future<void> _updateDriverLocationInFirestore() async {
    try {
      await _firestore.collection('drivers').doc(widget.driverId).update({
        'latitude': _driverLocation.latitude,
        'longitude': _driverLocation.longitude,
        'lastUpdated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      _showErrorSnackBar('Error updating driver location: $e');
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
    // Update driver's location in the database
    try {
      _locationService.updateDriverLocation(widget.driverId, position);
    } catch (e) {
      print("Error updating driver location: $e");
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    }
  }

  void _fetchStudentLocations() {
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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

          setState(() => _studentLocations = students);
        }
      },
      onError: (error) =>
          _showErrorSnackBar('Error fetching student locations: $error'),
    );
  }

<<<<<<< HEAD
  Future<void> _fetchRoute(LatLng destination) async {
    const String apiKey = 'AIzaSyAZK08jqjlFmCVI2eIVK1TJ-kHYKEwROy4';
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
        setState(() {

          _routePoints = points;
        });
      } else {
        _showErrorSnackBar('Failed to fetch route: ${data['status']}');
      }
    } catch (e) {
      _showErrorSnackBar('Error fetching route: $e');
    }
  }


=======
  Set<Circle> _createCircles() {
    return {
      Circle(
        circleId: const CircleId("driver_radius"),
        center: _driverLocation,
        radius: driverRadius,
        fillColor: Colors.green.withOpacity(0.2),
        strokeColor: Colors.green,
        strokeWidth: 2,
      ),
    };
  }

  void _centerOnDriver() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _driverLocation,
          zoom: 15,
        ),
      ),
    );
<<<<<<< HEAD
=======
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
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
  }

=======
  }

=======
  }

  Future<void> _startLocationTracking() async {
    // Check permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        _isLocationLoading = false;
      });
      return;
    }

    // Get initial position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _updateLocation(position);

    // Listen for location updates
    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1, // Update location every 10 meters
    )).listen((Position position) {
      _updateLocation(position);
    });
  }

  void _updateLocation(Position position) {
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      _isLocationLoading = false;
    });
    try{
      _locationService.updateDriverLocation(widget.driverId, position);
    } catch (e) {
      print("Error updating driver location: $e");
    }
  }

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        title: const Text("Live Location Tracking"),
        actions: [
          IconButton(
            icon: const Icon(Icons.directions),
            onPressed: () async {
              if (_studentLocations.isNotEmpty) {
                final nearestStudent = _studentLocations.entries.first;
                await _fetchRoute(nearestStudent.value.location);
              }
            },
            tooltip: 'Show Route to Nearest Student',
=======
<<<<<<< HEAD
        title: const Text("Live Location Tracking"),
        actions: [
          IconButton(
            icon: Icon(_showTraffic ? Icons.traffic : Icons.traffic_outlined),
            onPressed: () => setState(() => _showTraffic = !_showTraffic),
            tooltip: 'Toggle traffic view',
          ),
          PopupMenuButton<MapType>(
            icon: const Icon(Icons.layers),
            tooltip: 'Change map type',
            onSelected: (MapType type) =>
                setState(() => _currentMapType = type),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MapType.normal,
                child: Text('Normal'),
              ),
              const PopupMenuItem(
                value: MapType.satellite,
                child: Text('Satellite'),
              ),
              const PopupMenuItem(
                value: MapType.hybrid,
                child: Text('Hybrid'),
              ),
            ],
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          ),
        ],
      ),
      body: _isLocationLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
                children: const [
=======
                children:const [
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Getting location...'),
                ],
              ),
            )
<<<<<<< HEAD
          : GoogleMap(
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
              },
            ),
    );
  }
=======
          : Stack(
              children: [
                GoogleMap(
                  circles: _createCircles(),
                  compassEnabled: true,
                  mapType: _currentMapType,
                  trafficEnabled: _showTraffic,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: _driverLocation,
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
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
                          _getMarkerColor(entry.value.status),
                        ),
                      );
                    }),
                  },
                ),
                Positioned(
                  right: 16,
                  bottom: 16,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'centerLocation',
                        onPressed: _centerOnDriver,
                        tooltip: 'Center on my location',
                        child: const Icon(Icons.my_location),
                      ),
                      const SizedBox(height: 8),
                      FloatingActionButton(
                        heroTag: 'toggleSheet',
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 0.25,
                              minChildSize: 0.1,
                              maxChildSize: 0.4,
                              builder: (context, scrollController) => Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, -2),
                                    ),
                                  ],
                                ),
                                child: ListView(
                                  controller: scrollController,
                                  padding: const EdgeInsets.all(16),
                                  children: [
                                    const Center(
                                      child: Text(
                                        'Student Locations',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    ..._studentLocations.entries.map((entry) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: _getStatusColor(
                                              entry.value.status),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                          ),
                                        ),
                                        title: Text(entry.value.name),
                                        subtitle: Text(
                                            'Status: ${entry.value.status}'),
                                        trailing: IconButton(
                                          icon: const Icon(Icons.directions),
                                          onPressed: () =>
                                              _mapController.animateCamera(
                                            CameraUpdate.newLatLng(
                                              entry.value.location,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        tooltip: 'Show student locations',
                        child: const Icon(Icons.list),
                      ),
                    ],
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.25,
                  minChildSize: 0.1,
                  maxChildSize: 0.4,
                  builder: (context, scrollController) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Center(
                          child: Text(
                            'Student Locations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(),
                        ..._studentLocations.entries.map((entry) => ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    _getStatusColor(entry.value.status),
                                child: const Icon(Icons.person,
                                    color: Colors.white),
                              ),
                              title: Text(entry.value.name),
                              subtitle: Text('Status: ${entry.value.status}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.directions),
                                onPressed: () => _mapController.animateCamera(
                                  CameraUpdate.newLatLng(entry.value.location),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  double _getMarkerColor(String status) {
    switch (status.toLowerCase()) {
      case 'picked_up':
        return BitmapDescriptor.hueGreen;
      case 'waiting':
        return BitmapDescriptor.hueOrange;
      default:
        return BitmapDescriptor.hueRed;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'picked_up':
        return Colors.green;
      case 'waiting':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
}

class StudentInfo {
  final LatLng location;
  final String name;
  final String status;

  StudentInfo({
    required this.location,
    required this.name,
    required this.status,
  });
<<<<<<< HEAD
=======
=======
        title: const Text("Driver Live Location"),
      ),
      body: _isLocationLoading
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              compassEnabled: false,
              initialCameraPosition: CameraPosition(
<<<<<<< HEAD
                target: _driverLocation,
=======
                target: _currentLocation,
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: {
<<<<<<< HEAD
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
=======
                Marker(
                  markerId: const MarkerId("driver"),
                  position: _currentLocation,
                  infoWindow: const InfoWindow(title: "Driver Location"),
                ),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
              },
            ),
    );
  }
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
}
