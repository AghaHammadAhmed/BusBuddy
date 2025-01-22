import 'package:busbuddy/models/driver.dart';
import 'package:busbuddy/services/driverService.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user.dart';
import '../../../services/AuthService.dart';
import '../../../services/LocationService.dart';

class DriverPickUpLocation extends StatefulWidget {
  const DriverPickUpLocation({Key? key}) : super(key: key);

  @override
  _DriverPickUpLocationState createState() => _DriverPickUpLocationState();
}

class _DriverPickUpLocationState extends State<DriverPickUpLocation> {
  late GoogleMapController _mapController;
  DriverService _driverService = DriverService();
  Driver? driver;
  // Location states
  LatLng _pickupLatLng =
      const LatLng(25.3791973, 68.3219916); // Default location
  LatLng _dropoffLatLng = const LatLng(0, 0);

  String _pickupAddress = "";
  // String _dropoffAddress = "";

  bool _isDragging = false;
  bool _isPickupMode = true;

  String userID = FirebaseAuth.instance.currentUser!.uid;
  final LocationService _locationService = LocationService();
  final UserService _userService = UserService();

  final TextEditingController _pickupController = TextEditingController();

<<<<<<< HEAD
=======

>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    fetchDriver(userID);
  }

  //fetch driver by userId
  Future<void> fetchDriver(String userId) async {
    try {
      final user = await _driverService.fetchDriverByUserId(userId);

      setState(() {
        driver = Driver.fromMap(user);
      });
    } catch (e) {
      _showErrorDialog('Failed to fetch driver');
      return null;
    }
  }

  void _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _showPermissionDeniedDialog();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        _pickupLatLng = LatLng(position.latitude, position.longitude);
      });

      _mapController.animateCamera(CameraUpdate.newLatLng(_pickupLatLng));
      _updateAddress(_pickupLatLng, isPickup: true);
    } catch (e) {
      _showErrorDialog('Could not retrieve current location');
    }
  }

  void _updateAddress(LatLng latLng, {required bool isPickup}) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          String formattedAddress = "${place.name ?? ''}, "
                  "${place.locality ?? ''}, "
                  "${place.administrativeArea ?? ''}, "
                  "${place.country ?? ''}"
              .trim();

          if (isPickup) {
            _pickupAddress = formattedAddress;
            _pickupController.text = formattedAddress;
          } else {
            // _dropoffAddress = formattedAddress;
            // _dropoffController.text = formattedAddress;
          }
        });
      }
    } catch (e) {
      setState(() {
        if (isPickup) {
          _pickupAddress = "Unable to get address";
          _pickupController.text = "Unable to get address";
        } else {
          // _dropoffAddress = "Unable to get address";
          // _dropoffController.text = "Unable to get address";
        }
      });
    }
  }

  void _saveLocation() async {
    if (_pickupAddress.isEmpty) {
      _showErrorDialog('Please select a pickup location');
      return;
    }

    try {
      if (driver == null) {
        _showErrorDialog('Please allocate a driver first');
        return;
      }
      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driver!.driverID)
          .update({
        'latitude': _pickupLatLng.latitude,
        'longitude': _pickupLatLng.longitude,
      });
      // Update user's location in Firestore
      // await FirebaseFirestore.instance.collection('users').doc(userID).update({
      //   'address': _pickupAddress,
      //   'pickupLatitude': _pickupLatLng.latitude,
      //   'pickupLongitude': _pickupLatLng.longitude,
      //   'dropOffLocation': _dropoffAddress,
      //   'dropOffLatitude': _dropoffLatLng.latitude,
      //   'dropOffLongitude': _dropoffLatLng.longitude,
      // });

      // Prepare coordinates
      final pickupCoordinates = {
        'latitude': _pickupLatLng.latitude,
        'longitude': _pickupLatLng.longitude,
      };
      // Update student location and allocate driver
      // await _locationService.updateStudentLocation(userID, pickupCoordinates);

      // await _locationService.allocateDriverToStudent(
      //     user.currentDriverId!, userID, pickupCoordinates, dropoffCoordinates);

      // Navigate to main navigation screen
<<<<<<< HEAD
      Navigator.pushNamed(context, '/mainNavigation2');
=======
      Navigator.pushNamed(context, '/driverHome');
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      // Show success message
      _showSuccessDialog('Location saved successfully');
    } catch (e) {
      _showErrorDialog('Failed to update location');
    }
  }

  void _showErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  void _showSuccessDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission'),
        content:
            const Text('Location permission is required to use this feature.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
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
              target: _pickupLatLng,
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationButtonEnabled: false,
            onCameraMove: (CameraPosition position) {
              setState(() {
                _isDragging = true;
                if (_isPickupMode) {
                  _pickupLatLng = position.target;
                } else {
                  // _dropoffLatLng = position.target;
                }
              });
            },
            onCameraIdle: () {
              setState(() {
                _isDragging = false;
              });
              if (_isPickupMode) {
                _updateAddress(_pickupLatLng, isPickup: true);
              } else {
                _updateAddress(_dropoffLatLng, isPickup: false);
              }
            },
          ),

          // Location Marker
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 50,
                  color: _isPickupMode ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 8),
                if (!_isDragging)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(
                      _pickupAddress,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),

          // Bottom Sheet
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pickup Location
                  TextField(
                    readOnly: true,
                    controller: _pickupController,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.location_on, color: Colors.green),
                      hintText: 'Pickup Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon:
                            const Icon(Icons.my_location, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            _isPickupMode = true;
                          });
                          _getCurrentLocation();
                        },
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _isPickupMode = true;
<<<<<<< HEAD
                      },);
=======
                      });
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                    },
                  ),

                  const SizedBox(height: 16),

                  // Confirm Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveLocation,
                      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                        backgroundColor: const Color(0xFF8A1538),
=======
                        backgroundColor: const Color(0xFF0047BA),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Confirm Route',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
