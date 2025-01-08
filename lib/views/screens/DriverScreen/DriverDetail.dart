<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously
=======
<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously
=======
<<<<<<< HEAD
// ignore_for_file: use_build_context_synchronously
=======
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/driverService.dart';

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  _DriverDetailsScreenState createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _areaController = TextEditingController();
  int _seats = 4;
  final List<String> _areas = [];
  final List<String> _selectedAreas = [];

  final DriverService _driverService = DriverService();
  String userID = FirebaseAuth.instance.currentUser!.uid;

  void _submitDriverDetails() async {
    if (_formKey.currentState!.validate() && _selectedAreas.isNotEmpty) {
      final driverData = {
        "name": _nameController.text,
        "age": int.parse(_ageController.text),
        "phone": _phoneController.text,
        "vehicleNumber": _vehicleNumberController.text,
        "seats": _seats,
        "areas": _selectedAreas,
        "isActive": true,
      };

      try {
        await _driverService.addDriver(userID, driverData);
        //navigate to home screen
        Navigator.pushNamed(context, '/driverHome');
        _showMessage("Driver details saved successfully!");
      } catch (e) {
        _showMessage("Error saving driver details: $e");
      }
    } else {
      _showMessage("Please fill all fields and select at least one area.");
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final screenSize = MediaQuery.of(context).size;
=======
<<<<<<< HEAD
    final screenSize = MediaQuery.of(context).size;
=======
<<<<<<< HEAD
    final screenSize = MediaQuery.of(context).size;
=======
<<<<<<< HEAD
    final screenSize = MediaQuery.of(context).size;
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
    return Scaffold(
      appBar: AppBar(
        //back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back),
<<<<<<< HEAD
          onPressed: () {},
=======
<<<<<<< HEAD
          onPressed: () {},
=======
<<<<<<< HEAD
          onPressed: () {},
=======
<<<<<<< HEAD
          onPressed: () {},
=======
          onPressed: () {
            Navigator.pop(context);
          },
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
<<<<<<< HEAD
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
=======
<<<<<<< HEAD
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
=======
<<<<<<< HEAD
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
=======
<<<<<<< HEAD
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
=======
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Driver Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.02),
=======
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.02),
=======
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.02),
=======
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.02),
=======
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: Icons.person_outline,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Full Name is required.';
                      } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                        return 'Name must only contain alphabets.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.02),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  _buildTextField(
                    controller: _ageController,
                    label: 'Age',
                    icon: Icons.cake_outlined,
                    keyboardType: TextInputType.number,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Age is required.';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 18 || age > 65) {
                        return 'Age must be between 18 and 65.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.02),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone Number is required.';
                      } else if (!RegExp(r"^\+?\d{10,15}$").hasMatch(value)) {
                        return 'Enter a valid phone number.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.02),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  _buildTextField(
                    controller: _vehicleNumberController,
                    label: 'Vehicle Number',
                    icon: Icons.directions_car_outlined,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Vehicle Number is required.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: screenSize.height * 0.02),
                  _buildSeatCounter(),
                  SizedBox(height: screenSize.height * 0.02),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
                  _buildSeatCounter(),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  const Text(
                    "Preferred Areas/Schools",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  SizedBox(height: screenSize.height * 0.02),
                  _buildAreaInputField(),
                  SizedBox(height: screenSize.height * 0.02),
                  _buildAreaTags(),
                  SizedBox(height: screenSize.height * 0.04),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                  const SizedBox(height: 16),
                  _buildAreaInputField(),
                  const SizedBox(height: 16),
                  _buildAreaTags(),
                  const SizedBox(height: 32),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  ElevatedButton(
                    onPressed: _submitDriverDetails,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 71, 186),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Finish",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.04),
=======
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.04),
=======
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.04),
=======
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.04),
=======
                  const SizedBox(height: 32),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeatCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Number of Seats:",
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (_seats > 8) {
                  setState(() {
                    _seats--;
                  });
                }
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              _seats.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            IconButton(
              onPressed: () {
                if (_seats < 12) {
                  setState(() {
                    _seats++;
                  });
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
<<<<<<< HEAD
    required String? Function(String?) validator,
=======
<<<<<<< HEAD
    required String? Function(String?) validator,
=======
<<<<<<< HEAD
    required String? Function(String?) validator,
=======
<<<<<<< HEAD
    required String? Function(String?) validator,
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
<<<<<<< HEAD
      validator: validator,
=======
<<<<<<< HEAD
      validator: validator,
=======
<<<<<<< HEAD
      validator: validator,
=======
<<<<<<< HEAD
      validator: validator,
=======
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
    );
  }

  Widget _buildAreaInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _areaController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: "Add a new area or school",
              hintStyle: TextStyle(color: Colors.grey[600]),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: () {
            final newArea = _areaController.text.trim();
            if (newArea.isNotEmpty && !_areas.contains(newArea)) {
              setState(() {
                _areas.add(newArea);
                _areaController.clear();
              });
            } else {
              _showMessage("Area already exists or input is empty.");
            }
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(15),
            backgroundColor: const Color.fromARGB(255, 0, 71, 186),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildAreaTags() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: _areas.map((area) {
        final isSelected = _selectedAreas.contains(area);
        return FilterChip(
          label: Text(area),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedAreas.add(area);
              } else {
                _selectedAreas.remove(area);
              }
            });
          },
          selectedColor: Colors.blue.shade100,
          checkmarkColor: Colors.black,
        );
      }).toList(),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
