<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
// // import 'dart:convert';

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // import '../../../models/user.dart';
// // import '../../../services/AuthService.dart';

// // class EditProfileScreen extends StatefulWidget {
// //   const EditProfileScreen({Key? key}) : super(key: key);

// //   @override
// //   _EditProfileScreenState createState() => _EditProfileScreenState();
// // }

// // class _EditProfileScreenState extends State<EditProfileScreen> {
// //   final _formKey = GlobalKey<FormState>();

// //   // Form controllers
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _schoolController = TextEditingController();
// //   final _addressController = TextEditingController();

// //   final UserService _userService = UserService();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   String? _profilePictureBase64;
// //   @override
// //   void initState() {
// //     super.initState();

// //     _schoolController.text = "University of Example";
// //     // _addressController.text = "123 Student Street, City";
// //     _loadProfile();
// //   }

// //   Future<void> _loadProfile() async {
// //     try {
// //       final userID = _auth.currentUser!.uid;
// //       UserModel? user = await _userService.fetchUser(userID);
// //       if (user != null) {
// //         _nameController.text = user.name;
// //         _emailController.text = user.email;
// //         _phoneController.text = user.phone;
// //         // _schoolController.text = user.school;
// //         _addressController.text = user.address!;
// //       }

// //     } catch (e) {
// //       print(e);
// //     }
// //   }

// //   Future<void> _updateProfilePicture() async {
// //     try {
// //       final userID = _auth.currentUser!.uid;

// //       print("Profile picture uploaded successfully");

// //     } catch (e) {
// //       print("Error updating profile picture: $e");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.black),
// //           onPressed: () {},
// //         ),
// //         title: const Text(
// //           'Edit Profile',
// //           style: TextStyle(
// //             color: Colors.black,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           child: Padding(
// //             padding:
// //                 const EdgeInsets.symmetric(horizontal: 24.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [
// //                 const SizedBox(height: 20),
// //                 // Profile Picture Section
// //                 Stack(
// //                   alignment: Alignment.center,
// //                   children: [
// //                     CircleAvatar(
// //                       radius: 60,
// //                       backgroundColor: Colors.grey[200],
// //                       backgroundImage: _profilePictureBase64 != null
// //                           ? MemoryImage(base64Decode(_profilePictureBase64!))
// //                           : null,
// //                       child: _profilePictureBase64 == null
// //                           ? const Icon(
// //                               Icons.person,
// //                               size: 60,
// //                               color: Colors.grey,
// //                             )
// //                           : null,
// //                     ),
// //                     Positioned(
// //                       bottom: 0,
// //                       right: 0,
// //                       child: GestureDetector(
// //                         onTap: _updateProfilePicture,
// //                         child: Container(
// //                           padding: const EdgeInsets.all(4),
// //                           decoration: const BoxDecoration(
// //                             color: Color(0xFF0047BA),
// //                             shape: BoxShape.circle,
// //                           ),
// //                           child: const Icon(
// //                             Icons.camera_alt,
// //                             color: Colors.white,
// //                             size: 20,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 32),
// //                 Form(
// //                   key: _formKey,
// //                   child: Column(
// //                     children: [
// //                       _buildTextField(
// //                         controller: _nameController,
// //                         label: 'Full Name',
// //                         icon: Icons.person_outline,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       _buildTextField(
// //                         controller: _emailController,
// //                         label: 'Email',
// //                         icon: Icons.email_outlined,
// //                         keyboardType: TextInputType.emailAddress,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       _buildTextField(
// //                         controller: _phoneController,
// //                         label: 'Phone Number',
// //                         icon: Icons.phone_outlined,
// //                         keyboardType: TextInputType.phone,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       _buildTextField(
// //                         controller: _schoolController,
// //                         label: 'School/College',
// //                         icon: Icons.school_outlined,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       _buildTextField(
// //                         controller: _addressController,
// //                         label: 'Pickup Address',
// //                         icon: Icons.location_on_outlined,
// //                         maxLines: 2,
// //                       ),
// //                       const SizedBox(height: 32),
// //                       _buildSaveButton(),
// //                       const SizedBox(height: 16),
// //                       _buildDeleteAccountButton(),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildTextField({
// //     required TextEditingController controller,
// //     required String label,
// //     required IconData icon,
// //     TextInputType? keyboardType,
// //     int maxLines = 1,
// //   }) {
// //     return TextFormField(
// //       controller: controller,
// //       keyboardType: keyboardType,
// //       maxLines: maxLines,
// //       style: const TextStyle(color: Colors.black),
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: TextStyle(color: Colors.grey[600]),
// //         prefixIcon: Icon(icon, color: Colors.grey[600]),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12),
// //           borderSide: BorderSide(color: Colors.grey[300]!),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12),
// //           borderSide: const BorderSide(color: Colors.black, width: 2),
// //         ),
// //         filled: true,
// //         fillColor: Colors.grey[50],
// //       ),
// //       validator: (value) {
// //         if (value == null || value.isEmpty) {
// //           return 'Please enter $label';
// //         }
// //         return null;
// //       },
// //     );
// //   }

// //   Widget _buildSaveButton() {
// //     return ElevatedButton(
// //       onPressed: () {
// //         if (_formKey.currentState!.validate()) {
// //           // Handle save logic here
// //           print('Saving profile changes');
// //           Navigator.pop(context);
// //         }
// //       },
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: const Color(0xFF0047BA),
// //         foregroundColor: Colors.white,
// //         minimumSize: const Size(double.infinity, 54),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //       ),
// //       child: const Text(
// //         'Save Changes',
// //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //       ),
// //     );
// //   }

// //   Widget _buildDeleteAccountButton() {
// //     return TextButton(
// //       onPressed: () {
// //         // Show delete account confirmation dialog
// //         showDialog(
// //           context: context,
// //           builder: (context) => AlertDialog(
// //             title: const Text('Delete Account'),
// //             content: const Text(
// //               'Are you sure you want to delete your account? This action cannot be undone.',
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () => Navigator.pop(context),
// //                 child: const Text('Cancel'),
// //               ),
// //               TextButton(
// //                 onPressed: () {
// //                   // Handle delete account logic
// //                   Navigator.pop(context);
// //                 },
// //                 child: const Text(
// //                   'Delete',
// //                   style: TextStyle(color: Colors.red),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //       style: TextButton.styleFrom(
// //         foregroundColor: Colors.red,
// //         minimumSize: const Size(double.infinity, 54),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //       ),
// //       child: const Text(
// //         'Delete Account',
// //         style: TextStyle(fontSize: 16),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _phoneController.dispose();
// //     _schoolController.dispose();
// //     _addressController.dispose();
// //     super.dispose();
// //   }
// // }

// // import 'dart:convert';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // import 'dart:io';

// // import '../../../models/user.dart';
// // import '../../../services/AuthService.dart';

// // class EditProfileScreen extends StatefulWidget {
// //   const EditProfileScreen({Key? key}) : super(key: key);

// //   @override
// //   _EditProfileScreenState createState() => _EditProfileScreenState();
// // }

// // class _EditProfileScreenState extends State<EditProfileScreen> {
// //   // Form key and controllers
// //   final _formKey = GlobalKey<FormState>();
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //   final _phoneController = TextEditingController();
// //   final _schoolController = TextEditingController();
// //   final _addressController = TextEditingController();

// //   // Services and state
// //   final UserService _userService = UserService();
// //   final FirebaseAuth _auth = FirebaseAuth.instance;

// //   File? _imageFile;
// //   bool _isLoading = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserProfile();
// //   }

// //   Future<void> _loadUserProfile() async {
// //     try {
// //       final userID = _auth.currentUser!.uid;
// //       UserModel? user = await _userService.fetchUser(userID);

// //       if (user != null) {
// //         setState(() {
// //           _nameController.text = user.name;
// //           _emailController.text = user.email;
// //           _phoneController.text = user.phone;
// //           _schoolController.text = user.school ?? '';
// //           _addressController.text = user.address ?? '';
// //         });
// //       }
// //     } catch (e) {
// //       _showErrorSnackBar('Failed to load profile');
// //     }
// //   }

// //   // Future<void> _pickProfileImage() async {
// //   //   try {
// //   //     final pickedFile = await _picker.pickImage(
// //   //       source: ImageSource.gallery,
// //   //       maxWidth: 1800,
// //   //       maxHeight: 1800,
// //   //       imageQuality: 85,
// //   //     );

// //   //     if (pickedFile != null) {
// //   //       setState(() {
// //   //         _imageFile = File(pickedFile.path);
// //   //       });
// //   //     }
// //   //   } catch (e) {
// //   //     _showErrorSnackBar('Error selecting image');
// //   //   }
// //   // }

// //   Future<void> _saveProfile() async {
// //     if (!_formKey.currentState!.validate()) return;

// //     setState(() => _isLoading = true);

// //     try {
// //       final userID = _auth.currentUser!.uid;

// //       // Update user profile data
// //       await _userService.updateUser(userID, {
// //         'name': _nameController.text,
// //         'phone': _phoneController.text,
// //         'school': _schoolController.text,
// //         'address': _addressController.text,
// //       });

// //       // Optional: Upload profile picture if selected
// //       if (_imageFile != null) {
// //         // Implement profile picture upload logic here
// //       }

// //       _showSuccessSnackBar('Profile updated successfully');
// //       Navigator.pop(context);
// //     } catch (e) {
// //       _showErrorSnackBar('Failed to update profile');
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   void _showDeleteAccountConfirmation() {
// //     showModalBottomSheet(
// //       context: context,
// //       shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (context) => Container(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Text(
// //               'Delete Account',
// //               style: TextStyle(
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.red,
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             const Text(
// //               'Are you sure you want to delete your account? This action cannot be undone.',
// //               textAlign: TextAlign.center,
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             const SizedBox(height: 24),
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: OutlinedButton(
// //                     onPressed: () => Navigator.pop(context),
// //                     style: OutlinedButton.styleFrom(
// //                       foregroundColor: Colors.black,
// //                       side: BorderSide(color: Colors.grey[300]!),
// //                       padding: const EdgeInsets.symmetric(vertical: 12),
// //                     ),
// //                     child: const Text('Cancel'),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 16),
// //                 Expanded(
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       // Implement account deletion logic
// //                       Navigator.pop(context);
// //                       _deleteAccount();
// //                     },
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.red,
// //                       padding: const EdgeInsets.symmetric(vertical: 12),
// //                     ),
// //                     child: const Text('Delete'),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _deleteAccount() async {
// //     try {
// //       setState(() => _isLoading = true);
// //       // Implement account deletion logic
// //       await _auth.currentUser?.delete();
// //       // Navigate to onboarding or login screen
// //       Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
// //     } catch (e) {
// //       _showErrorSnackBar('Failed to delete account');
// //     } finally {
// //       setState(() => _isLoading = false);
// //     }
// //   }

// //   void _showErrorSnackBar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         backgroundColor: Colors.red,
// //       ),
// //     );
// //   }

// //   void _showSuccessSnackBar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(message),
// //         backgroundColor: Colors.green,
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         title: const Text(
// //           'Edit Profile',
// //           style: TextStyle(
// //             color: Colors.black,
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //       ),
// //       body: Stack(
// //         children: [
// //           SafeArea(
// //             child: SingleChildScrollView(
// //               padding: const EdgeInsets.symmetric(horizontal: 24),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   const SizedBox(height: 20),
// //                   _buildProfilePicture(),
// //                   const SizedBox(height: 32),
// //                   _buildProfileForm(),
// //                   const SizedBox(height: 24),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           if (_isLoading)
// //             const Positioned.fill(
// //               child: Center(
// //                 child: CircularProgressIndicator(
// //                   color: Color(0xFF0047BA),
// //                 ),
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildProfilePicture() {
// //     return GestureDetector(
// //       // onTap: _pickProfileImage,
// //       child: Stack(
// //         alignment: Alignment.bottomRight,
// //         children: [
// //           CircleAvatar(
// //             radius: 70,
// //             backgroundColor: Colors.grey[200],
// //             backgroundImage: _imageFile != null
// //               ? FileImage(_imageFile!)
// //               : null,
// //             child: _imageFile == null
// //               ? const Icon(Icons.person, size: 70, color: Colors.grey)
// //               : null,
// //           ),
// //           Positioned(
// //             bottom: 0,
// //             right: 0,
// //             child: Container(
// //               padding: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 color: const Color(0xFF0047BA),
// //                 shape: BoxShape.circle,
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.2),
// //                     spreadRadius: 2,
// //                     blurRadius: 5,
// //                   ),
// //                 ],
// //               ),
// //               child: const Icon(
// //                 Icons.camera_alt,
// //                 color: Colors.white,
// //                 size: 24,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildProfileForm() {
// //     return Form(
// //       key: _formKey,
// //       child: Column(
// //         children: [
// //           _buildTextField(
// //             controller: _nameController,
// //             label: 'Full Name',
// //             icon: Icons.person_outline,
// //             validator: (value) => value!.length < 2
// //               ? 'Please enter a valid name'
// //               : null,
// //           ),
// //           const SizedBox(height: 16),
// //           _buildTextField(
// //             controller: _emailController,
// //             label: 'Email',
// //             icon: Icons.email_outlined,
// //             keyboardType: TextInputType.emailAddress,
// //             readOnly: true, // Email is typically not editable
// //           ),
// //           const SizedBox(height: 16),
// //           _buildTextField(
// //             controller: _phoneController,
// //             label: 'Phone Number',
// //             icon: Icons.phone_outlined,
// //             keyboardType: TextInputType.phone,
// //             validator: (value) =>
// //               value!.length < 10 ? 'Please enter a valid phone number' : null,
// //           ),
// //           const SizedBox(height: 16),
// //           _buildTextField(
// //             controller: _schoolController,
// //             label: 'School/College',
// //             icon: Icons.school_outlined,
// //           ),
// //           const SizedBox(height: 16),
// //           _buildTextField(
// //             controller: _addressController,
// //             label: 'Pickup Address',
// //             icon: Icons.location_on_outlined,
// //             maxLines: 2,
// //           ),
// //           const SizedBox(height: 32),
// //           _buildSaveButton(),
// //           const SizedBox(height: 16),
// //           _buildDeleteAccountButton(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildTextField({
// //     required TextEditingController controller,
// //     required String label,
// //     required IconData icon,
// //     TextInputType? keyboardType,
// //     String? Function(String?)? validator,
// //     int maxLines = 1,
// //     bool readOnly = false,
// //   }) {
// //     return TextFormField(
// //       controller: controller,
// //       keyboardType: keyboardType,
// //       maxLines: maxLines,
// //       readOnly: readOnly,
// //       style: const TextStyle(color: Colors.black),
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: TextStyle(color: Colors.grey[600]),
// //         prefixIcon: Icon(icon, color: Colors.grey[600]),
// //         enabledBorder: _buildOutlineBorder(Colors.grey[300]!),
// //         focusedBorder: _buildOutlineBorder(const Color(0xFF0047BA), width: 2),
// //         errorBorder: _buildOutlineBorder(Colors.red),
// //         focusedErrorBorder: _buildOutlineBorder(Colors.red, width: 2),
// //         filled: true,
// //         fillColor: readOnly ? Colors.grey[100] : Colors.grey[50],
// //       ),
// //       validator: validator ??
// //         (value) => value!.isEmpty
// //           ? 'Please enter $label'
// //           : null,
// //     );
// //   }

// //   OutlineInputBorder _buildOutlineBorder(Color color, {double width = 1}) {
// //     return OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(12),
// //       borderSide: BorderSide(color: color, width: width),
// //     );
// //   }

// //   Widget _buildSaveButton() {
// //     return ElevatedButton(
// //       onPressed: _saveProfile,
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: const Color(0xFF0047BA),
// //         foregroundColor: Colors.white,
// //         minimumSize: const Size(double.infinity, 54),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //       ),
// //       child: const Text(
// //         'Save Changes',
// //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //       ),
// //     );
// //   }

// //   Widget _buildDeleteAccountButton() {
// //     return TextButton(
// //       onPressed: _showDeleteAccountConfirmation,
// //       style: TextButton.styleFrom(
// //         foregroundColor: Colors.red,
// //         minimumSize: const Size(double.infinity, 54),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //       ),
// //       child: const Text(
// //         'Delete Account',
// //         style: TextStyle(fontSize: 16),
// //       ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _nameController.dispose();
// //     _emailController.dispose();
// //     _phoneController.dispose();
// //     _schoolController.dispose();
// //     _addressController.dispose();
// //     super.dispose();
// //   }
// // }

// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isEditing = false;

//   String? _base64Image;
//   // Form controllers
//   final _nameController = TextEditingController(text: 'John Doe');
//   final _ageController = TextEditingController(text: '22');
//   final _emailController = TextEditingController(text: 'john.doe@email.com');
//   final _phoneController = TextEditingController(text: '+1 234 567 8900');
//   final _schoolController = TextEditingController(text: 'Stanford University');
//   String _selectedGender = 'Male'; // Default value

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 512, // Reduce image size
//         maxHeight: 512,
//         imageQuality: 75, // Compress image
//       );

//       if (image != null) {
//         final bytes = await image.readAsBytes();
//         setState(() {
//           _base64Image = base64Encode(bytes);
//         });

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
        
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({'profilePicture': _base64Image});
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking image: $e')),
//       );
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
// import 'dart:convert';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import '../../../models/user.dart';
// import '../../../services/AuthService.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Form controllers
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _schoolController = TextEditingController();
//   final _addressController = TextEditingController();

//   final UserService _userService = UserService();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   String? _profilePictureBase64;
//   @override
//   void initState() {
//     super.initState();

//     _schoolController.text = "University of Example";
//     // _addressController.text = "123 Student Street, City";
//     _loadProfile();
//   }

//   Future<void> _loadProfile() async {
//     try {
//       final userID = _auth.currentUser!.uid;
//       UserModel? user = await _userService.fetchUser(userID);
//       if (user != null) {
//         _nameController.text = user.name;
//         _emailController.text = user.email;
//         _phoneController.text = user.phone;
//         // _schoolController.text = user.school;
//         _addressController.text = user.address!;
//       }

//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> _updateProfilePicture() async {
//     try {
//       final userID = _auth.currentUser!.uid;

//       print("Profile picture uploaded successfully");

//     } catch (e) {
//       print("Error updating profile picture: $e");
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//     }
//   }

//   @override
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//   void dispose() {
//     _nameController.dispose();
//     _ageController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _schoolController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final bool isSmallScreen = screenSize.width < 600;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenSize.width * 0.05,
//               vertical: screenSize.height * 0.02,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // Custom top bar
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
                    
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//                       Center(
//                         child: Text(
//                           'Profile',
//                           style: TextStyle(
//                             fontSize: isSmallScreen ? 28 : 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           _isEditing ? Icons.check : Icons.edit,
//                           color: Colors.blue.shade700,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             if (_isEditing &&
//                                 _formKey.currentState!.validate()) {
//                               // Save the form
//                               _isEditing = false;
//                             } else {
//                               _isEditing = true;
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),

//                   // Profile Image Section
//                   GestureDetector(
//                     onTap: _isEditing ? _pickImage : null,
//                     child: Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         Container(
//                           width: isSmallScreen ? 120 : 150,
//                           height: isSmallScreen ? 120 : 150,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 4,
//                             ),
//                           ),
//                           child: ClipOval(
//                             child: _base64Image != null
//                                 ? Image.memory(
//                                     base64Decode(_base64Image!),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Image.network(
//                                     'https://placeholder.com/150',
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                         ),
//                         if (_isEditing)
//                           CircleAvatar(
//                             radius: isSmallScreen ? 18 : 22,
//                             backgroundColor: Colors.blue.shade700,
//                             child: Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                               size: isSmallScreen ? 18 : 22,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: screenSize.height * 0.005),

//                   // Profile Information Card
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.only(
//                         left: isSmallScreen ? 16 : 20,
//                         right: isSmallScreen ? 16 : 20,
//                         top: isSmallScreen ? 5 : 20,
//                         bottom: isSmallScreen ? 5 : 20,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             spreadRadius: 1,
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Personal Information',
//                             style: TextStyle(
//                               fontSize: isSmallScreen ? 18 : 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue.shade700,
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           _buildEditableField(
//                             label: 'Full Name',
//                             controller: _nameController,
//                             isEditing: _isEditing,
//                           ),
//                           _buildEditableField(
//                             label: 'Age',
//                             controller: _ageController,
//                             isEditing: _isEditing,
//                             keyboardType: TextInputType.number,
//                           ),
//                           _buildEditableField(
//                             label: 'Email',
//                             controller: _emailController,
//                             isEditing: _isEditing,
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           _buildEditableField(
//                             label: 'Phone',
//                             controller: _phoneController,
//                             isEditing: _isEditing,
//                             keyboardType: TextInputType.phone,
//                           ),
//                           _buildEditableField(
//                             label: 'School',
//                             controller: _schoolController,
//                             isEditing: _isEditing,
//                           ),
//                           _buildGenderSelector(isEditing: _isEditing),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//         ),
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),
//                 // Profile Picture Section
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 60,
//                       backgroundColor: Colors.grey[200],
//                       backgroundImage: _profilePictureBase64 != null
//                           ? MemoryImage(base64Decode(_profilePictureBase64!))
//                           : null,
//                       child: _profilePictureBase64 == null
//                           ? const Icon(
//                               Icons.person,
//                               size: 60,
//                               color: Colors.grey,
//                             )
//                           : null,
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: _updateProfilePicture,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             color: Color(0xFF0047BA),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.camera_alt,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       _buildTextField(
//                         controller: _nameController,
//                         label: 'Full Name',
//                         icon: Icons.person_outline,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildTextField(
//                         controller: _emailController,
//                         label: 'Email',
//                         icon: Icons.email_outlined,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildTextField(
//                         controller: _phoneController,
//                         label: 'Phone Number',
//                         icon: Icons.phone_outlined,
//                         keyboardType: TextInputType.phone,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildTextField(
//                         controller: _schoolController,
//                         label: 'School/College',
//                         icon: Icons.school_outlined,
//                       ),
//                       const SizedBox(height: 16),
//                       _buildTextField(
//                         controller: _addressController,
//                         label: 'Pickup Address',
//                         icon: Icons.location_on_outlined,
//                         maxLines: 2,
//                       ),
//                       const SizedBox(height: 32),
//                       _buildSaveButton(),
//                       const SizedBox(height: 16),
//                       _buildDeleteAccountButton(),
//                     ],
//                   ),
//                 ),
//               ],
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//             ),
//           ),
//         ),
//       ),
//     );
//   }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//   Widget _buildEditableField({
//     required String label,
//     required TextEditingController controller,
//     required bool isEditing,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           if (isEditing)
//             TextFormField(
//               controller: controller,
//               keyboardType: keyboardType,
//               decoration: InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'This field is required';
//                 }
//                 return null;
//               },
//             )
//           else
//             Padding(
//               padding: const EdgeInsets.only(top: 4),
//               child: Text(
//                 controller.text,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//                 ),
//               ),
//             ),
//         ],
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
=======
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     int maxLines = 1,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
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
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildSaveButton() {
//     return ElevatedButton(
//       onPressed: () {
//         if (_formKey.currentState!.validate()) {
//           // Handle save logic here
//           print('Saving profile changes');
//           Navigator.pop(context);
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF0047BA),
//         foregroundColor: Colors.white,
//         minimumSize: const Size(double.infinity, 54),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: const Text(
//         'Save Changes',
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//       ),
//     );
//   }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//   Widget _buildGenderSelector({required bool isEditing}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Gender',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey.shade600,
//           ),
//         ),
//         if (isEditing)
//           Container(
//             padding: const EdgeInsets.only(top: 8),
//             child: DropdownButtonFormField<String>(
//               value: _selectedGender,
//               decoration: InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//               items: ['Male', 'Female', 'Other']
//                   .map((gender) => DropdownMenuItem(
//                         value: gender,
//                         child: Text(gender),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedGender = value!;
//                 });
//               },
//             ),
//           )
//         else
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               _selectedGender,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//   bool _isEditing = false;

//   String? _base64Image;
//   // Form controllers
//   final _nameController = TextEditingController(text: 'John Doe');
//   final _ageController = TextEditingController(text: '22');
//   final _emailController = TextEditingController(text: 'john.doe@email.com');
//   final _phoneController = TextEditingController(text: '+1 234 567 8900');
//   final _schoolController = TextEditingController(text: 'Stanford University');
//   String _selectedGender = 'Male'; // Default value

//   Future<void> _pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? image = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 512,
//         maxHeight: 512,
//         imageQuality: 75,
//       );

//       if (image != null) {
//         final bytes = await image.readAsBytes();
//         setState(() {
//           _base64Image = base64Encode(bytes);
//         });

//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({'profilePicture': _base64Image});
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error picking image: $e')),
//       );
//     }
//   }
<<<<<<< HEAD
=======
=======
//   Widget _buildDeleteAccountButton() {
//     return TextButton(
//       onPressed: () {
//         // Show delete account confirmation dialog
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Delete Account'),
//             content: const Text(
//               'Are you sure you want to delete your account? This action cannot be undone.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('Cancel'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   // Handle delete account logic
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Delete',
//                   style: TextStyle(color: Colors.red),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//       style: TextButton.styleFrom(
//         foregroundColor: Colors.red,
//         minimumSize: const Size(double.infinity, 54),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: const Text(
//         'Delete Account',
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

//   @override
//   void dispose() {
//     _nameController.dispose();
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//     _ageController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _schoolController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size screenSize = MediaQuery.of(context).size;
//     final bool isSmallScreen = screenSize.width < 600;

//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF8A1538), Color(0xFFD32F54)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenSize.width * 0.05,
//               vertical: screenSize.height * 0.02,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // Custom top bar
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Center(
//                         child: Text(
//                           'Profile',
//                           style: TextStyle(
//                             fontSize: isSmallScreen ? 28 : 32,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           _isEditing ? Icons.check : Icons.edit,
//                           color: Colors.white,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             if (_isEditing &&
//                                 _formKey.currentState!.validate()) {
//                               _isEditing = false;
//                             } else {
//                               _isEditing = true;
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),

//                   // Profile Image Section
//                   GestureDetector(
//                     onTap: _isEditing ? _pickImage : null,
//                     child: Stack(
//                       alignment: Alignment.bottomRight,
//                       children: [
//                         Container(
//                           width: isSmallScreen ? 120 : 150,
//                           height: isSmallScreen ? 120 : 150,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 4,
//                             ),
//                           ),
//                           child: ClipOval(
//                             child: _base64Image != null
//                                 ? Image.memory(

//                                     base64Decode(_base64Image!),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : Image.network(
//                                     'https://placeholder.com/150',
//                                     fit: BoxFit.cover,
//                                   ),
//                           ),
//                         ),
//                         if (_isEditing)
//                           CircleAvatar(
//                             radius: isSmallScreen ? 18 : 22,
//                             backgroundColor: Color(0xFF8A1538),
//                             child: Icon(
//                               Icons.camera_alt,
//                               color: Colors.white,
//                               size: isSmallScreen ? 18 : 22,
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: screenSize.height * 0.005),

//                   // Profile Information Card
//                   Expanded(
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 20,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.05),
//                             spreadRadius: 1,
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Personal Information',
//                             style: TextStyle(
//                               fontSize: isSmallScreen ? 18 : 20,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF8A1538),
//                             ),
//                           ),
//                           SizedBox(height: 16),
//                           _buildEditableField(
//                             label: 'Full Name',
//                             controller: _nameController,
//                             isEditing: _isEditing,
//                           ),
//                           _buildEditableField(
//                             label: 'Age',
//                             controller: _ageController,
//                             isEditing: _isEditing,
//                             keyboardType: TextInputType.number,
//                           ),
//                           _buildEditableField(
//                             label: 'Email',
//                             controller: _emailController,
//                             isEditing: _isEditing,
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           _buildEditableField(
//                             label: 'Phone',
//                             controller: _phoneController,
//                             isEditing: _isEditing,
//                             keyboardType: TextInputType.phone,
//                           ),
//                           _buildEditableField(
//                             label: 'School',
//                             controller: _schoolController,
//                             isEditing: _isEditing,
//                           ),
//                           _buildGenderSelector(isEditing: _isEditing),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
<<<<<<< HEAD
=======
=======
//     _emailController.dispose();
//     _phoneController.dispose();
//     _schoolController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }

// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'dart:io';

// import '../../../models/user.dart';
// import '../../../services/AuthService.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   // Form key and controllers
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _schoolController = TextEditingController();
//   final _addressController = TextEditingController();

//   // Services and state
//   final UserService _userService = UserService();
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   File? _imageFile;
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadUserProfile();
//   }

//   Future<void> _loadUserProfile() async {
//     try {
//       final userID = _auth.currentUser!.uid;
//       UserModel? user = await _userService.fetchUser(userID);

//       if (user != null) {
//         setState(() {
//           _nameController.text = user.name;
//           _emailController.text = user.email;
//           _phoneController.text = user.phone;
//           _schoolController.text = user.school ?? '';
//           _addressController.text = user.address ?? '';
//         });
//       }
//     } catch (e) {
//       _showErrorSnackBar('Failed to load profile');
//     }
//   }

//   // Future<void> _pickProfileImage() async {
//   //   try {
//   //     final pickedFile = await _picker.pickImage(
//   //       source: ImageSource.gallery,
//   //       maxWidth: 1800,
//   //       maxHeight: 1800,
//   //       imageQuality: 85,
//   //     );

//   //     if (pickedFile != null) {
//   //       setState(() {
//   //         _imageFile = File(pickedFile.path);
//   //       });
//   //     }
//   //   } catch (e) {
//   //     _showErrorSnackBar('Error selecting image');
//   //   }
//   // }

//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     try {
//       final userID = _auth.currentUser!.uid;

//       // Update user profile data
//       await _userService.updateUser(userID, {
//         'name': _nameController.text,
//         'phone': _phoneController.text,
//         'school': _schoolController.text,
//         'address': _addressController.text,
//       });

//       // Optional: Upload profile picture if selected
//       if (_imageFile != null) {
//         // Implement profile picture upload logic here
//       }

//       _showSuccessSnackBar('Profile updated successfully');
//       Navigator.pop(context);
//     } catch (e) {
//       _showErrorSnackBar('Failed to update profile');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showDeleteAccountConfirmation() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Delete Account',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Are you sure you want to delete your account? This action cannot be undone.',
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () => Navigator.pop(context),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.black,
//                       side: BorderSide(color: Colors.grey[300]!),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text('Cancel'),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Implement account deletion logic
//                       Navigator.pop(context);
//                       _deleteAccount();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text('Delete'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//         ),
//       ),
//     );
//   }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//   Widget _buildEditableField({
//     required String label,
//     required TextEditingController controller,
//     required bool isEditing,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           if (isEditing)
//             TextFormField(
//               controller: controller,
//               keyboardType: keyboardType,
//               decoration: InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'This field is required';
//                 }
//                 return null;
//               },
//             )
//           else
//             Padding(
//               padding: const EdgeInsets.only(top: 4),
//               child: Text(
//                 controller.text,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
<<<<<<< HEAD
=======
=======
//   Future<void> _deleteAccount() async {
//     try {
//       setState(() => _isLoading = true);
//       // Implement account deletion logic
//       await _auth.currentUser?.delete();
//       // Navigate to onboarding or login screen
//       Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
//     } catch (e) {
//       _showErrorSnackBar('Failed to delete account');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }

//   void _showSuccessSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           SafeArea(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 20),
//                   _buildProfilePicture(),
//                   const SizedBox(height: 32),
//                   _buildProfileForm(),
//                   const SizedBox(height: 24),
//                 ],
//               ),
//             ),
//           ),
//           if (_isLoading)
//             const Positioned.fill(
//               child: Center(
//                 child: CircularProgressIndicator(
//                   color: Color(0xFF0047BA),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
//   Widget _buildGenderSelector({required bool isEditing}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Gender',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey.shade600,
//           ),
//         ),
//         if (isEditing)
//           Container(
//             padding: const EdgeInsets.only(top: 8),
//             child: DropdownButtonFormField<String>(
//               value: _selectedGender,
//               decoration: InputDecoration(
//                 contentPadding:
//                     EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//               ),
//               items: ['Male', 'Female', 'Other']
//                   .map((gender) => DropdownMenuItem(
//                         value: gender,
//                         child: Text(gender),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedGender = value!;
//                 });
//               },
//             ),
//           )
//         else
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               _selectedGender,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
//   Widget _buildProfilePicture() {
//     return GestureDetector(
//       // onTap: _pickProfileImage,
//       child: Stack(
//         alignment: Alignment.bottomRight,
//         children: [
//           CircleAvatar(
//             radius: 70,
//             backgroundColor: Colors.grey[200],
//             backgroundImage: _imageFile != null
//               ? FileImage(_imageFile!)
//               : null,
//             child: _imageFile == null
//               ? const Icon(Icons.person, size: 70, color: Colors.grey)
//               : null,
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF0047BA),
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 5,
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.camera_alt,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileForm() {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           _buildTextField(
//             controller: _nameController,
//             label: 'Full Name',
//             icon: Icons.person_outline,
//             validator: (value) => value!.length < 2
//               ? 'Please enter a valid name'
//               : null,
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: _emailController,
//             label: 'Email',
//             icon: Icons.email_outlined,
//             keyboardType: TextInputType.emailAddress,
//             readOnly: true, // Email is typically not editable
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: _phoneController,
//             label: 'Phone Number',
//             icon: Icons.phone_outlined,
//             keyboardType: TextInputType.phone,
//             validator: (value) =>
//               value!.length < 10 ? 'Please enter a valid phone number' : null,
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: _schoolController,
//             label: 'School/College',
//             icon: Icons.school_outlined,
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: _addressController,
//             label: 'Pickup Address',
//             icon: Icons.location_on_outlined,
//             maxLines: 2,
//           ),
//           const SizedBox(height: 32),
//           _buildSaveButton(),
//           const SizedBox(height: 16),
//           _buildDeleteAccountButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//     int maxLines = 1,
//     bool readOnly = false,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       readOnly: readOnly,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[600]),
//         prefixIcon: Icon(icon, color: Colors.grey[600]),
//         enabledBorder: _buildOutlineBorder(Colors.grey[300]!),
//         focusedBorder: _buildOutlineBorder(const Color(0xFF0047BA), width: 2),
//         errorBorder: _buildOutlineBorder(Colors.red),
//         focusedErrorBorder: _buildOutlineBorder(Colors.red, width: 2),
//         filled: true,
//         fillColor: readOnly ? Colors.grey[100] : Colors.grey[50],
//       ),
//       validator: validator ??
//         (value) => value!.isEmpty
//           ? 'Please enter $label'
//           : null,
//     );
//   }

//   OutlineInputBorder _buildOutlineBorder(Color color, {double width = 1}) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide(color: color, width: width),
//     );
//   }

//   Widget _buildSaveButton() {
//     return ElevatedButton(
//       onPressed: _saveProfile,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF0047BA),
//         foregroundColor: Colors.white,
//         minimumSize: const Size(double.infinity, 54),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: const Text(
//         'Save Changes',
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _buildDeleteAccountButton() {
//     return TextButton(
//       onPressed: _showDeleteAccountConfirmation,
//       style: TextButton.styleFrom(
//         foregroundColor: Colors.red,
//         minimumSize: const Size(double.infinity, 54),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: const Text(
//         'Delete Account',
//         style: TextStyle(fontSize: 16),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _schoolController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  String? _base64Image;
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  String? _profilePictureUrl;
  String? _userId;

  // Form controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  final _phoneController = TextEditingController();
  final _schoolController = TextEditingController();
  String _selectedGender = 'Male'; // Default value
<<<<<<< HEAD
  Map<String, dynamic>? driverData;
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
<<<<<<< HEAD
    _loadDriverProfile();
  }

  //load driver profile
  Future<void> _loadDriverProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      _userId = user.uid;
      final querySnapshot = await FirebaseFirestore.instance
          .collection('drivers')
          .where('userID', isEqualTo: _userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        driverData = querySnapshot.docs.first.data();
        setState(() {
          _nameController.text = driverData!['name'] ?? '';
          _ageController.text = driverData!['age']?.toString() ?? '';
          _phoneController.text = driverData!['phone'] ?? '';
          _schoolController.text = driverData!['school'] ?? '';
          _selectedGender = driverData!['gender'] ?? 'Male';
          _profilePictureUrl = driverData!['faceImage'];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading driver profile: $e')),
      );
    }
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  }

  Future<void> _loadUserProfile() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      _userId = user.uid;
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        setState(() {
          _nameController.text = data?['name'] ?? '';
          _ageController.text = data?['age']?.toString() ?? '';

          _phoneController.text = data?['phone'] ?? '';
          _schoolController.text = data?['school'] ?? '';
          _selectedGender = data?['gender'] ?? 'Male';
          _profilePictureUrl = data?['profilePicture'];
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading profile: $e')),
      );
    }
  }

  Future<void> _updateUserProfile() async {
    if (!_isEditing) return;

    try {
      final Map<String, dynamic> updatedData = {
        'name': _nameController.text,
        'age': int.tryParse(_ageController.text) ?? 0,
        'phone': _phoneController.text,
        'school': _schoolController.text,
        'gender': _selectedGender,
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userId)
          .update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

<<<<<<< HEAD
=======
=======
  // Form controllers
  final _nameController = TextEditingController(text: 'John Doe');
  final _ageController = TextEditingController(text: '22');
  final _emailController = TextEditingController(text: 'john.doe@email.com');
  final _phoneController = TextEditingController(text: '+1 234 567 8900');
  final _schoolController = TextEditingController(text: 'Stanford University');
  String _selectedGender = 'Male'; // Default value

>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
<<<<<<< HEAD
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
=======
<<<<<<< HEAD
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
=======
<<<<<<< HEAD
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
=======
<<<<<<< HEAD
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
=======
        maxWidth: 512, // Reduce image size
        maxHeight: 512,
        imageQuality: 75, // Compress image
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _base64Image = base64Encode(bytes);
<<<<<<< HEAD
          _profilePictureUrl = null; // Clear URL to use new image
        });

=======
<<<<<<< HEAD
          _profilePictureUrl = null; // Clear URL to use new image
        });

=======
        });

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePicture': _base64Image});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
=======
<<<<<<< HEAD
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
=======
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  String? _base64Image;
  // Form controllers
  final _nameController = TextEditingController(text: 'John Doe');
  final _ageController = TextEditingController(text: '22');
  final _emailController = TextEditingController(text: 'john.doe@email.com');
  final _phoneController = TextEditingController(text: '+1 234 567 8900');
  final _schoolController = TextEditingController(text: 'Stanford University');
  String _selectedGender = 'Male'; // Default value

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512, // Reduce image size
        maxHeight: 512,
        imageQuality: 75, // Compress image
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _base64Image = base64Encode(bytes);
        });

        
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePicture': _base64Image});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
=======
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  String? _base64Image;
  // Form controllers
  final _nameController = TextEditingController(text: 'John Doe');
  final _ageController = TextEditingController(text: '22');
  final _emailController = TextEditingController(text: 'john.doe@email.com');
  final _phoneController = TextEditingController(text: '+1 234 567 8900');
  final _schoolController = TextEditingController(text: 'Stanford University');
  String _selectedGender = 'Male'; // Default value

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512, // Reduce image size
        maxHeight: 512,
        imageQuality: 75, // Compress image
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _base64Image = base64Encode(bytes);
        });

        
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({'profilePicture': _base64Image});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
<<<<<<< HEAD

=======
<<<<<<< HEAD

=======
    _emailController.dispose();
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    _phoneController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Container(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8A1538), Color(0xFFD32F54)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
        decoration: BoxDecoration(),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.02,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 28 : 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
<<<<<<< HEAD
=======
=======
                  // Custom top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
                    
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                      Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 28 : 32,
                            fontWeight: FontWeight.bold,
<<<<<<< HEAD
                            color: Colors.white,
=======
<<<<<<< HEAD
                            color: Colors.white,
=======
                            color: Colors.black,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                          ),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isEditing ? Icons.check : Icons.edit,
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          setState(() {
                            if (_isEditing &&
                                _formKey.currentState!.validate()) {
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
                          color: Colors.white,
=======
<<<<<<< HEAD
                          color: Colors.white,
=======
                          color: Colors.blue.shade700,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isEditing &&
                                _formKey.currentState!.validate()) {
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
                              // Save the form
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                              _isEditing = false;
                            } else {
                              _isEditing = true;
                            }
                          });
<<<<<<< HEAD
                          if (!_isEditing) {
                            await _updateUserProfile();
                          }
=======
<<<<<<< HEAD
                          if (!_isEditing) {
                            await _updateUserProfile();
                          }
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                        },
                      ),
                    ],
                  ),
<<<<<<< HEAD
                  InkWell(
=======
<<<<<<< HEAD
                  InkWell(
=======

                  // Profile Image Section
                  GestureDetector(
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                    onTap: _isEditing ? _pickImage : null,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: isSmallScreen ? 120 : 150,
                          height: isSmallScreen ? 120 : 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: ClipOval(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                            child: _profilePictureUrl != null
                                ? Image.memory(
                                    base64Decode(_profilePictureUrl!),
                                    fit: BoxFit.cover,
                                  )
                                : _base64Image != null
                                    ? Image.memory(
                                        base64Decode(_base64Image!),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://placeholder.com/150',
                                        fit: BoxFit.cover,
                                      ),
<<<<<<< HEAD
=======
=======
                            child: _base64Image != null
                                ? Image.memory(
                                    base64Decode(_base64Image!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://placeholder.com/150',
                                    fit: BoxFit.cover,
                                  ),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                          ),
                        ),
                        if (_isEditing)
                          CircleAvatar(
                            radius: isSmallScreen ? 18 : 22,
<<<<<<< HEAD
                            backgroundColor: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                            backgroundColor: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                            backgroundColor: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                            backgroundColor: Color(0xFF8A1538),
=======
                            backgroundColor: Colors.blue.shade700,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: isSmallScreen ? 18 : 22,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.005),
<<<<<<< HEAD
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
=======
<<<<<<< HEAD
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
=======

                  // Profile Information Card
                  Expanded(
                    child: Container(
                      width: double.infinity,
<<<<<<< HEAD
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
=======
<<<<<<< HEAD
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
=======
                      padding: EdgeInsets.only(
                        left: isSmallScreen ? 16 : 20,
                        right: isSmallScreen ? 16 : 20,
                        top: isSmallScreen ? 5 : 20,
                        bottom: isSmallScreen ? 5 : 20,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
                      ),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
<<<<<<< HEAD
                      child: ListView(
=======
<<<<<<< HEAD
                      child: ListView(
=======
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 20,
                              fontWeight: FontWeight.bold,
<<<<<<< HEAD
                              color: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                              color: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                              color: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                              color: Color(0xFF8A1538),
=======
                              color: Colors.blue.shade700,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildEditableField(
                            label: 'Full Name',
                            controller: _nameController,
                            isEditing: _isEditing,
                          ),
                          _buildEditableField(
                            label: 'Age',
                            controller: _ageController,
                            isEditing: _isEditing,
                            keyboardType: TextInputType.number,
                          ),
                          _buildEditableField(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
                            label: 'Email',
                            controller: _emailController,
                            isEditing: _isEditing,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          _buildEditableField(
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                            label: 'Phone',
                            controller: _phoneController,
                            isEditing: _isEditing,
                            keyboardType: TextInputType.phone,
                          ),
                          _buildEditableField(
                            label: 'School',
                            controller: _schoolController,
                            isEditing: _isEditing,
                          ),
                          _buildGenderSelector(isEditing: _isEditing),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          if (isEditing)
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                controller.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector({required bool isEditing}) {
<<<<<<< HEAD
    // Ensure _selectedGender has a valid value.
    if (!['Male', 'Female', 'Other'].contains(_selectedGender)) {
      _selectedGender = 'Male'; // Default value
    }
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        if (isEditing)
<<<<<<< HEAD
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            items: ['Male', 'Female', 'Other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
=======
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _selectedGender,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../services/AuthService.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _schoolController = TextEditingController();
  final _addressController = TextEditingController();

  final UserService _userService = UserService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _profilePictureBase64;
  @override
  void initState() {
    super.initState();
    // _nameController.text = "John Doe";
    // _emailController.text = "john.doe@example.com";
    // _phoneController.text = "+1 (555) 123-4567";
    _schoolController.text = "University of Example";
    // _addressController.text = "123 Student Street, City";
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final userID = _auth.currentUser!.uid;
      UserModel? user = await _userService.fetchUser(userID);
      if (user != null) {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
        // _schoolController.text = user.school;
        _addressController.text = user.address!;
      }

      // String? profilePicture = await _userService.fetchProfilePicture(userID);
      // if (profilePicture != null) {
      //   setState(() {
      //     _profilePictureBase64 = profilePicture;
      //   });
      // }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _updateProfilePicture() async {
    try {
      final userID = _auth.currentUser!.uid;
      // await _userService.uploadProfilePicture(userID);
      print("Profile picture uploaded successfully");
      // Reload profile picture after upload
      // String? profilePicture = await _userService.fetchProfilePicture(userID);
      // if (profilePicture != null) {
      //   setState(() {
      //     _profilePictureBase64 = profilePicture;
      //   });
      // }
    } catch (e) {
      print("Error updating profile picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Profile Picture Section
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _profilePictureBase64 != null
                          ? MemoryImage(base64Decode(_profilePictureBase64!))
                          : null,
                      child: _profilePictureBase64 == null
                          ? const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _updateProfilePicture,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0047BA),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _emailController,
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _schoolController,
                        label: 'School/College',
                        icon: Icons.school_outlined,
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller: _addressController,
                        label: 'Pickup Address',
                        icon: Icons.location_on_outlined,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 32),
                      _buildSaveButton(),
                      const SizedBox(height: 16),
                      _buildDeleteAccountButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Handle save logic here
          print('Saving profile changes');
          Navigator.pop(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0047BA),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Save Changes',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return TextButton(
      onPressed: () {
        // Show delete account confirmation dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content: const Text(
              'Are you sure you want to delete your account? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle delete account logic
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        'Delete Account',
        style: TextStyle(fontSize: 16),
      ),
    );
<<<<<<< HEAD
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  }

  @override
  void dispose() {
    _nameController.dispose();
<<<<<<< HEAD
    _ageController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _schoolController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05,
              vertical: screenSize.height * 0.02,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Custom top bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    
                      Center(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 28 : 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isEditing ? Icons.check : Icons.edit,
                          color: Colors.blue.shade700,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_isEditing &&
                                _formKey.currentState!.validate()) {
                              // Save the form
                              _isEditing = false;
                            } else {
                              _isEditing = true;
                            }
                          });
                        },
                      ),
                    ],
                  ),

                  // Profile Image Section
                  GestureDetector(
                    onTap: _isEditing ? _pickImage : null,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: isSmallScreen ? 120 : 150,
                          height: isSmallScreen ? 120 : 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: ClipOval(
                            child: _base64Image != null
                                ? Image.memory(
                                    base64Decode(_base64Image!),
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://placeholder.com/150',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        if (_isEditing)
                          CircleAvatar(
                            radius: isSmallScreen ? 18 : 22,
                            backgroundColor: Colors.blue.shade700,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: isSmallScreen ? 18 : 22,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.005),

                  // Profile Information Card
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                        left: isSmallScreen ? 16 : 20,
                        right: isSmallScreen ? 16 : 20,
                        top: isSmallScreen ? 5 : 20,
                        bottom: isSmallScreen ? 5 : 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildEditableField(
                            label: 'Full Name',
                            controller: _nameController,
                            isEditing: _isEditing,
                          ),
                          _buildEditableField(
                            label: 'Age',
                            controller: _ageController,
                            isEditing: _isEditing,
                            keyboardType: TextInputType.number,
                          ),
                          _buildEditableField(
                            label: 'Email',
                            controller: _emailController,
                            isEditing: _isEditing,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          _buildEditableField(
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
                            label: 'Phone',
                            controller: _phoneController,
                            isEditing: _isEditing,
                            keyboardType: TextInputType.phone,
                          ),
                          _buildEditableField(
                            label: 'School',
                            controller: _schoolController,
                            isEditing: _isEditing,
                          ),
                          _buildGenderSelector(isEditing: _isEditing),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          if (isEditing)
            TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                controller.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGenderSelector({required bool isEditing}) {
<<<<<<< HEAD
    // Ensure _selectedGender has a valid value.
    if (!['Male', 'Female', 'Other'].contains(_selectedGender)) {
      _selectedGender = 'Male'; // Default value
    }
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        if (isEditing)
<<<<<<< HEAD
          DropdownButtonFormField<String>(
            value: _selectedGender,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            items: ['Male', 'Female', 'Other']
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
=======
          Container(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
            ),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
          )
        else
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _selectedGender,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
<<<<<<< HEAD
=======
=======
    _emailController.dispose();
    _phoneController.dispose();
    _schoolController.dispose();
    _addressController.dispose();
    super.dispose();
  }
<<<<<<< HEAD
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
=======
<<<<<<< HEAD
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
}
