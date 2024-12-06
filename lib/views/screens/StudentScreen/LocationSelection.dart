import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../../../services/LocationService.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController _mapController;
  LatLng _currentLatLng = const LatLng(25.3791973, 68.3219916); // Default to SF
  String _currentAddress = "Fetching address...";
  bool _isDragging = false;
  String userID =
      FirebaseAuth.instance.currentUser?.uid ?? "ZUXmaewWH9MzkPLL8zPb75TW4T82";
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return; // Handle permission denial
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
    });

    _mapController.animateCamera(CameraUpdate.newLatLng(_currentLatLng));

    _updateAddress(_currentLatLng);
  }

  void _updateAddress(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          _currentAddress =
              "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Unable to get address";
      });
    }
  }

  void _saveLocation() async {
    try {
      print(userID);
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
        'address': _currentAddress,
      });

      await _locationService.updateStudentLocation(userID, _currentLatLng);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location Saved: $_currentAddress')),
      );
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            initialCameraPosition: CameraPosition(
              target: _currentLatLng,
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationButtonEnabled: false,
            onCameraMove: (CameraPosition position) {
              setState(() {
                _isDragging = true;
                _currentLatLng = position.target;
              });
            },
            onCameraIdle: () {
              setState(() {
                _isDragging = false;
              });
              _updateAddress(_currentLatLng);
            },
          ),

          // Current Location Marker
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 50,
                  color: Colors.red,
                ),
                const SizedBox(height: 8),
                if (!_isDragging)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(
                      _currentAddress,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Your Location",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for a location',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Save Location Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Save Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Current Location Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _getCurrentLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF0047BA)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Use Current Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0047BA),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
