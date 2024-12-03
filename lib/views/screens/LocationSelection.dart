// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class UberMapScreen extends StatefulWidget {
//   @override
//   _UberMapScreenState createState() => _UberMapScreenState();
// }

// class _UberMapScreenState extends State<UberMapScreen> {
//   GoogleMapController? _controller;
//   LatLng? _pickedLocation;
//   LatLng _initialLocation = LatLng(37.7749, -122.4194); // San Francisco, CA
//   List<String> customerAddresses = [
//     "Customer 1: 123 Main St",
//     "Customer 2: 456 Elm St"
//   ];

//   Location _location = Location();
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializeLocation();
//   }

//   Future<void> _initializeLocation() async {
//     final locData = await _location.getLocation();
//     setState(() {
//       _initialLocation = LatLng(locData.latitude!, locData.longitude!);
//       _isLoading = false;
//     });
//   }

//   void _onMapTap(LatLng location) {
//     setState(() {
//       _pickedLocation = location;
//     });
//   }

//   void _confirmLocation() {
//     if (_pickedLocation != null) {
//       final latitude = _pickedLocation!.latitude;
//       final longitude = _pickedLocation!.longitude;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Location Confirmed: ($latitude, $longitude)")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select a location on the map.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Pick Location"),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 if (_isLoading)
//                   Center(child: CircularProgressIndicator())
//                 else
//                   GoogleMap(
//                     initialCameraPosition: CameraPosition(
//                       target: _initialLocation,
//                       zoom: 14,
//                     ),
//                     onMapCreated: (controller) => _controller = controller,
//                     onTap: _onMapTap,
//                     markers: {
//                       if (_pickedLocation != null)
//                         Marker(
//                           markerId: MarkerId("picked-location"),
//                           position: _pickedLocation!,
//                         ),
//                     },
//                   ),
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: FloatingActionButton(
//                     child: Icon(Icons.my_location),
//                     onPressed: () async {
//                       final locData = await _location.getLocation();
//                       _controller?.animateCamera(
//                         CameraUpdate.newLatLng(
//                           LatLng(locData.latitude!, locData.longitude!),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: customerAddresses.length,
//                   itemBuilder: (ctx, index) {
//                     return ListTile(
//                       title: Text(customerAddresses[index]),
//                     );
//                   },
//                 ),
//                 ElevatedButton(
//                   onPressed: _confirmLocation,
//                   child: Text("Confirm Your Location"),
//                 ),
//               ],
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
import 'dart:async';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition? _initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Fetch and Set the current location when the app starts
  }

  // Fetch the current location
  Future<void> _getCurrentLocation() async {
    try {
      // Determine current position
      _currentPosition = await Geolocator.getCurrentPosition();

      // Set the initial camera position to the current location
      setState(() {
        _initialCameraPosition = CameraPosition(
          target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          zoom: 14.4746,
        );
      });
    } catch (e) {
      print("Error fetching current location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps Example"),
      ),
      body: _initialCameraPosition == null
          ? const Center(
              child: CircularProgressIndicator()) // Show loading spinner
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialCameraPosition!,
              myLocationEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToCurrentLocation,
        label: const Text('Current Location'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }

  // Move camera to the current location when the button is pressed
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    _currentPosition = await Geolocator.getCurrentPosition();
    CameraPosition currentLocation = CameraPosition(
      target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      zoom: 14.4746,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(currentLocation));
  }
}
