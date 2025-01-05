<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
// // ignore_for_file: use_build_context_synchronously
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// import '../../../models/user.dart';
// import '../../../services/AuthService.dart';
// import '../../../services/LocationService.dart';

// class LocationPickerScreen extends StatefulWidget {
//   const LocationPickerScreen({Key? key}) : super(key: key);

//   @override
//   _LocationPickerScreenState createState() => _LocationPickerScreenState();
// }

// class _LocationPickerScreenState extends State<LocationPickerScreen> {
//   late GoogleMapController _mapController;
//   LatLng _currentLatLng = const LatLng(25.3791973, 68.3219916); // Default to SF
//   String _currentAddress = "";
//   bool _isDragging = false;
//   String userID =
//       FirebaseAuth.instance.currentUser!.uid;
//   final LocationService _locationService = LocationService();

//   final UserService _userService = UserService();

//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }

//   void _getCurrentLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied ||
//         permission == LocationPermission.deniedForever) {
//       return; // Handle permission denial
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);

//     setState(() {
//       _currentLatLng = LatLng(position.latitude, position.longitude);
//     });

//     _mapController.animateCamera(CameraUpdate.newLatLng(_currentLatLng));

//     _updateAddress(_currentLatLng);
//   }

//   void _updateAddress(LatLng latLng) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;
//         setState(() {
//           _currentAddress =
//               "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _currentAddress = "Unable to get address";
//       });
//     }
//   }

//   void _confirmAndSaveLocation() async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Confirm Location'),
//           content: const Text('Are you sure you want to update your location?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Dismiss the dialog
//               },
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await _saveLocation();
//               },
//               child: const Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _saveLocation() async {
//     try {
//       // Fetch the user document to get the driverId
//       UserModel? user = await _userService.fetchUser(userID);
//       if (user == null || user.currentDriverId == null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Please allocate a driver first')),
//         );
//         return;
//       }

//       // Update user's location in Firestore
//       await FirebaseFirestore.instance.collection('users').doc(userID).update({
//         'address': _currentAddress,
//         'latitude': _currentLatLng.latitude,
//         'longitude': _currentLatLng.longitude,
//       });

//       // Call the allocateDriverToStudent method
//       final coordinates = {
//         'latitude': _currentLatLng.latitude,
//         'longitude': _currentLatLng.longitude,
//       };

//       await _locationService
//           .updateStudentLocation(userID, coordinates)
//           .then((value) => print('Location updated'));

//       await _locationService
//           .allocateDriverToStudent(
//             user.currentDriverId!, // Replace with the appropriate driver ID
//             userID,
//             coordinates,
//           )
//           .then((value) => Navigator.pushNamed(context, '/mainNavigation'));

//       // Show success message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Location updated: $_currentAddress')),
//       );
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to update location')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Google Map
//           GoogleMap(
//             myLocationEnabled: true,
//             mapToolbarEnabled: false,
//             initialCameraPosition: CameraPosition(
//               target: _currentLatLng,
//               zoom: 14.0,
//             ),
//             onMapCreated: (controller) {
//               _mapController = controller;
//             },
//             myLocationButtonEnabled: false,
//             onCameraMove: (CameraPosition position) {
//               setState(() {
//                 _isDragging = true;
//                 _currentLatLng = position.target;
//               });
//             },
//             onCameraIdle: () {
//               setState(() {
//                 _isDragging = false;
//               });
//               _updateAddress(_currentLatLng);
//             },
//           ),

//           // Current Location Marker
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.location_on,
//                   size: 50,
//                   color: Colors.red,
//                 ),
//                 const SizedBox(height: 8),
//                 if (!_isDragging)
//                   Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black12,
//                           offset: Offset(0, 4),
//                           blurRadius: 10,
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       _currentAddress,
//                       style: const TextStyle(fontSize: 12),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           // Bottom Section
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     offset: Offset(0, -4),
//                     blurRadius: 10,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Select Your Location",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search for a location',
//                       prefixIcon: const Icon(Icons.search),
//                       filled: true,
//                       fillColor: Colors.grey[100],
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Save Location Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _confirmAndSaveLocation,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF0047BA),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Save Location',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 8),
//                   // Current Location Button
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: _getCurrentLocation,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         side: const BorderSide(color: Color(0xFF0047BA)),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Use Current Location',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF0047BA),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user.dart';
import '../../../services/AuthService.dart';
=======
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e

import '../../../models/user.dart';
import '../../../services/AuthService.dart';
=======

import '../../../models/user.dart';
import '../../../services/AuthService.dart';
=======

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
import '../../../services/LocationService.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController _mapController;
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  // Location states
  LatLng _pickupLatLng =
      const LatLng(25.3791973, 68.3219916); // Default location
  LatLng _dropoffLatLng = const LatLng(0, 0);

  String _pickupAddress = "";
  String _dropoffAddress = "";

  bool _isDragging = false;
  bool _isPickupMode = true;

  String userID = FirebaseAuth.instance.currentUser!.uid;
  final LocationService _locationService = LocationService();
  final UserService _userService = UserService();

  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
<<<<<<< HEAD
=======
=======
  LatLng _currentLatLng = const LatLng(25.3791973, 68.3219916); // Default to SF
<<<<<<< HEAD
  String _currentAddress = "";
=======
  String _currentAddress = "Fetching address...";
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
  bool _isDragging = false;
  String userID =
      FirebaseAuth.instance.currentUser?.uid ?? "ZUXmaewWH9MzkPLL8zPb75TW4T82";
  final LocationService _locationService = LocationService();
<<<<<<< HEAD

  final UserService _userService = UserService();
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
=======
=======
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
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          String formattedAddress = "${place.name ?? ''}, "
                  "${place.locality ?? ''}, "
                  "${place.administrativeArea ?? ''}, "
                  "${place.country ?? ''}"
              .trim();

          if (isPickup) {
            _pickupAddress = formattedAddress;
            _pickupController.text = formattedAddress;
          } else {
            _dropoffAddress = formattedAddress;
            _dropoffController.text = formattedAddress;
          }
<<<<<<< HEAD
=======
=======
          _currentAddress =
              "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        });
      }
    } catch (e) {
      setState(() {
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        if (isPickup) {
          _pickupAddress = "Unable to get address";
          _pickupController.text = "Unable to get address";
        } else {
          _dropoffAddress = "Unable to get address";
          _dropoffController.text = "Unable to get address";
        }
<<<<<<< HEAD
=======
=======
        _currentAddress = "Unable to get address";
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
      });
    }
  }

<<<<<<< HEAD
  void _saveLocation() async {
=======
<<<<<<< HEAD
<<<<<<< HEAD
  void _saveLocation() async {
=======
  void _saveLocation() async {
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
    if (_dropoffLatLng.latitude == 0 && _dropoffLatLng.longitude == 0) {
      _showErrorDialog('Please select a dropoff location');
      return;
    }

    try {
      UserModel? user = await _userService.fetchUser(userID);
<<<<<<< HEAD
      if (user == null) {
        _showErrorDialog('Please allocate a driver first');
=======
<<<<<<< HEAD
      if (user == null) {
        _showErrorDialog('Please allocate a driver first');
=======
  void _confirmAndSaveLocation() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Location'),
          content: const Text('Are you sure you want to update your location?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Dismiss the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _saveLocation();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveLocation() async {
    try {
      // Fetch the user document to get the driverId
      UserModel? user = await _userService.fetchUser(userID);
      if (user == null || user.currentDriverId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please allocate a driver first')),
        );
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
      if (user == null || user.currentDriverId == null) {
        _showErrorDialog('Please allocate a driver first');
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        return;
      }

      // Update user's location in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
        'address': _pickupAddress,
        'pickupLatitude': _pickupLatLng.latitude,
        'pickupLongitude': _pickupLatLng.longitude,
        'dropOffLocation': _dropoffAddress,
        'dropOffLatitude': _dropoffLatLng.latitude,
        'dropOffLongitude': _dropoffLatLng.longitude,
      });

      // Prepare coordinates
      final pickupCoordinates = {
        'latitude': _pickupLatLng.latitude,
        'longitude': _pickupLatLng.longitude,
      };

      final dropoffCoordinates = {
        'latitude': _dropoffLatLng.latitude,
        'longitude': _dropoffLatLng.longitude,
      };

      // Update student location and allocate driver
      await _locationService.updateStudentLocation(userID, pickupCoordinates);
<<<<<<< HEAD

      // await _locationService.allocateDriverToStudent(
      //     user.currentDriverId!, userID, pickupCoordinates, dropoffCoordinates);
=======
<<<<<<< HEAD

      // await _locationService.allocateDriverToStudent(
      //     user.currentDriverId!, userID, pickupCoordinates, dropoffCoordinates);
=======
      await _locationService.allocateDriverToStudent(
          user.currentDriverId!, userID, pickupCoordinates, dropoffCoordinates);
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

      // Navigate to main navigation screen
      Navigator.pushNamed(context, '/mainNavigation');

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

<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
        'address': _currentAddress,
        'latitude': _currentLatLng.latitude,
        'longitude': _currentLatLng.longitude,
      });

      // Call the allocateDriverToStudent method
      final coordinates = {
        'latitude': _currentLatLng.latitude,
        'longitude': _currentLatLng.longitude,
      };

      await _locationService
          .updateStudentLocation(userID, coordinates)
          .then((value) => print('Location updated'));

      await _locationService
          .allocateDriverToStudent(
            user.currentDriverId!, // Replace with the appropriate driver ID
            userID,
            coordinates,
          )
          .then((value) => Navigator.pushNamed(context, '/mainNavigation'));

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location updated: $_currentAddress')),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update location')),
      );
    }
  }

>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
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

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
              target: _pickupLatLng,
=======
<<<<<<< HEAD
              target: _pickupLatLng,
=======
              target: _currentLatLng,
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
              zoom: 14.0,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            myLocationButtonEnabled: false,
            onCameraMove: (CameraPosition position) {
              setState(() {
                _isDragging = true;
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                if (_isPickupMode) {
                  _pickupLatLng = position.target;
                } else {
                  _dropoffLatLng = position.target;
                }
<<<<<<< HEAD
=======
=======
                _currentLatLng = position.target;
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
              });
            },
            onCameraIdle: () {
              setState(() {
                _isDragging = false;
              });
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
              if (_isPickupMode) {
                _updateAddress(_pickupLatLng, isPickup: true);
              } else {
                _updateAddress(_dropoffLatLng, isPickup: false);
              }
            },
          ),

          // Location Marker
<<<<<<< HEAD
=======
=======
              _updateAddress(_currentLatLng);
            },
          ),

          // Current Location Marker
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                Icon(
                  Icons.location_on,
                  size: 50,
                  color: _isPickupMode ? Colors.green : Colors.red,
<<<<<<< HEAD
=======
=======
                const Icon(
                  Icons.location_on,
                  size: 50,
                  color: Colors.red,
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                ),
                const SizedBox(height: 8),
                if (!_isDragging)
                  Container(
<<<<<<< HEAD
                    margin: const EdgeInsets.symmetric(horizontal: 20),
=======
<<<<<<< HEAD
                    margin: const EdgeInsets.symmetric(horizontal: 20),
=======
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
<<<<<<< HEAD
                      boxShadow: const [
=======
<<<<<<< HEAD
                      boxShadow: const [
=======
<<<<<<< HEAD
                      boxShadow: const [
=======
                      boxShadow: [
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                      _isPickupMode ? _pickupAddress : _dropoffAddress,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
<<<<<<< HEAD
=======
=======
                      _currentAddress,
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                    ),
                  ),
              ],
            ),
          ),

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
<<<<<<< HEAD
=======
=======
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
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                  ),
                ],
              ),
              child: Column(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Dropoff Location
                  TextField(
                    readOnly: true,
                    controller: _dropoffController,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.location_on, color: Colors.red),
                      hintText: 'Dropoff Location',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _isPickupMode = false;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // Confirm Button
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveLocation,
<<<<<<< HEAD
=======
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
=======
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
<<<<<<< HEAD
                  // Save Location Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirmAndSaveLocation,
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======

                  // Save Location Button
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveLocation,
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Confirm Route',
<<<<<<< HEAD
=======
=======
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Save Location',
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======

                  const SizedBox(height: 8),
<<<<<<< HEAD
=======

>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
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
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
