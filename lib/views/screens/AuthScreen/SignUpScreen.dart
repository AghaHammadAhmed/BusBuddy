<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
// import 'package:flutter/material.dart';
// import '../../../../models/user.dart';
// import '../../../services/AuthService.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Form controllers
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();
//   String? _selectedRole;

//   final UserService _userService = UserService();

//   bool _isLoading = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Create Account',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   'Please fill in the form to continue',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 40),
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
//                       _buildRoleDropdown(),
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
//                         controller: _passwordController,
//                         label: 'Password',
//                         icon: Icons.lock_outline,
//                         isPassword: true,
//                       ),
//                       const SizedBox(height: 32),
//                       _buildSignUpButton(),
//                       const SizedBox(height: 24),
//                       _buildSignInButton(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     bool isPassword = false,
//     TextInputType? keyboardType,
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
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildRoleDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedRole,
//       onChanged: (value) {
//         setState(() {
//           _selectedRole = value;
//         });
//       },
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please select a role';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: 'Select Role',
//         labelStyle: TextStyle(color: Colors.grey[600]),
//         prefixIcon:
//             Icon(Icons.account_circle_outlined, color: Colors.grey[600]),
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
//       items: const [
//         DropdownMenuItem(
//           value: 'student',
//           child: Text('Student'),
//         ),
//         DropdownMenuItem(
//           value: 'driver',
//           child: Text('Driver'),
//         ),
//       ],
//     );
//   }

//   Widget _buildSignUpButton() {
//     return ElevatedButton(
//       onPressed: _isLoading ? null : _handleSignUp,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color.fromARGB(255, 0, 71, 186),
//         foregroundColor: Colors.white,
//         minimumSize: const Size(double.infinity, 54),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: _isLoading
//           ? const CircularProgressIndicator(color: Colors.white)
//           : const Text(
//               'Create Account',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//     );
//   }

//   Widget _buildSignInButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           'Already have an account? ',
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/login');
//           },
//           child: const Text(
//             'Sign In',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _handleSignUp() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       final user = UserModel(
//         userID: '',
//         name: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         age: 0, // Replace with age if required
//         role: _selectedRole!,
//         gender: 'Unspecified',
//         phone: _phoneController.text.trim(),
//         address: 'Unspecified', // Replace with address if required
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//       );

//       final result = await _userService.registerUser(
//           user, _passwordController.text.trim());
//       // navigate to the home page
//       Navigator.pushNamed(context, '/login');
//       _showMessage(result);

//       setState(() => _isLoading = false);
//     }
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

<<<<<<< HEAD
import 'dart:developer';

=======
<<<<<<< HEAD
=======
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
import 'package:flutter/material.dart';
import '../../../../models/user.dart';
import '../../../services/AuthService.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;
<<<<<<< HEAD
  String? _selectedSchool;
=======
<<<<<<< HEAD
  String? _selectedSchool;
=======
<<<<<<< HEAD
  String? _selectedSchool;
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

  final UserService _userService = UserService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: const Color(0xFF8A1538),
=======
<<<<<<< HEAD
      backgroundColor: const Color(0xFF8A1538),
=======
<<<<<<< HEAD
      backgroundColor: const Color(0xFF8A1538),
=======
      backgroundColor: Colors.white,
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: const [
                      Text(
                        'Welcome!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Create an account to get started',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please fill in the form to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 40),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
                      _buildRoleDropdown(),
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
                        controller: _passwordController,
                        label: 'Password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                      ),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                      const SizedBox(height: 16),
                      _buildSchoolDropdown(),
                      const SizedBox(height: 32),
                      _buildSignUpButton(),
                      // const SizedBox(height: 24),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                      const SizedBox(height: 32),
                      _buildSignUpButton(),
                      const SizedBox(height: 24),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                      _buildSignInButton(),
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
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      onChanged: (value) {
        setState(() {
          _selectedRole = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a role';
        }
        return null;
      },
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      dropdownColor: const Color(0xFF8A1538),
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Select Role',
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
        DropdownMenuItem(value: 'student', child: Text('Student')),
        DropdownMenuItem(value: 'driver', child: Text('Driver')),
      ],
    );
  }

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
<<<<<<< HEAD
          log('Selected School: $_selectedSchool');
=======
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
        //get me more pakistani schools
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
      decoration: InputDecoration(
        labelText: 'Select Role',
        labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon:
            Icon(Icons.account_circle_outlined, color: Colors.grey[600]),
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
      items: const [
        DropdownMenuItem(
          value: 'student',
          child: Text('Student'),
        ),
        DropdownMenuItem(
          value: 'driver',
          child: Text('Driver'),
        ),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      ],
    );
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleSignUp,
      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8A1538),
=======
<<<<<<< HEAD
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8A1538),
=======
<<<<<<< HEAD
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8A1538),
=======
        backgroundColor: const Color.fromARGB(255, 0, 71, 186),
        foregroundColor: Colors.white,
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
<<<<<<< HEAD
          ? const CircularProgressIndicator(color: Color(0xFF8A1538))
          : const Text(
              'Sign Up',
=======
<<<<<<< HEAD
          ? const CircularProgressIndicator(color: Color(0xFF8A1538))
          : const Text(
              'Sign Up',
=======
<<<<<<< HEAD
          ? const CircularProgressIndicator(color: Color(0xFF8A1538))
          : const Text(
              'Sign Up',
=======
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Create Account',
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildSignInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
<<<<<<< HEAD
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.white70),
=======
<<<<<<< HEAD
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.white70),
=======
<<<<<<< HEAD
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.white70),
=======
        Text(
          'Already have an account? ',
          style: TextStyle(color: Colors.grey[600]),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
<<<<<<< HEAD
              color: Colors.white,
=======
<<<<<<< HEAD
              color: Colors.white,
=======
<<<<<<< HEAD
              color: Colors.white,
=======
              color: Colors.black,
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
<<<<<<< HEAD
      log('Selected School: $_selectedSchool');
=======
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

      final user = UserModel(
        userID: '',
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        age: 0, // Replace with age if required
        role: _selectedRole!,
<<<<<<< HEAD
        school: _selectedSchool,
=======
<<<<<<< HEAD
        school: _selectedSchool!,
=======
<<<<<<< HEAD
        school: _selectedSchool!,
=======
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        gender: 'Unspecified',
        phone: _phoneController.text.trim(),
        address: 'Unspecified', // Replace with address if required
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await _userService.registerUser(
          user, _passwordController.text.trim());
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
      // navigate to the home page
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
      Navigator.pushNamed(context, '/login');
      _showMessage(result);

      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
