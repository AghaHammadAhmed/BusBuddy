<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
import 'dart:convert';
import 'dart:developer';

import 'package:busbuddy/services/NotificationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
<<<<<<< HEAD
=======
=======
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
import '../../../models/user.dart';
import '../../../services/AuthService.dart';

class TrackDriver extends StatefulWidget {
  const TrackDriver({super.key});

  @override
  State<TrackDriver> createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
<<<<<<< HEAD
  GoogleMapController? _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
=======
<<<<<<< HEAD
  GoogleMapController? _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
=======
<<<<<<< HEAD
  GoogleMapController? _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
=======
<<<<<<< HEAD
  GoogleMapController? _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
=======
<<<<<<< HEAD
  GoogleMapController? _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
  final DatabaseReference _ridesRef = FirebaseDatabase.instance.ref('rides');
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  final DatabaseReference _tripUpdatesRef =
      FirebaseDatabase.instance.ref('tripUpdates');
  final UserService _userService = UserService();
  LatLng? driverPosition;
  LatLng? studentPosition;
  LatLng? studentDropOffLocation;
  bool isPickedUp = false;
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
  GoogleMapController? _mapController;
=======
  late GoogleMapController _mapController;
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
  final DatabaseReference _ridesRef = FirebaseDatabase.instance.ref('rides');
  final UserService _userService = UserService();
  LatLng? driverPosition;
  LatLng? studentPosition;
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  String? currentDriverId;
  String studentId = FirebaseAuth.instance.currentUser!.uid;
  String userId = FirebaseAuth.instance.currentUser!.uid;
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  final NotificationService _notificationService = NotificationService();
  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _studentIcon;
  BitmapDescriptor? _dropOffIcon;
  double? distanceInMeters;
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======

  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _studentIcon;
<<<<<<< HEAD
  BitmapDescriptor? _dropOffIcon;
  double? distanceInMeters;
=======
  double? distanceInMeters;
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  String? estimatedTime;
  bool isloading = false;
  // Add polylines state
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  static const String GOOGLE_MAPS_API_KEY =
      "AIzaSyAZK08jqjlFmCVI2eIVK1TJ-kHYKEwROy4";
  @override
  void initState() {
    delay();
    super.initState();
    initializeState();
    _loadCustomMarkers();
    fetchUser();
  }

  //deplay of 2 seconds
  Future<void> delay() async {
    setState(() {
      isloading = true;
    });

    print("Loading begin");
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
<<<<<<< HEAD
      if (mounted) isloading = false;
    });
    print("Loading end");
  }

  void initializeState() async {
=======
      isloading = false;
    });
    print("Loading end");
<<<<<<< HEAD
  }

  void initializeState() async {
=======
<<<<<<< HEAD
  }

  void initializeState() async {
=======
<<<<<<< HEAD
  }

  void initializeState() async {
=======
<<<<<<< HEAD
  }

  void initializeState() async {
=======
=======

  @override
  void initState() {
    super.initState();
    initializeState();
    _loadCustomMarkers();
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
  }

  void initializeState() async {
    // Fetch user and update state
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    UserModel? user = await _userService.fetchUser(userId);
    if (user != null) {
      setState(() {
        studentId = user.userID;
        currentDriverId = user.currentDriverId;
      });
<<<<<<< HEAD
      _createInitialTripEntry();
    }
=======
<<<<<<< HEAD
      _createInitialTripEntry();
    }
=======
<<<<<<< HEAD
      _createInitialTripEntry();
    }
=======
<<<<<<< HEAD
      _createInitialTripEntry();
    }
=======
<<<<<<< HEAD
      _createInitialTripEntry();
    }
=======
    }
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    // fetchCurrentDriverId();
    listenToDriverLocation();
    listenToStudentLocation();
    await getDirections();
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
  }

  void _createInitialTripEntry() {
    if (currentDriverId != null) {
      _tripUpdatesRef.child(studentId).set({
        'driverId': currentDriverId,
        'startTime': DateTime.now().toIso8601String(),
        'distance': 0,
        'estimatedTime': '0 mins',
        'status': 'ongoing'
      });
    }
  }

  void _updateTripDetails() {
    if (distanceInMeters != null && estimatedTime != null) {
      _tripUpdatesRef.child(studentId).update({
        'distance': distanceInMeters! / 1000,
        'estimatedTime': estimatedTime,
        'lastUpdate': DateTime.now().toIso8601String(),
        'isPickedUp': isPickedUp,
        'driverLocation': {
          'latitude': driverPosition?.latitude,
          'longitude': driverPosition?.longitude,
        },
        'studentLocation': {
          'latitude': studentPosition?.latitude,
          'longitude': studentPosition?.longitude,
        }
      });
    }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
=======
    fetchCurrentDriverId();
    listenToDriverLocation();
    listenToStudentLocation();
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  }

  void _loadCustomMarkers() async {
    final driverIcon = await BitmapDescriptor.fromAssetImage(
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
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      const ImageConfiguration(devicePixelRatio: 4 / 3),
      'assets/driver_marker.png',
    );
    final studentIcon = await BitmapDescriptor.fromAssetImage(
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
        const ImageConfiguration(devicePixelRatio: 4 / 3),
        'assets/student_marker.png');
    final dropOffIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 4 / 3),
        'assets/student_marker.png');
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
      const ImageConfiguration(devicePixelRatio: 4 / 3),
=======
    const  ImageConfiguration(devicePixelRatio: 4/3),
      'assets/driver_marker.png',
    );
    final studentIcon = await BitmapDescriptor.fromAssetImage(
    const  ImageConfiguration(devicePixelRatio: 4 / 3),
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
      'assets/student_marker.png',
    );
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

    setState(() {
      _driverIcon = driverIcon;
      _studentIcon = studentIcon;
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
      _dropOffIcon = dropOffIcon;
    });
  }

  Future<void> markAsPickedUp() async {
    setState(() {
      isPickedUp = true;
    });

    // Update trip status in Realtime Database
    await _tripUpdatesRef.child(studentId).update({
      'status': 'picked_up',
      'pickupTime': DateTime.now().toIso8601String(),
    });

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
  
=======
    // Recalculate route to dropoff location
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    await getDirections();
  }

  // Add method to get directions
  Future<void> getDirections() async {
    if (driverPosition == null || studentPosition == null) return;

    LatLng destination;
    if (!isPickedUp) {
      if (studentPosition == null) return;
      destination = studentPosition!;
    } else {
      if (studentDropOffLocation == null) return;
      destination = studentDropOffLocation!;
    }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
    });
  }

<<<<<<< HEAD
  // Add method to get directions
  Future<void> getDirections() async {
    if (driverPosition == null || studentPosition == null) return;
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    // print("studentPosition: $studentPosition from getDirections");
    print("Getting directions...");
    String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${driverPosition!.latitude},${driverPosition!.longitude}'
<<<<<<< HEAD
        '&destination=${destination.latitude},${destination.longitude}'
=======
<<<<<<< HEAD
        '&destination=${destination.latitude},${destination.longitude}'
=======
<<<<<<< HEAD
        '&destination=${destination.latitude},${destination.longitude}'
=======
<<<<<<< HEAD
        '&destination=${destination.latitude},${destination.longitude}'
=======
<<<<<<< HEAD
        '&destination=${destination.latitude},${destination.longitude}'
=======
        '&destination=${studentPosition!.latitude},${studentPosition!.longitude}'
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        '&key=$GOOGLE_MAPS_API_KEY';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print("Response: ${response.body}");
      var data = json.decode(response.body);
      if (data['status'] == 'OK') {
        // Get route points
        List<LatLng> points = PolylinePoints()
            .decodePolyline(data['routes'][0]['overview_polyline']['points'])
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
        //get distance
        String distance = data['routes'][0]['legs'][0]['distance']['text'];
        // Get estimated time
        String duration = data['routes'][0]['legs'][0]['duration']['text'];

        setState(() {
          polylineCoordinates = points;
          estimatedTime = duration;
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
          log(estimatedTime!);
          distanceInMeters = double.parse(distance.split(' ')[0]) * 1000;
          _updatePolylines();
          log(estimatedTime!);
<<<<<<< HEAD
          // if (estimatedTime == '14 mins') {
          //   log('Driver is on the way');
          //   showNotification(estimatedTime!);
          // }
        });
        _updateTripDetails();
=======
<<<<<<< HEAD
          if (estimatedTime == '14 mins') {
=======
<<<<<<< HEAD
          if (estimatedTime == '14 mins') {
=======
          if (estimatedTime == '2 mins') {
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
            log('Driver is on the way');
            showNotification(estimatedTime!);
          }
        });
        _updateTripDetails();
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
          distanceInMeters = double.parse(distance.split(' ')[0]) * 1000;
          _updatePolylines();
        });
<<<<<<< HEAD
        _updateTripDetails();
=======

        // Update camera to show entire route
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        LatLngBounds bounds = _getBounds(points);
        _mapController
            ?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
      }
    }
  }

  void _updatePolylines() {
    PolylineId id = const PolylineId('route');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 4,
      // patterns: [
      //   PatternItem.dash(20),
      //   PatternItem.gap(10),
      // ],
    );
    setState(() {
      polylines[id] = polyline;
    });
  }

  LatLngBounds _getBounds(List<LatLng> points) {
    double? minLat, maxLat, minLng, maxLng;
    // print("Points: $points");
    for (LatLng point in points) {
      if (minLat == null || point.latitude < minLat) minLat = point.latitude;
      if (maxLat == null || point.latitude > maxLat) maxLat = point.latitude;
      if (minLng == null || point.longitude < minLng) minLng = point.longitude;
      if (maxLng == null || point.longitude > maxLng) maxLng = point.longitude;
    }
    return LatLngBounds(
      southwest: LatLng(minLat!, minLng!),
      northeast: LatLng(maxLat!, maxLng!),
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  // show local notification
  void showNotification(String title) {
    _notificationService.showNotification(
      id: 0,
      title: title,
      body: 'Driver is on the way',
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
  //fetch the users coordinates from firebase firestore
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  void fetchUser() {
    //firestore
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          studentPosition = LatLng(documentSnapshot['pickupLatitude'],
              documentSnapshot['pickupLongitude']);
<<<<<<< HEAD
          studentDropOffLocation = LatLng(
            documentSnapshot['dropOffLatitude'],
=======
<<<<<<< HEAD
          studentDropOffLocation = LatLng(
            documentSnapshot['dropOffLatitude'],
=======
<<<<<<< HEAD
          studentDropOffLocation = LatLng(
            documentSnapshot['dropOffLatitude'],
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
          studentDropOffLocation = LatLng(
            documentSnapshot['dropoffLatitude'],
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
            documentSnapshot['dropOffLongitude'],
          );
        });
      } else {
        log('Document does not exist on the database');
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
        });
      } else {
       log('Document does not exist on the database');
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      }
    });
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
=======
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

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
            // print("listenToStudentLocation: $studentPosition");
          });
          // updateDistance(); // Update distance when student location changes
          getDirections(); // Update directions when student location changes
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
          });
          updateDistance(); // Update distance when student location changes
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
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
<<<<<<< HEAD
        // updateDistance();
        getDirections();
=======
<<<<<<< HEAD
        // updateDistance();
        getDirections();
=======
<<<<<<< HEAD
        // updateDistance();
        getDirections();
=======
<<<<<<< HEAD
        // updateDistance();
        getDirections();
=======
<<<<<<< HEAD
        // updateDistance();
        getDirections();
=======
<<<<<<< HEAD
        // updateDistance();
        getDirections();
=======
        updateDistance(); // Update distance when driver location changes
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      }
    });
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  @override
  Widget build(BuildContext context) {
    if (currentDriverId == null) {
      return const Scaffold(
        body: Center(
          child: Text('No driver assigned yet'),
        ),
      );
    }

    return Scaffold(
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
=======
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
=======
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
=======
<<<<<<< HEAD
  
=======
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
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: (controller) {
                    _mapController = controller;
                    _mapController!.setMapStyle('''
                [
                  {
                    "featureType": "all",
                    "elementType": "geometry",
                    "stylers": [{"color": "#242f3e"}]
                  },
                  {
                    "featureType": "road",
                    "elementType": "geometry",
                    "stylers": [{"color": "#38414e"}]
                  },
                  {
                    "featureType": "road",
                    "elementType": "geometry.stroke",
                    "stylers": [{"color": "#212a37"}]
                  }
                ]
              ''');
                  },
                  initialCameraPosition: CameraPosition(
                    target: studentPosition!,
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
                  polylines: Set<Polyline>.of(polylines.values),
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                ),
                if (distanceInMeters != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.white.withOpacity(0.9),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: const [
<<<<<<< HEAD
                                  Icon(Icons.location_on, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
=======
<<<<<<< HEAD
                                  Icon(Icons.location_on, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
=======
<<<<<<< HEAD
                                  Icon(Icons.location_on, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
=======
<<<<<<< HEAD
                                  Icon(Icons.location_on, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
=======
<<<<<<< HEAD
                                  Icon(Icons.location_on, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
=======
                                  const Icon(Icons.location_on,
                                      color: Colors.blue),
                                  const SizedBox(width: 8),
                                  const Text(
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                                    'Trip Details',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Distance',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${(distanceInMeters! / 1000).toStringAsFixed(2)} km',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (estimatedTime != null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'ETA',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          estimatedTime!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
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
    );
  }

  // @override
  // void dispose() {
  //   // Clean up trip data when widget is disposed
  //   if (currentDriverId != null) {
  //     _tripUpdatesRef.child(studentId).update(
  //         {'status': 'completed', 'endTime': DateTime.now().toIso8601String()});
  //   }
  //   super.dispose();
  // }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
=======
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
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
    );
  }
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
}
