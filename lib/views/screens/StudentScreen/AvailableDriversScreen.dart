import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/driver.dart';
import '../../../services/driverService.dart';

class AvailableDriversScreen extends StatefulWidget {
  const AvailableDriversScreen({Key? key}) : super(key: key);

  @override
  _AvailableDriversScreenState createState() => _AvailableDriversScreenState();
}

class _AvailableDriversScreenState extends State<AvailableDriversScreen> {
  String selectedArea = 'All Areas';
  final List<String> areas = [
    'All Areas',
    'North Campus',
    'South Campus',
    'City Center'
  ];

  // Sample drivers data
  // List<Driver> drivers = [
  //   Driver(
  //     driverID: 'D001',
  //     name: 'John Smith',
  //     age: 35,
  //     phone: '+1 (555) 123-4567',
  //     drivingLicenseNumber: 'DL12345678',
  //     rating: 4.8,
  //     seats: 12,
  //     userID: 'U001',
  //     monthlyFee: 150,
  //     vehicleNumber: 'VAN-123',
  //     areas: ['North Campus', 'City Center'],
  //   ),
  //   Driver(
  //     driverID: 'D002',
  //     name: 'Sarah Wilson',
  //     age: 32,
  //     phone: '+1 (555) 987-6543',
  //     drivingLicenseNumber: 'DL87654321',
  //     rating: 4.9,
  //     seats: 8,
  //     userID: 'U002',
  //     monthlyFee: 140,
  //     vehicleNumber: 'VAN-456',
  //     areas: ['South Campus', 'City Center'],
  //   ),
  //   // Add more sample drivers as needed
  // ];

  final DriverService _driverService = DriverService();
  List<Driver> drivers = [];

  Future<void> _loadDrivers() async {
    try {
      final driverData = await _driverService.fetchAllDrivers();
      setState(() {
        drivers = driverData.map((data) => Driver.fromMap(data)).toList();
        print(drivers);
      });
    } catch (e) {
      print('Error loading drivers: $e');
    }
  }

  @override
  void initState() {
    _loadDrivers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Available Drivers',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search drivers...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: Color(0xFF0047BA), width: 2),
                ),
              ),
            ),
          ),
          // Area Filter
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: areas.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(areas[index]),
                    selected: selectedArea == areas[index],
                    onSelected: (bool selected) {
                      setState(() {
                        selectedArea = areas[index];
                      });
                    },
                    backgroundColor: Colors.grey[50],
                    selectedColor: const Color(0xFF0047BA).withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: selectedArea == areas[index]
                          ? const Color(0xFF0047BA)
                          : Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: selectedArea == areas[index]
                            ? const Color(0xFF0047BA)
                            : Colors.grey[300]!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Drivers List
          Container(
            height: MediaQuery.of(context).size.height - 250,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final driver = drivers[index];
                print(drivers.length);
                if (drivers.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return _buildDriverCard(driver);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverCard(Driver driver) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(Icons.person, size: 35, color: Colors.grey),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driver.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        driver.vehicleNumber,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          Text(
                            ' ${driver.rating}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.airline_seat_recline_normal,
                              size: 16, color: Colors.grey[600]),
                          Text(
                            ' ${driver.seats} seats',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${driver.monthlyFee}/mo',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0047BA),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: driver.areas.map((area) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    area,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    // Handle call action
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text('Call'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF0047BA),
                    side: const BorderSide(color: Color(0xFF0047BA)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String userid = FirebaseAuth.instance.currentUser!.uid;
                      print("current user id: $userid");
                      print("available driver id: ${driver.driverID}");
                      await _driverService
                          .bookDriver(userid, driver.driverID)
                          .then((value) => print("Driver booked"));
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/mainNavigation", (route) => false);
                    } catch (e) {
                      print(e);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0047BA),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
