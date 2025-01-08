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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/user.dart';
import '../../../services/AuthService.dart';
import '../../../services/LocationService.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({Key? key}) : super(key: key);

  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController _mapController;

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

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
            _dropoffAddress = formattedAddress;
            _dropoffController.text = formattedAddress;
          }
        });
      }
    } catch (e) {
      setState(() {
        if (isPickup) {
          _pickupAddress = "Unable to get address";
          _pickupController.text = "Unable to get address";
        } else {
          _dropoffAddress = "Unable to get address";
          _dropoffController.text = "Unable to get address";
        }
      });
    }
  }

  void _saveLocation() async {
    if (_dropoffLatLng.latitude == 0 && _dropoffLatLng.longitude == 0) {
      _showErrorDialog('Please select a dropoff location');
      return;
    }

    try {
      UserModel? user = await _userService.fetchUser(userID);
      if (user == null) {
        _showErrorDialog('Please allocate a driver first');
        return;
      }

      // Update user's location in Firestore
      await FirebaseFirestore.instance.collection('users').doc(userID).update({
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
      // Update student location and allocate driver
      await _locationService.updateStudentLocation(userID, pickupCoordinates);

      // await _locationService.allocateDriverToStudent(
      //     user.currentDriverId!, userID, pickupCoordinates, dropoffCoordinates);

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
                  _dropoffLatLng = position.target;
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
                      _isPickupMode ? _pickupAddress : _dropoffAddress,
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveLocation,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA),
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
