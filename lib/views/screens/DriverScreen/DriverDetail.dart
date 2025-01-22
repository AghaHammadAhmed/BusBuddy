<<<<<<< HEAD
// // ignore_for_file: use_build_context_synchronously
// import 'package:busbuddy/views/screens/DriverScreen/DriverPickUpLocation.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../../services/driverService.dart';

// class DriverDetailsScreen extends StatefulWidget {
//   const DriverDetailsScreen({super.key});

//   @override
//   _DriverDetailsScreenState createState() => _DriverDetailsScreenState();
// }

// class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Form controllers
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _vehicleNumberController = TextEditingController();
//   final _areaController = TextEditingController();
//   int _seats = 4;
//   final List<String> _areas = [];
//   final List<String> _selectedAreas = [];

//   final DriverService _driverService = DriverService();
//   String userID = FirebaseAuth.instance.currentUser!.uid;

//   void _submitDriverDetails() async {
//     if (_formKey.currentState!.validate() && _selectedAreas.isNotEmpty) {
//       final driverData = {
//         "name": _nameController.text,
//         "age": int.parse(_ageController.text),
//         "phone": _phoneController.text,
//         "vehicleNumber": _vehicleNumberController.text,
//         "seats": _seats,
//         "areas": _selectedAreas,
//         "isActive": true,
//       };

//       try {
//         await _driverService.addDriver(userID, driverData);
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (_) => const DriverPickUpLocation(),
//         ));
//         _showMessage("Driver details saved successfully!");
//       } catch (e) {
//         _showMessage("Error saving driver details: $e");
//       }
//     } else {
//       _showMessage("Please fill all fields and select at least one area.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         //back button
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           color: Colors.black,
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Spacer(),
//                 const Text(
//                   'Driver Details',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _nameController,
//                   label: 'Full Name',
//                   icon: Icons.person_outline,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Full Name is required.';
//                     } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
//                       return 'Name must only contain alphabets.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _ageController,
//                   label: 'Age',
//                   icon: Icons.cake_outlined,
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Age is required.';
//                     }
//                     final age = int.tryParse(value);
//                     if (age == null || age < 18 || age > 65) {
//                       return 'Age must be between 18 and 65.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _phoneController,
//                   label: 'Phone Number',
//                   icon: Icons.phone_outlined,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Phone Number is required.';
//                     } else if (!RegExp(r"^\+?\d{10,15}$").hasMatch(value)) {
//                       return 'Enter a valid phone number.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _vehicleNumberController,
//                   label: 'Vehicle Number',
//                   icon: Icons.directions_car_outlined,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Vehicle Number is required.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildSeatCounter(),
//                 SizedBox(height: screenSize.height * 0.02),
//                 ElevatedButton(
//                   onPressed: _submitDriverDetails,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 0, 71, 186),
//                     foregroundColor: Colors.white,
//                     minimumSize: const Size(double.infinity, 54),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Finish",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSeatCounter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           "Number of Seats:",
//           style: TextStyle(fontSize: 16),
//         ),
//         Row(
//           children: [
//             IconButton(
//               onPressed: () {
//                 if (_seats > 8) {
//                   setState(() {
//                     _seats--;
//                   });
//                 }
//               },
//               icon: const Icon(Icons.remove),
//             ),
//             Text(
//               _seats.toString(),
//               style: const TextStyle(fontSize: 16),
//             ),
//             IconButton(
//               onPressed: () {
//                 if (_seats < 12) {
//                   setState(() {
//                     _seats++;
//                   });
//                 }
//               },
//               icon: const Icon(Icons.add),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     required String? Function(String?) validator,
//     bool isPassword = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[600]),
//         prefixIcon: Icon(icon, color: Colors.grey[600]),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.black, width: 2),
//         ),
//         filled: true,
//         fillColor: Colors.grey[50],
//       ),
//       validator: validator,
//     );
//   }

//   Widget _buildAreaInputField() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _areaController,
//             style: const TextStyle(color: Colors.black),
//             decoration: InputDecoration(
//               hintText: "Add a new area or school",
//               hintStyle: TextStyle(color: Colors.grey[600]),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(color: Colors.black, width: 2),
//               ),
//               filled: true,
//               fillColor: Colors.grey[50],
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         ElevatedButton(
//           onPressed: () {
//             final newArea = _areaController.text.trim();
//             if (newArea.isNotEmpty && !_areas.contains(newArea)) {
//               setState(() {
//                 _areas.add(newArea);
//                 _areaController.clear();
//               });
//             } else {
//               _showMessage("Area already exists or input is empty.");
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             shape: const CircleBorder(),
//             padding: const EdgeInsets.all(15),
//             backgroundColor: const Color.fromARGB(255, 0, 71, 186),
//           ),
//           child: const Icon(Icons.add, color: Colors.white),
//         ),
//       ],
//     );
//   }

//   Widget _buildAreaTags() {
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: _areas.map((area) {
//         final isSelected = _selectedAreas.contains(area);
//         return FilterChip(
//           label: Text(area),
//           selected: isSelected,
//           onSelected: (selected) {
//             setState(() {
//               if (selected) {
//                 _selectedAreas.add(area);
//               } else {
//                 _selectedAreas.remove(area);
//               }
//             });
//           },
//           selectedColor: Colors.blue.shade100,
//           checkmarkColor: Colors.black,
//         );
//       }).toList(),
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }
// }

// // ignore_for_file: use_build_context_synchronously
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../services/driverService.dart';
// import 'DriverPickUpLocation.dart';

// class DriverDetailsScreen extends StatefulWidget {
//   const DriverDetailsScreen({super.key});

//   @override
//   _DriverDetailsScreenState createState() => _DriverDetailsScreenState();
// }

// class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _vehicleNumberController = TextEditingController();
//   final _areaController = TextEditingController();
//   int _seats = 4;
//   final List<String> _areas = [];
//   final List<String> _selectedAreas = [];
//   final DriverService _driverService = DriverService();
//   String userID = FirebaseAuth.instance.currentUser!.uid;

//   void _submitDriverDetails() async {
//     if (_formKey.currentState!.validate() && _selectedAreas.isNotEmpty) {
//       final driverData = {
//         "name": _nameController.text,
//         "age": int.parse(_ageController.text),
//         "phone": _phoneController.text,
//         "vehicleNumber": _vehicleNumberController.text,
//         "seats": _seats,
//         "areas": _selectedAreas,
//         "isActive": true,
//       };

//       try {
//         await _driverService.addDriver(userID, driverData);
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (_) => const DriverPickUpLocation(),
//         ));
//         _showMessage("Driver details saved successfully!");
//       } catch (e) {
//         _showMessage("Error saving driver details: $e");
//       }
//     } else {
//       _showMessage("Please fill all fields and select at least one area.");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: screenSize.height * 0.05),
//                 Center(
//                   child: Text(
//                     "Driver Details",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF8A1538),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _nameController,
//                   label: 'Full Name',
//                   icon: Icons.person_outline,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Full Name is required.';
//                     } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
//                       return 'Name must only contain alphabets.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _ageController,
//                   label: 'Age',
//                   icon: Icons.cake_outlined,
//                   keyboardType: TextInputType.number,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Age is required.';
//                     }
//                     final age = int.tryParse(value);
//                     if (age == null || age < 18 || age > 65) {
//                       return 'Age must be between 18 and 65.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _phoneController,
//                   label: 'Phone Number',
//                   icon: Icons.phone_outlined,
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Phone Number is required.';
//                     } else if (!RegExp(r"^\+?\d{10,15}$").hasMatch(value)) {
//                       return 'Enter a valid phone number.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildTextField(
//                   controller: _vehicleNumberController,
//                   label: 'Vehicle Number',
//                   icon: Icons.directions_car_outlined,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Vehicle Number is required.';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildSeatCounter(),
//                 SizedBox(height: screenSize.height * 0.02),
//                 const Text(
//                   "Preferred Areas/Schools",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildAreaInputField(),
//                 SizedBox(height: screenSize.height * 0.02),
//                 _buildAreaTags(),
//                 SizedBox(height: screenSize.height * 0.04),
//                 ElevatedButton(
//                   onPressed: _submitDriverDetails,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF8A1538),
//                     foregroundColor: Colors.white,
//                     minimumSize: const Size(double.infinity, 54),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Finish",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(height: screenSize.height * 0.04),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSeatCounter() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           "Number of Seats:",
//           style: TextStyle(fontSize: 16),
//         ),
//         Row(
//           children: [
//             IconButton(
//               onPressed: () {
//                 if (_seats > 8) {
//                   setState(() {
//                     _seats--;
//                   });
//                 }
//               },
//               icon: const Icon(Icons.remove),
//             ),
//             Text(
//               _seats.toString(),
//               style: const TextStyle(fontSize: 16),
//             ),
//             IconButton(
//               onPressed: () {
//                 if (_seats < 12) {
//                   setState(() {
//                     _seats++;
//                   });
//                 }
//               },
//               icon: const Icon(Icons.add),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     required String? Function(String?) validator,
//     bool isPassword = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       keyboardType: keyboardType,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         labelText: label,
//         prefixIcon: Icon(icon, color: Colors.grey[600]),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey[300]!),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Colors.black, width: 2),
//         ),
//       ),
//       validator: validator,
//     );
//   }

//   Widget _buildAreaInputField() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: _areaController,
//             decoration: InputDecoration(
//               hintText: "Add a new area or school",
//               prefixIcon: const Icon(Icons.location_on_outlined),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey[300]!),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(color: Colors.black, width: 2),
//               ),
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             final newArea = _areaController.text.trim();
//             if (newArea.isNotEmpty && !_areas.contains(newArea)) {
//               setState(() {
//                 _areas.add(newArea);
//                 _areaController.clear();
//               });
//             } else {
//               _showMessage("Area already exists or input is empty.");
//             }
//           },
//           child: const Icon(Icons.add),
//         ),
//       ],
//     );
//   }

//   Widget _buildAreaTags() {
//     return Wrap(
//       spacing: 8.0,
//       runSpacing: 8.0,
//       children: _areas.map((area) {
//         final isSelected = _selectedAreas.contains(area);
//         return FilterChip(
//           label: Text(area),
//           selected: isSelected,
//           onSelected: (selected) {
//             setState(() {
//               if (selected) {
//                 _selectedAreas.add(area);
//               } else {
//                 _selectedAreas.remove(area);
//               }
//             });
//           },
//         );
//       }).toList(),
//     );
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../services/driverService.dart';
import 'DriverPickUpLocation.dart';
=======
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
// ignore_for_file: use_build_context_synchronously
=======
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../services/driverService.dart';
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e

class DriverDetailsScreen extends StatefulWidget {
  const DriverDetailsScreen({super.key});

  @override
  _DriverDetailsScreenState createState() => _DriverDetailsScreenState();
}

class _DriverDetailsScreenState extends State<DriverDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
=======

  // Form controllers
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _vehicleNumberController = TextEditingController();
  final _areaController = TextEditingController();
  int _seats = 4;
  final List<String> _areas = [];
<<<<<<< HEAD
  // final List<String> _selectedAreas = [];
  final DriverService _driverService = DriverService();
  String userID = FirebaseAuth.instance.currentUser!.uid;
  bool _isLoading = false;
  String? _selectedSchool;

  void _submitDriverDetails() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
=======
  final List<String> _selectedAreas = [];

  final DriverService _driverService = DriverService();
  String userID = FirebaseAuth.instance.currentUser!.uid;

  void _submitDriverDetails() async {
    if (_formKey.currentState!.validate() && _selectedAreas.isNotEmpty) {
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      final driverData = {
        "name": _nameController.text,
        "age": int.parse(_ageController.text),
        "phone": _phoneController.text,
        "vehicleNumber": _vehicleNumberController.text,
        "seats": _seats,
<<<<<<< HEAD
        // "areas": _selectedAreas,
        "isActive": true,
        "school": _selectedSchool,
=======
        "areas": _selectedAreas,
        "isActive": true,
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      };

      try {
        await _driverService.addDriver(userID, driverData);
<<<<<<< HEAD
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => const DriverPickUpLocation(),
        ));
=======
        //navigate to home screen
        Navigator.pushNamed(context, '/driverHome');
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
        _showMessage("Driver details saved successfully!");
      } catch (e) {
        _showMessage("Error saving driver details: $e");
      }
<<<<<<< HEAD
      setState(() => _isLoading = false);
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
    } else {
      _showMessage("Please fill all fields and select at least one area.");
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF8A1538),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Driver Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Fill in the required details below",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Full Name is required.';
                    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
                      return 'Name must only contain alphabets.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _ageController,
                  label: 'Age',
                  icon: Icons.cake_outlined,
                  keyboardType: TextInputType.number,
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
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Phone Number is required.';
                    } else if (!RegExp(r"^\+?\d{10,15}$").hasMatch(value)) {
                      return 'Enter a valid phone number.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _vehicleNumberController,
                  label: 'Vehicle Number',
                  icon: Icons.directions_car_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vehicle Number is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildSeatCounter(),
                const SizedBox(height: 16),
                _buildSchoolDropdown(),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
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
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
=======
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.02),
=======
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
=======
=======
                  ),
                  const SizedBox(height: 16),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
<<<<<<< HEAD
                  SizedBox(height: screenSize.height * 0.04),
=======
                  const SizedBox(height: 32),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                ],
              ),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
            ),
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildSchoolDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSchool,
      onChanged: (value) {
        setState(() {
          _selectedSchool = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a School/Collage';
        }
        return null;
      },
      dropdownColor: const Color(0xFF8A1538),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Select School/Collage',
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon:
            const Icon(Icons.account_circle_outlined, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF8A1538),
      ),
      items: const [
        DropdownMenuItem(value: 'the educators', child: Text('The Educators')),
        DropdownMenuItem(value: 'beaconhouse', child: Text('Beaconhouse')),
        DropdownMenuItem(value: 'lgs', child: Text('LGS')),
        DropdownMenuItem(value: 'roots', child: Text('Roots')),
        DropdownMenuItem(value: 'city school', child: Text('City School')),
        DropdownMenuItem(value: 'pak turk', child: Text('Pak Turk')),
        DropdownMenuItem(
            value: 'karachi grammar', child: Text('Karachi Grammar')),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType? keyboardType,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        filled: true,
        fillColor: const Color(0xFF8A1538),
      ),
      validator: validator,
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submitDriverDetails,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8A1538),
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Color(0xFF8A1538))
          : const Text(
              "Submit",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  Widget _buildSeatCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Number of Seats:",
<<<<<<< HEAD
          style: TextStyle(fontSize: 16, color: Colors.white),
=======
          style: TextStyle(fontSize: 16),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
<<<<<<< HEAD
                if (_seats > 1) {
=======
                if (_seats > 8) {
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                  setState(() {
                    _seats--;
                  });
                }
              },
<<<<<<< HEAD
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            Text(
              _seats.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.white),
=======
              icon: const Icon(Icons.remove),
            ),
            Text(
              _seats.toString(),
              style: const TextStyle(fontSize: 16),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
            ),
            IconButton(
              onPressed: () {
                if (_seats < 12) {
                  setState(() {
                    _seats++;
                  });
                }
              },
<<<<<<< HEAD
              icon: const Icon(Icons.add, color: Colors.white),
=======
              icon: const Icon(Icons.add),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
            ),
          ],
        ),
      ],
    );
  }

<<<<<<< HEAD
=======
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
<<<<<<< HEAD
    required String? Function(String?) validator,
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
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
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
    );
  }

>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  Widget _buildAreaInputField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _areaController,
<<<<<<< HEAD
            decoration: InputDecoration(
              hintText: "Add a new area or school",
              hintStyle: const TextStyle(color: Colors.white70),
              prefixIcon:
                  const Icon(Icons.location_on_outlined, color: Colors.white70),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white70),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white, width: 2),
              ),
              filled: true,
              fillColor: const Color(0xFF8A1538),
            ),
          ),
        ),
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
        ElevatedButton(
          onPressed: () {
            final newArea = _areaController.text.trim();
            if (newArea.isNotEmpty && !_areas.contains(newArea)) {
              setState(() {
                _areas.add(newArea);
                _areaController.clear();
              });
<<<<<<< HEAD
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF8A1538),
          ),
          child: const Icon(Icons.add),
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
        ),
      ],
    );
  }

<<<<<<< HEAD
  // Widget _buildAreaTags() {
  //   return Wrap(
  //     spacing: 8.0,
  //     runSpacing: 8.0,
  //     children: _areas.map((area) {
  //       final isSelected = _selectedAreas.contains(area);
  //       return FilterChip(
  //         label: Text(area, style: const TextStyle(color: Colors.white)),
  //         backgroundColor: const Color(0xFF8A1538),
  //         selectedColor: Colors.white,
  //         selected: isSelected,
  //         onSelected: (selected) {
  //           setState(() {
  //             if (selected) {
  //               _selectedAreas.add(area);
  //             } else {
  //               _selectedAreas.remove(area);
  //             }
  //           });
  //         },
  //       );
  //     }).toList(),
  //   );
  // }
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
<<<<<<< HEAD

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _vehicleNumberController.dispose();
    _areaController.dispose();
    super.dispose();
  }
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
}
