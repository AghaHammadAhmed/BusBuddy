// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
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
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final LocationService _locationService = LocationService();

//   LatLng _driverLocation = const LatLng(0.0, 0.0);
//   Map<String, StudentInfo> _studentLocations = {};
//   bool _isLocationLoading = true;
//   // bool _isMapFullScreen = false;
//   final double driverRadius = 2000;
//   MapType _currentMapType = MapType.normal;
//   bool _showTraffic = false;

//   @override
//   void initState() {
//     super.initState();
//     _startLocationTracking();
//     _fetchStudentLocations();
//   }

//   Future<void> _startLocationTracking() async {
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
//   }

//   void _updateDriverLocation(Position position) {
//     setState(() {
//       _driverLocation = LatLng(position.latitude, position.longitude);
//       _isLocationLoading = false;
//     });

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
//   }

//   Set<Circle> _createCircles() {
//     return {
//       Circle(
//         circleId: const CircleId("driver_radius"),
//         center: _driverLocation,
//         radius: driverRadius,
//         fillColor: Colors.green.withOpacity(0.2),
//         strokeColor: Colors.green,
//         strokeWidth: 2,
//       ),
//     };
//   }

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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
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

// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:http/http.dart' as http;
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
//   List<LatLng> polylineCoordinates = [];
//   LatLng _driverLocation = const LatLng(0.0, 0.0);
//   Map<String, StudentInfo> _studentLocations = {};
//   bool _isLocationLoading = true;
//   final double driverRadius = 2000;
//   MapType _currentMapType = MapType.normal;
//   bool _showTraffic = false;
//   List<LatLng> _routePoints = [];

//   @override
//   void initState() {
//     super.initState();
//     _startLocationTracking();
//     _fetchStudentLocations();
//   }

//   Future<void> _startLocationTracking() async {
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
//           distanceFilter: 10,
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
//   }

//   void _updateDriverLocation(Position position) {
//     setState(() {
//       _driverLocation = LatLng(position.latitude, position.longitude);
//       _isLocationLoading = false;
//     });

//     try {
//       _locationService.updateDriverLocation(widget.driverId, position);
//       _fetchRoute(_studentLocations.entries.first.value.location);
//       _updateDriverLocationInFirestore();
//     } catch (e) {
//       _showErrorSnackBar('Error updating location: $e');
//     }
//   }

//   Future<void> _updateDriverLocationInFirestore() async {
//     try {
//       await _firestore.collection('drivers').doc(widget.driverId).update({
//         'recentlatitude': _driverLocation.latitude,
//         'recentlongitude': _driverLocation.longitude,
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
//   }

//   Future<void> _fetchRoute(LatLng destination) async {
//     const String apiKey = 'AIzaSyAZK08jqjlFmCVI2eIVK1TJ-kHYKEwROy4';
//     final Uri uri = Uri.parse(
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${_driverLocation.latitude},${_driverLocation.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey');

//     try {
//       final response = await http.get(uri);
//       final data = json.decode(response.body);
//       log('Route data: $data');

//       if (data['status'] == 'OK') {
//         List<LatLng> points = PolylinePoints()
//             .decodePolyline(data['routes'][0]['overview_polyline']['points'])
//             .map((point) => LatLng(point.latitude, point.longitude))
//             .toList();
//         setState(() {
//           _routePoints = points;
//         });
//       } else {
//         _showErrorSnackBar('Failed to fetch route: ${data['status']}');
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error fetching route: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Live Location Tracking"),
//       ),
//       body: _isLocationLoading
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text('Getting location...'),
//                 ],
//               ),
//             )
//           : GoogleMap(
//               mapType: _currentMapType,
//               trafficEnabled: _showTraffic,
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               initialCameraPosition: CameraPosition(
//                 target: _driverLocation,
//                 zoom: 15,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _mapController = controller;
//               },
//               polylines: {
//                 Polyline(
//                   polylineId: const PolylineId('route'),
//                   points: _routePoints,
//                   color: Colors.blue,
//                   width: 5,
//                 ),
//               },
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("driver"),
//                   position: _driverLocation,
//                   infoWindow: const InfoWindow(title: "My Location"),
//                   icon: BitmapDescriptor.defaultMarkerWithHue(
//                     BitmapDescriptor.hueBlue,
//                   ),
//                 ),
//                 ..._studentLocations.entries.map((entry) {
//                   return Marker(
//                     markerId: MarkerId(entry.key),
//                     position: entry.value.location,
//                     infoWindow: InfoWindow(
//                       title: entry.value.name,
//                       snippet: 'Status: ${entry.value.status}',
//                     ),
//                     icon: BitmapDescriptor.defaultMarkerWithHue(
//                       BitmapDescriptor.hueOrange,
//                     ),
//                   );
//                 }),
//               },
//             ),
//     );
//   }

//   @override
// //dispose method
//   void dispose() {
//     super.dispose();
//     _mapController.dispose();
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<LatLng> polylineCoordinates = [];
  LatLng _driverLocation = const LatLng(0.0, 0.0);
  Map<String, StudentInfo> _studentLocations = {};
  bool _isLocationLoading = true;
  final double driverRadius = 2000;
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

          setState(() => _studentLocations = students);

          // Fetch distance and time for each student
          // for (final entry in students.entries) {
          // (entry.value.location, entry.key);
          // }
        }
      },
      onError: (error) =>
          _showErrorSnackBar('Error fetching student locations: $error'),
    );
  }

  // Future<void> _fetchDistanceAndTime(
  //     LatLng studentLocation, String studentId) async {
  //   const String apiKey = 'AIzaSyAZK08jqjlFmCVI2eIVK1TJ-kHYKEwROy4';
  //   final Uri uri = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/distancematrix/json?origins=${_driverLocation.latitude},${_driverLocation.longitude}&destinations=${studentLocation.latitude},${studentLocation.longitude}&key=$apiKey');

  //   try {
  //     final response = await http.get(uri);
  //     final data = json.decode(response.body);

  //     if (data['status'] == 'OK') {
  //       final element = data['rows'][0]['elements'][0];
  //       final distance = element['distance']['text'];
  //       final duration = element['duration']['text'];

  //       setState(() {
  //         _studentLocations[studentId] = _studentLocations[studentId]!.copyWith(
  //           distance: distance,
  //           time: duration,
  //         );
  //       });
  //     } else {
  //       _showErrorSnackBar(
  //           'Failed to fetch distance and time: ${data['status']}');
  //     }
  //   } catch (e) {
  //     _showErrorSnackBar('Error fetching distance and time: $e');
  //   }
  // }

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
             String distance = data['routes'][0]['legs'][0]['distance']['text'];
        // Get estimated time
        String duration = data['routes'][0]['legs'][0]['duration']['text'];
        setState(() {
          _routePoints = points;
          _studentLocations[_studentLocations.keys.first] =
              _studentLocations[_studentLocations.keys.first]!.copyWith(
            distance: distance,
            time: duration,
          );
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

  void _markStudentAsPickedUp(String studentId) {
    setState(() {
      _studentLocations.remove(studentId);
    });

    if (_studentLocations.isNotEmpty) {
      _fetchRoute(_studentLocations.entries.first.value.location);
    } else {
      _showErrorSnackBar('All students picked up!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Location Tracking"),
      ),
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
                    },
                  ),
                ),
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
