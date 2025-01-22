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

// class DriverLiveLocation extends StatefulWidget {
//   final String driverId;
//   const DriverLiveLocation({Key? key, required this.driverId})
//       : super(key: key);

//   @override
//   _DriverLiveLocationState createState() => _DriverLiveLocationState();
// }

// class _DriverLiveLocationState extends State<DriverLiveLocation> {
//   late GoogleMapController _mapController;
//   final loading = true;
//   final DatabaseReference _database = FirebaseDatabase.instance.ref();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<LatLng> polylineCoordinates = [];
//   LatLng _driverLocation = const LatLng(0.0, 0.0);
//   Map<String, StudentInfo> _studentLocations = {};
//   bool _isLocationLoading = true;
//   final double driverRadius = 2000;
//   MapType _currentMapType = MapType.normal;
//   bool _showTraffic = false;
//   List<LatLng> _routePoints = [];

//   //add delay on loading

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
//       _updateDriverLocationInFirestore();
//       if (_studentLocations.isNotEmpty) {
//         _fetchRoute(_studentLocations.entries.first.value.location);
//       }
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
//           if (mounted) {
//             setState(() => _studentLocations = students);
//           }
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
//         String distance = data['routes'][0]['legs'][0]['distance']['text'];
//         // Get estimated time
//         String duration = data['routes'][0]['legs'][0]['duration']['text'];
//         setState(() {
//           _routePoints = points;
//           _studentLocations[_studentLocations.keys.first] =
//               _studentLocations[_studentLocations.keys.first]!.copyWith(
//             distance: distance,
//             time: duration,
//           );
//         });
//       } else {
//         _showErrorSnackBar('Failed to fetch route: ${data['status']}');
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error fetching route: $e');
//     }
//   }

//   Widget _buildStudentMarkers() {
//     return Column(
//       children: _studentLocations.entries.map((entry) {
//         final student = entry.value;
//         final isNear = _isWithinRadius(student.location, driverRadius);

//         return ListTile(
//           title: Text(student.name),
//           subtitle: Text(
//               'Distance: ${student.distance ?? '--'}, Time: ${student.time ?? '--'}'),
//           trailing: isNear
//               ? ElevatedButton(
//                   onPressed: () {
//                     _markStudentAsPickedUp(entry.key);
//                   },
//                   child: const Text('Pickup'),
//                 )
//               : null,
//         );
//       }).toList(),
//     );
//   }

//   bool _isWithinRadius(LatLng studentLocation, double radius) {
//     final distance = Geolocator.distanceBetween(
//       _driverLocation.latitude,
//       _driverLocation.longitude,
//       studentLocation.latitude,
//       studentLocation.longitude,
//     );
//     return distance <= radius;
//   }

//   void _markStudentAsPickedUp(String studentId) {
//     setState(() {
//       _studentLocations.remove(studentId);
//     });

//     if (_studentLocations.isNotEmpty) {
//       _fetchRoute(_studentLocations.entries.first.value.location);
//     } else {
//       _showErrorSnackBar('All students picked up!');
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
//           : Column(
//               children: [
//                 Expanded(
//                   child: GoogleMap(
//                     mapType: _currentMapType,
//                     trafficEnabled: _showTraffic,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: false,
//                     initialCameraPosition: CameraPosition(
//                       target: _driverLocation,
//                       zoom: 15,
//                     ),
//                     onMapCreated: (GoogleMapController controller) {
//                       _mapController = controller;
//                     },
//                     polylines: {
//                       Polyline(
//                         polylineId: const PolylineId('route'),
//                         points: _routePoints,
//                         color: Colors.blue,
//                         width: 5,
//                       ),
//                     },
//                     markers: {
//                       Marker(
//                         markerId: const MarkerId("driver"),
//                         position: _driverLocation,
//                         infoWindow: const InfoWindow(title: "My Location"),
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                           BitmapDescriptor.hueBlue,
//                         ),
//                       ),
//                       ..._studentLocations.entries.map((entry) {
//                         return Marker(
//                           markerId: MarkerId(entry.key),
//                           position: entry.value.location,
//                           infoWindow: InfoWindow(
//                             title: entry.value.name,
//                             snippet: 'Status: ${entry.value.status}',
//                           ),
//                           icon: BitmapDescriptor.defaultMarkerWithHue(
//                             BitmapDescriptor.hueOrange,
//                           ),
//                         );
//                       }),
//                     },
//                   ),
//                 ),
//                 _buildStudentMarkers(),
//               ],
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _mapController.dispose();
//   }
// }

// class StudentInfo {
//   final LatLng location;
//   final String name;
//   final String status;
//   final String? distance;
//   final String? time;

//   StudentInfo({
//     required this.location,
//     required this.name,
//     required this.status,
//     this.distance,
//     this.time,
//   });

//   StudentInfo copyWith({
//     LatLng? location,
//     String? name,
//     String? status,
//     String? distance,
//     String? time,
//   }) {
//     return StudentInfo(
//       location: location ?? this.location,
//       name: name ?? this.name,
//       status: status ?? this.status,
//       distance: distance ?? this.distance,
//       time: time ?? this.time,
//     );
//   }
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
//   List<LatLng> polylineCoordinates = [];
//   LatLng _driverLocation = const LatLng(0.0, 0.0);
//   LatLng? _driverDestination; // Driver's destination
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
//     _fetchDriverDestination();
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
//       _updateDriverLocationInFirestore();
//       if (_studentLocations.isNotEmpty) {
//         _fetchRoute(_studentLocations.entries.first.value.location);
//       }
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
//           if (mounted) {
//             setState(() => _studentLocations = students);
//           }
//         }
//       },
//       onError: (error) =>
//           _showErrorSnackBar('Error fetching student locations: $error'),
//     );
//   }

//   Future<void> _fetchDriverDestination() async {
//     try {
//       final doc =
//           await _firestore.collection('drivers').doc(widget.driverId).get();
//       if (doc.exists) {
//         final data = doc.data();
//         if (data != null &&
//             data.containsKey('latitude') &&
//             data.containsKey('longitude')) {
//           setState(() {
//             _driverDestination = LatLng(
//               data['latitude'],
//               data['longitude'],
//             );
//           });
//         }
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error fetching destination: $e');
//     }
//   }

//   void _markStudentAsPickedUp(String studentId) {
//     setState(() {
//       _studentLocations.remove(studentId);
//     });

//     if (_studentLocations.isNotEmpty) {
//       _fetchRoute(_studentLocations.entries.first.value.location);
//     } else if (_driverDestination != null) {
//       // Navigate to the driver's destination once all students are picked up
//       _fetchRoute(_driverDestination!);
//       _showErrorSnackBar('All students picked up! Heading to destination.');
//     } else {
//       _showErrorSnackBar('All students picked up but no destination found.');
//     }
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
//         String distance = data['routes'][0]['legs'][0]['distance']['text'];
//         String duration = data['routes'][0]['legs'][0]['duration']['text'];
//         setState(() {
//           _routePoints = points;
//           if (_studentLocations.isNotEmpty) {
//             _studentLocations[_studentLocations.keys.first] =
//                 _studentLocations[_studentLocations.keys.first]!.copyWith(
//               distance: distance,
//               time: duration,
//             );
//           }
//         });
//       } else {
//         _showErrorSnackBar('Failed to fetch route: ${data['status']}');
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error fetching route: $e');
//     }
//   }

//   Widget _buildStudentMarkers() {
//     return Column(
//       children: _studentLocations.entries.map((entry) {
//         final student = entry.value;
//         final isNear = _isWithinRadius(student.location, driverRadius);

//         return ListTile(
//           title: Text(student.name),
//           subtitle: Text(
//               'Distance: ${student.distance ?? '--'}, Time: ${student.time ?? '--'}'),
//           trailing: isNear
//               ? ElevatedButton(
//                   onPressed: () {
//                     _markStudentAsPickedUp(entry.key);
//                   },
//                   child: const Text('Pickup'),
//                 )
//               : null,
//         );
//       }).toList(),
//     );
//   }

//   bool _isWithinRadius(LatLng studentLocation, double radius) {
//     final distance = Geolocator.distanceBetween(
//       _driverLocation.latitude,
//       _driverLocation.longitude,
//       studentLocation.latitude,
//       studentLocation.longitude,
//     );
//     return distance <= radius;
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
//           : Column(
//               children: [
//                 Expanded(
//                   child: GoogleMap(
//                     mapType: _currentMapType,
//                     trafficEnabled: _showTraffic,
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: false,
//                     initialCameraPosition: CameraPosition(
//                       target: _driverLocation,
//                       zoom: 15,
//                     ),
//                     onMapCreated: (GoogleMapController controller) {
//                       _mapController = controller;
//                     },
//                     polylines: {
//                       Polyline(
//                         polylineId: const PolylineId('route'),
//                         points: _routePoints,
//                         color: Colors.blue,
//                         width: 5,
//                       ),
//                     },
//                     markers: {
//                       Marker(
//                         markerId: const MarkerId("driver"),
//                         position: _driverLocation,
//                         infoWindow: const InfoWindow(title: "My Location"),
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                           BitmapDescriptor.hueBlue,
//                         ),
//                       ),
//                       if (_driverDestination != null)
//                         Marker(
//                           markerId: const MarkerId("destination"),
//                           position: _driverDestination!,
//                           infoWindow: const InfoWindow(title: "Destination"),
//                           icon: BitmapDescriptor.defaultMarkerWithHue(
//                             BitmapDescriptor.hueRed,
//                           ),
//                         ),
//                       ..._studentLocations.entries.map((entry) {
//                         return Marker(
//                           markerId: MarkerId(entry.key),
//                           position: entry.value.location,
//                           infoWindow: InfoWindow(
//                             title: entry.value.name,
//                             snippet: 'Status: ${entry.value.status}',
//                           ),
//                           icon: BitmapDescriptor.defaultMarkerWithHue(
//                             BitmapDescriptor.hueOrange,
//                           ),
//                         );
//                       }),
//                     },
//                   ),
//                 ),
//                 _buildStudentMarkers(),
//               ],
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _mapController.dispose();
//   }
// }

// class StudentInfo {
//   final LatLng location;
//   final String name;
//   final String status;
//   final String? distance;
//   final String? time;

//   StudentInfo({
//     required this.location,
//     required this.name,
//     required this.status,
//     this.distance,
//     this.time,
//   });

//   StudentInfo copyWith({
//     LatLng? location,
//     String? name,
//     String? status,
//     String? distance,
//     String? time,
//   }) {
//     return StudentInfo(
//       location: location ?? this.location,
//       name: name ?? this.name,
//       status: status ?? this.status,
//       distance: distance ?? this.distance,
//       time: time ?? this.time,
//     );
//   }
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
//   List<LatLng> polylineCoordinates = [];
//   LatLng _driverLocation = const LatLng(0.0, 0.0);
//   Map<String, StudentInfo> _studentLocations = {};
//   bool _isLocationLoading = true;
//   final double driverRadius = 10000.0; // Set to 10 meters for pickup radius
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
//       _updateDriverLocationInFirestore();
//       if (_studentLocations.isNotEmpty) {
//         _fetchRoute(_studentLocations.entries.first.value.location);
//       }
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
//           if (mounted) {
//             setState(() => _studentLocations = students);
//           }
//         }
//       },
//       onError: (error) =>
//           _showErrorSnackBar('Error fetching student locations: $error'),
//     );
//   }

//   LatLng? _destinationLocation; // Add this to track the destination

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

//         String distance = data['routes'][0]['legs'][0]['distance']['text'];
//         String duration = data['routes'][0]['legs'][0]['duration']['text'];

//         setState(() {
//           _routePoints = points;
//           if (_studentLocations.isNotEmpty) {
//             _studentLocations[_studentLocations.keys.first] =
//                 _studentLocations[_studentLocations.keys.first]!.copyWith(
//               distance: distance,
//               time: duration,
//             );
//           } else {
//             // Set destination location for marker
//             _destinationLocation = destination;
//           }
//         });
//       } else {
//         _showErrorSnackBar('Failed to fetch route: ${data['status']}');
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error fetching route: $e');
//     }
//   }

//   Widget _buildStudentMarkers() {
//     return Column(
//       children: _studentLocations.entries.map((entry) {
//         final student = entry.value;
//         final isNear = _isWithinRadius(student.location, driverRadius);
//         return ListTile(
//           title: Text(student.name),
//           subtitle: Text(
//               'Distance: ${student.distance ?? '--'}, Time: ${student.time ?? '--'}'),
//           trailing: isNear
//               ? ElevatedButton(
//                   onPressed: () {
//                     _markStudentAsPickedUp(entry.key);
//                   },
//                   child: const Text('Pickup'),
//                 )
//               : null,
//         );
//       }).toList(),
//     );
//   }

//   bool _isWithinRadius(LatLng studentLocation, double radius) {
//     final distance = Geolocator.distanceBetween(
//       _driverLocation.latitude,
//       _driverLocation.longitude,
//       studentLocation.latitude,
//       studentLocation.longitude,
//     );
//     return distance <= radius;
//   }

//   void _markStudentAsPickedUp(String studentId) async {
//     try {
//       // Remove the student from the current list
//       final pickedUpStudent = _studentLocations.remove(studentId);

//       // Update the student's status in Firebase
//       await _database.child('rides/${widget.driverId}/$studentId').update({
//         'status': 'Picked Up',
//       });

//       // Log the ride completion in Firestore or Firebase Realtime Database
//       await _firestore.collection('completedRides').add({
//         'driverId': widget.driverId,
//         'studentId': studentId,
//         'studentName': pickedUpStudent?.name,
//         'timestamp': DateTime.now().toIso8601String(),
//       });

//       setState(() {
//         _studentLocations = _studentLocations;
//       });

//       if (_studentLocations.isNotEmpty) {
//         _fetchRoute(_studentLocations.entries.first.value.location);
//       } else {
//         // All students picked up; navigate to the final destination
//         _showErrorSnackBar(
//             'All students picked up! Navigating to destination.');
//         final driverData =
//             await _firestore.collection('drivers').doc(widget.driverId).get();
//         final destination = LatLng(
//           driverData.data()?['latitude'] ?? 0.0,
//           driverData.data()?['longitude'] ?? 0.0,
//         );
//         log('Destination: $destination');
//         _fetchRoute(destination);
//       }
//     } catch (e) {
//       _showErrorSnackBar('Error marking student as picked up: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//           : Column(
//               children: [
//                 Expanded(
//                     child: GoogleMap(
//                   mapType: _currentMapType,
//                   trafficEnabled: _showTraffic,
//                   myLocationEnabled: true,
//                   myLocationButtonEnabled: false,
//                   initialCameraPosition: CameraPosition(
//                     target: _driverLocation,
//                     zoom: 15,
//                   ),
//                   onMapCreated: (GoogleMapController controller) {
//                     _mapController = controller;
//                   },
//                   polylines: {
//                     Polyline(
//                       polylineId: const PolylineId('route'),
//                       points: _routePoints,
//                       color: Colors.blue,
//                       width: 5,
//                     ),
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
//                           BitmapDescriptor.hueOrange,
//                         ),
//                       );
//                     }),
//                     if (_destinationLocation != null)
//                       Marker(
//                         markerId: const MarkerId("destination"),
//                         position: _destinationLocation!,
//                         infoWindow:
//                             const InfoWindow(title: "Final Destination"),
//                         icon: BitmapDescriptor.defaultMarkerWithHue(
//                           BitmapDescriptor.hueGreen,
//                         ),
//                       ),
//                   },
//                 )),
//                 _buildStudentMarkers(),
//               ],
//             ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _mapController.dispose();
//   }
// }

// class StudentInfo {
//   final LatLng location;
//   final String name;
//   final String status;
//   final String? distance;
//   final String? time;

//   StudentInfo({
//     required this.location,
//     required this.name,
//     required this.status,
//     this.distance,
//     this.time,
//   });

//   StudentInfo copyWith({
//     LatLng? location,
//     String? name,
//     String? status,
//     String? distance,
//     String? time,
//   }) {
//     return StudentInfo(
//       location: location ?? this.location,
//       name: name ?? this.name,
//       status: status ?? this.status,
//       distance: distance ?? this.distance,
//       time: time ?? this.time,
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:busbuddy/models/driver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

enum RidePhase {
  homeToSchool,
  arrivedAtSchool,
  schoolToHome,
  completed,
  waitingForNextRide
}

class DriverLiveLocation extends StatefulWidget {
  // final String? driverId;
  const DriverLiveLocation({Key? key}) : super(key: key);

  @override
  _DriverLiveLocationState createState() => _DriverLiveLocationState();
}

class _DriverLiveLocationState extends State<DriverLiveLocation> {
  late GoogleMapController _mapController;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<LatLng> polylineCoordinates = [];
  bool _isNearSchool = false;
  LatLng _driverLocation = const LatLng(0.0, 0.0);
  Map<String, StudentInfo> _studentLocations = {};
  bool _isLocationLoading = true;
  final double driverRadius = 10000.0;
  MapType _currentMapType = MapType.normal;
  bool _showTraffic = false;
  List<LatLng> _routePoints = [];
  RidePhase _currentPhase = RidePhase.homeToSchool;
  LatLng? _schoolLocation;
  bool _isRideActive = true;
  Driver? _driver;
  FirebaseAuth _auth = FirebaseAuth.instance;
  // final String? driverId;
  @override
  void initState() {
    super.initState();

    _loadDriver();
  }

  Future<void> _loadDriver() async {
    try {
      Driver? fetchedDriver = await _fetchDriverByUserId();
      if (fetchedDriver != null) {
        setState(() {
          _driver = fetchedDriver;
          log(_driver!.driverID);
        });
      }
      _fetchStudentLocations();
      await _startLocationTracking();
      await _fetchSchoolLocation();
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<Driver?> _fetchDriverByUserId() async {
    try {
      QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
          .collection('drivers')
          .where('userID', isEqualTo: _auth.currentUser!.uid)
          .limit(1)
          .get();

      if (driverQuery.docs.isNotEmpty) {
        final driverData = driverQuery.docs.first.data();
        return Driver.fromJson(driverData);
      }
      return null;
    } catch (e) {
      print("Failed to fetch driver: $e");
      return null;
    }
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

  void _checkSchoolProximity() {
    if (_schoolLocation != null) {
      final distance = Geolocator.distanceBetween(
        _driverLocation.latitude,
        _driverLocation.longitude,
        _schoolLocation!.latitude,
        _schoolLocation!.longitude,
      );
      setState(() {
        _isNearSchool = distance <= driverRadius;
      });
    }
  }

  Future<void> _fetchSchoolLocation() async {
    try {
      final driverData =
          await _firestore.collection('drivers').doc(_driver!.driverID).get();
      if (driverData.exists) {
        _schoolLocation = LatLng(
          driverData.data()?['latitude'] ?? 0.0,
          driverData.data()?['longitude'] ?? 0.0,
        );
        log('School Location: $_schoolLocation');
      }
    } catch (e) {
      _showErrorSnackBar('Error fetching school location: $e');
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
      _checkSchoolProximity();
      if (_studentLocations.isNotEmpty) {
        _fetchRoute(_studentLocations.entries.first.value.location);
      }
    } catch (e) {
      _showErrorSnackBar('Error updating location: $e');
    }
  }

  Future<void> _updateDriverLocationInFirestore() async {
    try {
      await _firestore.collection('drivers').doc(_driver!.driverID).update({
        'recentlatitude': _driverLocation.latitude,
        'recentlongitude': _driverLocation.longitude,
      });
    } catch (e) {
      _showErrorSnackBar('Error updating driver location: $e');
    }
  }

  void _fetchStudentLocations() {
    _database.child('rides/${_driver!.driverID}').onValue.listen(
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

  Future<void> _fetchRoute(LatLng destination) async {
    const String apiKey = 'AIzaSyAZK08jqjlFmCVI2eIVK1TJ-kHYKEwROy4';
    final Uri uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_driverLocation.latitude},${_driverLocation.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey');

    try {
      final response = await http.get(uri);
      final data = json.decode(response.body);

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
          }
        });
      } else {
        _showErrorSnackBar('Failed to fetch route: ${data['status']}');
      }
    } catch (e) {
      _showErrorSnackBar('Error fetching route: $e');
    }
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
      final pickedUpStudent = _studentLocations.remove(studentId);

      String status =
          _currentPhase == RidePhase.homeToSchool ? 'Picked Up' : 'Dropped Off';

      await _database.child('rides/${_driver!.driverID}/$studentId').update({
        'status': status,
      });

      await _firestore.collection('completedRides').add({
        'driverId': _driver!.driverID,
        'studentId': studentId,
        'studentName': pickedUpStudent?.name,
        'timestamp': DateTime.now().toIso8601String(),
        'action': status,
        'phase': _currentPhase.toString(),
      });

      setState(() {
        _studentLocations = _studentLocations;
      });

      if (_studentLocations.isEmpty) {
        _handleEmptyLocations();
      } else {
        _fetchRoute(_studentLocations.entries.first.value.location);
      }
    } catch (e) {
      _showErrorSnackBar('Error marking student status: $e');
    }
  }

  void _handleEmptyLocations() async {
    switch (_currentPhase) {
      case RidePhase.homeToSchool:
        try {
          final driverData = await _firestore
              .collection('drivers')
              .doc(_driver!.driverID)
              .get();
          final schoolLocation = LatLng(
            driverData.data()?['latitude'] ?? 0.0,
            driverData.data()?['longitude'] ?? 0.0,
          );
          setState(() {
            _schoolLocation = schoolLocation;
            _currentPhase = RidePhase.arrivedAtSchool;
          });
          _showSuccessDialog('All students picked up! Heading to school.');
          _fetchRoute(schoolLocation);
          _checkSchoolProximity(); // Start checking proximity to school
        } catch (e) {
          _showErrorSnackBar('Error getting school location: $e');
        }
        break;

      case RidePhase.schoolToHome:
        setState(() {
          _currentPhase = RidePhase.completed;
          _isRideActive = false;
        });
        _showSuccessDialog('All students dropped off! Ride completed.');
        break;

      default:
        break;
    }
  }

  void _markReachedSchool() async {
    try {
      // Clear current student locations
      setState(() {
        _studentLocations = {};
        _currentPhase = RidePhase.schoolToHome;
        _isRideActive = true;
      });

      // Update students' status to waiting at school
      final studentsSnapshot =
          await _database.child('rides/${_driver!.driverID}').get();
      if (studentsSnapshot.value != null) {
        final Map ridesData = studentsSnapshot.value as Map;
        for (var studentId in ridesData.keys) {
          await _database
              .child('rides/${_driver!.driverID}/$studentId')
              .update({
            'status': 'WaitingAtSchool',
          });
        }
      }

      // Show transition screen
      setState(() {
        _isRideActive = true;
      });

      _showSuccessDialog(
        'Ready to pick up students from school. Press OK to start return journey.',
        onDismiss: () {
          // Fetch students for return journey after dialog is dismissed
          _fetchStudentLocations();
        },
      );
    } catch (e) {
      _showErrorSnackBar('Error transitioning to school pickup: $e');
    }
  }

  void _startNewRide() async {
    try {
      setState(() {
        _isRideActive = true;
        _currentPhase = RidePhase.homeToSchool;
      });
      _fetchStudentLocations();
      _showSuccessDialog(
          'New ride started! Pick up students from their homes.');
    } catch (e) {
      _showErrorSnackBar('Error starting new ride: $e');
    }
  }

  void _showSuccessDialog(String message, {Function? onDismiss}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Status Update'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onDismiss != null) onDismiss();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentMarkers() {
    return Column(
      children: _studentLocations.entries.map((entry) {
        final student = entry.value;
        final isNear = _isWithinRadius(student.location, driverRadius);
        final buttonText =
            _currentPhase == RidePhase.homeToSchool ? 'Pick Up' : 'Drop Off';

        return ListTile(
          title: Text(student.name),
          subtitle: Text(
            'Distance: ${student.distance ?? '--'}, Time: ${student.time ?? '--'}',
          ),
          trailing: isNear
              ? ElevatedButton(
                  onPressed: () => _markStudentAsPickedUp(entry.key),
                  child: Text(buttonText),
                )
              : null,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPhase == RidePhase.schoolToHome && _studentLocations.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Waiting for Students',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Ready to pick up students from school',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _fetchStudentLocations,
                child: const Text('Refresh Student List'),
              ),
            ],
          ),
        ),
      );
    }
    if (!_isRideActive) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Ride Completed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startNewRide,
                child: const Text('Start New Ride'),
              ),
            ],
          ),
        ),
      );
    }

    if (_isLocationLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Getting location...'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
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
                  infoWindow: InfoWindow(
                    title: "Driver Location",
                    snippet:
                        "Phase: ${_currentPhase.toString().split('.').last}",
                  ),
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
                if (_schoolLocation != null)
                  Marker(
                    markerId: const MarkerId("school"),
                    position: _schoolLocation!,
                    infoWindow: const InfoWindow(title: "School"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen,
                    ),
                  ),
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  'Current Phase: ${_currentPhase.toString().split('.').last}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (_currentPhase == RidePhase.arrivedAtSchool && _isNearSchool)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _markReachedSchool,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text(
                        'Reached School - Start Return Journey',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                if (_currentPhase != RidePhase.arrivedAtSchool ||
                    !_isNearSchool)
                  _buildStudentMarkers(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
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
