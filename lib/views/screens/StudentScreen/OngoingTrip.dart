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

import '../../../models/user.dart';
import '../../../services/AuthService.dart';

class TrackDriver extends StatefulWidget {
  const TrackDriver({super.key});

  @override
  State<TrackDriver> createState() => _TrackDriverState();
}

class _TrackDriverState extends State<TrackDriver> {
  GoogleMapController? _mapController;
  final DatabaseReference _driverLocationsRef =
      FirebaseDatabase.instance.ref('driverLocations');
  final DatabaseReference _tripUpdatesRef =
      FirebaseDatabase.instance.ref('tripUpdates');
  final UserService _userService = UserService();
  LatLng? driverPosition;
  LatLng? studentPosition;
  LatLng? studentDropOffLocation;
  bool isPickedUp = false;

  String? currentDriverId;
  String studentId = FirebaseAuth.instance.currentUser!.uid;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  final NotificationService _notificationService = NotificationService();
  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _studentIcon;
  BitmapDescriptor? _dropOffIcon;
  double? distanceInMeters;
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
      isloading = false;
    });
    print("Loading end");
  }

  void initializeState() async {
    UserModel? user = await _userService.fetchUser(userId);
    if (user != null) {
      setState(() {
        studentId = user.userID;
        currentDriverId = user.currentDriverId;
      });
      _createInitialTripEntry();
    }
    // fetchCurrentDriverId();
    listenToDriverLocation();
    listenToStudentLocation();
    await getDirections();
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
  }

  void _loadCustomMarkers() async {
    final driverIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 4 / 3),
      'assets/driver_marker.png',
    );
    final studentIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 4 / 3),
        'assets/student_marker.png');
    final dropOffIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 4 / 3),
        'assets/student_marker.png');

    setState(() {
      _driverIcon = driverIcon;
      _studentIcon = studentIcon;
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
    // print("studentPosition: $studentPosition from getDirections");
    print("Getting directions...");
    String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${driverPosition!.latitude},${driverPosition!.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
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
          log(estimatedTime!);
          distanceInMeters = double.parse(distance.split(' ')[0]) * 1000;
          _updatePolylines();
          log(estimatedTime!);
          if (estimatedTime == '2 mins') {
            log('Driver is on the way');
            showNotification(estimatedTime!);
          }
        });
        _updateTripDetails();
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

  // show local notification
  void showNotification(String title) {
    _notificationService.showNotification(
      id: 0,
      title: title,
      body: 'Driver is on the way',
    );
  }

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
          studentDropOffLocation = LatLng(
            documentSnapshot['dropoffLatitude'],
            documentSnapshot['dropOffLongitude'],
          );
        });
      } else {
        log('Document does not exist on the database');
      }
    });
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
            // print("listenToStudentLocation: $studentPosition");
          });
          // updateDistance(); // Update distance when student location changes
          getDirections(); // Update directions when student location changes
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
        // updateDistance();
        getDirections();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                  Icon(Icons.location_on, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text(
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
}
