import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import 'DriverMapView.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final List<Map<String, dynamic>> _rides = [
    {
      'studentName': 'Zainab Ghani',
      'pickupLocation': 'Perfume chowk',
      'destination': 'ABC School',
      'time': '7:30 AM',
      'status': 'Scheduled'
    },
    {
      'studentName': 'Virat Kholi',
      'pickupLocation': 'Anda mor',
      'destination': 'XYZ School',
      'time': '8:00 AM',
      'status': 'Completed'
    },
  ];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth userCredential = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadDriver();
  }

  Driver? _driver; // Driver instance
  bool _isLoading = true; // Loading state

  Future<Driver?> _fetchDriverByUserId() async {
    try {
      QuerySnapshot<Map<String, dynamic>> driverQuery = await _firestore
          .collection('drivers')
          .where('userID', isEqualTo: userCredential.currentUser!.uid)
          .limit(1) // Fetch only one document
          .get();

      if (driverQuery.docs.isNotEmpty) {
        final driverData = driverQuery.docs.first.data();
        print("Driver fetched: ${driverData}");
        return Driver.fromJson(driverData); // Convert to Driver object
      }
      print("No driver found.");
      return null; // No driver found
    } catch (e) {
      print("Failed to fetch driver: $e");
      return null;
    }
  }

  Future<void> _loadDriver() async {
    try {
      Driver? fetchedDriver = await _fetchDriverByUserId();
      setState(() {
        _driver = fetchedDriver;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 50,
        elevation: 0,
        //menu icon button
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Navigate to menu screen
          },
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Navigate to notifications screen
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _driver == null
              ? const Center(child: Text('No driver found.'))
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_isLoading) ...[
                            const LinearProgressIndicator(),
                            const SizedBox(height: 8),
                          ],
                          _buildProfileSection(_driver!),
                          const SizedBox(height: 20),
                          _buildRidesSection(),
                          const SizedBox(height: 20),
                          _buildManageSection(),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  Widget _buildProfileSection(Driver driver) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driver.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '${driver.rating} Rating',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Vehicle: ${driver.vehicleNumber}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRidesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Rides',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _rides.length,
          itemBuilder: (context, index) {
            final ride = _rides[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                leading: const Icon(Icons.directions_bus, color: Colors.blue),
                title: Text(
                  ride['studentName'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pickup: ${ride['pickupLocation']}'),
                    Text('Drop: ${ride['destination']}'),
                    Text('Time: ${ride['time']}'),
                  ],
                ),
                trailing: Text(
                  ride['status'],
                  style: TextStyle(
                    fontSize: 12,
                    color: ride['status'] == 'Completed'
                        ? Colors.green
                        : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Navigate to ride details screen
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildManageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Manage',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildManageCard(
              icon: Icons.map_outlined,
              label: 'Map View',
              onTap: () {
                // Navigate to map screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DriverLiveLocation(
                            driverId: _driver!.driverID,
                            )));
              },
            ),
            _buildManageCard(
              icon: Icons.schedule_outlined,
              label: 'Schedule',
              onTap: () {
                // Navigate to schedule screen
              },
            ),
            _buildManageCard(
              icon: Icons.message_outlined,
              label: 'Messages',
              onTap: () {
                // Navigate to message screen
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildManageCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
