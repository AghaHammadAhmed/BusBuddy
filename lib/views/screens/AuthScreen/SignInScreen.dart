<<<<<<< HEAD
=======
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
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
// import 'package:flutter/material.dart';
// import '../../../services/AuthService.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController(text: "driver@gmail.com");
//   final _passwordController = TextEditingController(text: "123456789");
//   final UserService _userService = UserService();
//   bool _isLoading = false;

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';
import '../../../services/AuthService.dart';
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../../services/AuthService.dart';
=======
import '../../../models/user.dart';
import '../../../services/AuthService.dart';
import 'SignUpScreen.dart';
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
<<<<<<< HEAD
=======

>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
import 'package:flutter/material.dart';
import '../../../services/AuthService.dart';
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  final _emailController = TextEditingController(text: "driver@gmail.com");
=======
<<<<<<< HEAD
  final _emailController = TextEditingController(text: "student@gmail.com");
=======
<<<<<<< HEAD
  final _emailController = TextEditingController(text: "student@gmail.com");
=======
  final _emailController = TextEditingController(text: "shaffayqazi641@gmail.com");
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
  final _passwordController = TextEditingController(text: "123456789");
  final UserService _userService = UserService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),
                    _buildAuthButton(),
                    const SizedBox(height: 24),
                    _buildToggleButton(context),
<<<<<<< HEAD
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          onPressed: () {
                            // Google login logic
                          },
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          icon: Icons.facebook_outlined,
                          onPressed: () {
                            // Apple login logic
                          },
                        ),
                      ],
                    ),
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a

                    const SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialButton(
                      icon: Icons.g_mobiledata,
                      onPressed: () {
                        // Google login logic
                      },
                    ),
                    const SizedBox(width: 20),
                    _buildSocialButton(
                      icon: Icons.facebook_outlined,
                      onPressed: () {
                        // Apple login logic
                      },
                    ),
                  ],
                ),
<<<<<<< HEAD
=======
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                  ],
                ),
              ),
            ],
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

  Widget _buildAuthButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleSignIn,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 71, 186),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Sign In',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.grey[600]),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/signUp');
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final result = await _userService.loginUser(email, password, context);
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 30),
    );
  }
<<<<<<< HEAD
}
=======

}


<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
=======
}


>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import '../../../models/user.dart';
// import "../../../services/auth_service.dart";

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   bool isLogin = true;
//   final _formKey = GlobalKey<FormState>();

//   // Form controllers
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _passwordController = TextEditingController();

//   final UserService _userService = UserService();

//   bool _isLoading = false;
//   String? _selectedRole; // Stores selected role
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
<<<<<<< HEAD
=======
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
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               const Text(
//                 'Welcome back',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Sign in to continue',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                       controller: _emailController,
//                       label: 'Email',
//                       icon: Icons.email_outlined,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _passwordController,
//                       label: 'Password',
//                       icon: Icons.lock_outline,
//                       isPassword: true,
//                     ),
//                     const SizedBox(height: 32),
//                     _buildAuthButton(),
//                     const SizedBox(height: 24),
//                     _buildToggleButton(context),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildSocialButton(
//                           icon: Icons.g_mobiledata,
//                           onPressed: () {
//                             // Google login logic
//                           },
//                         ),
//                         const SizedBox(width: 20),
//                         _buildSocialButton(
//                           icon: Icons.facebook_outlined,
//                           onPressed: () {
//                             // Apple login logic
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
//           child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Text(
//                   isLogin ? 'Welcome back' : 'Create account',
//                   style: const TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   isLogin
//                       ? 'Sign in to continue'
//                       : 'Please fill in the form to continue',
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
//                       if (!isLogin) ...[
//                         _buildTextField(
//                           controller: _nameController,
//                           label: 'Full Name',
//                           icon: Icons.person_outline,
//                         ),
//                       ],
//                       if(!isLogin) ...[
//                         const SizedBox(height: 16),
//                         _buildRoleDropdown(),
//                       ],
//                        const SizedBox(height: 16),
//                       _buildTextField(
//                         controller: _emailController,
//                         label: 'Email',
//                         icon: Icons.email_outlined,
//                         keyboardType: TextInputType.emailAddress,
//                       ),
//                       const SizedBox(height: 16),
//                       if (!isLogin) ...[
//                         _buildTextField(
//                           controller: _phoneController,
//                           label: 'Phone Number',
//                           icon: Icons.phone_outlined,
//                           keyboardType: TextInputType.phone,
//                         ),
//                         const SizedBox(height: 16),
//                       ],
//                       _buildTextField(
//                         controller: _passwordController,
//                         label: 'Password',
//                         icon: Icons.lock_outline,
//                         isPassword: true,
//                       ),
//                       const SizedBox(height: 32),
//                       _buildAuthButton(),
//                       const SizedBox(height: 24),
//                       _buildToggleButton(),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                  Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialButton(
//                       icon: Icons.g_mobiledata,
//                       onPressed: () {
//                         // Google login logic
//                       },
//                     ),
//                     const SizedBox(width: 20),
//                     _buildSocialButton(
//                       icon: Icons.apple,
//                       onPressed: () {
//                         // Apple login logic
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
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
<<<<<<< HEAD
=======
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
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

//   Widget _buildAuthButton() {
//     return ElevatedButton(
//       onPressed: _isLoading ? null : _handleSignIn,
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
//               'Sign In',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//     );
//   }

//   Widget _buildToggleButton(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Don't have an account? ",
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/signUp');
//           },
//           child: const Text(
//             'Sign Up',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _handleSignIn() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();
//       final result = await _userService.loginUser(email, password, context);
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
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
//   Widget _buildSocialButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(15),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: Icon(icon, size: 30),
//     );
//   }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../services/AuthService.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController(text: "student@gmail.com");
//   final _passwordController = TextEditingController(text: "123456789");
//   final UserService _userService = UserService();
//   bool _isLoading = false;
//   static late SharedPreferences _prefs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               const Text(
//                 'Welcome back',
//                 style: TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF8A1538),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Sign in to continue',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                       controller: _emailController,
//                       label: 'Email',
//                       icon: Icons.email_outlined,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: _passwordController,
//                       label: 'Password',
//                       icon: Icons.lock_outline,
//                       isPassword: true,
//                     ),
//                     const SizedBox(height: 32),
//                     _buildAuthButton(),
//                     const SizedBox(height: 24),
//                     _buildToggleButton(context),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildSocialButton(
//                           icon: Icons.g_mobiledata,
//                           onPressed: () {
//                             // Google login logic
//                           },
//                         ),
//                         const SizedBox(width: 20),
//                         _buildSocialButton(
//                           icon: Icons.facebook_outlined,
//                           onPressed: () {
//                             // Apple login logic
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
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
//           borderSide: const BorderSide(color: Color(0xFF8A1538), width: 2),
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

//   Widget _buildAuthButton() {
//     return ElevatedButton(
//       onPressed: _isLoading ? null : _handleSignIn,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF8A1538),
//         foregroundColor: Colors.white,
//         minimumSize: const Size(double.infinity, 54),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       child: _isLoading
//           ? const CircularProgressIndicator(color: Colors.white)
//           : const Text(
//               'Sign In',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//     );
//   }

//   Widget _buildToggleButton(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Don't have an account? ",
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         TextButton(
//           onPressed: () {
//             Navigator.pushReplacementNamed(context, '/signUp');
//           },
//           child: const Text(
//             'Sign Up',
//             style: TextStyle(
//               color: Color(0xFF8A1538),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _handleSignIn() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();
//       final result = await _userService.loginUser(email, password, context);
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
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Widget _buildSocialButton({
//     required IconData icon,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         shape: const CircleBorder(),
//         padding: const EdgeInsets.all(15),
//         side: BorderSide(color: Colors.grey.shade300),
//       ),
//       child: Icon(icon, size: 30),
//     );
//   }
// }



<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
// }

>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/AuthService.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< HEAD
  final _emailController = TextEditingController(text: "student@gmail.com");
=======
<<<<<<< HEAD
  final _emailController = TextEditingController(text: "student@gmail.com");
=======
<<<<<<< HEAD
  final _emailController = TextEditingController(text: "student@gmail.com");
=======
  final _emailController = TextEditingController(text: "driver@gmail.com");
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  final _passwordController = TextEditingController(text: "123456789");
  final UserService _userService = UserService();
  bool _isLoading = false;
  static late SharedPreferences _prefs;

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
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
<<<<<<< HEAD
            crossAxisAlignment: CrossAxisAlignment.stretch,
=======
<<<<<<< HEAD
            crossAxisAlignment: CrossAxisAlignment.stretch,
=======
<<<<<<< HEAD
            crossAxisAlignment: CrossAxisAlignment.stretch,
=======
            crossAxisAlignment: CrossAxisAlignment.start,
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome back',
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8A1538),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                ),
              ),
              const SizedBox(height: 40),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 32),
                    _buildAuthButton(),
                    const SizedBox(height: 24),
                    _buildToggleButton(context),
                    const SizedBox(height: 20),
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     _buildSocialButton(
                    //       icon: Icons.g_mobiledata,
                    //       onPressed: () {
                    //         // Google login logic
                    //       },
                    //     ),
                    //     const SizedBox(width: 20),
                    //     _buildSocialButton(
                    //       icon: Icons.facebook_outlined,
                    //       onPressed: () {
                    //         // Apple login logic
                    //       },
                    //     ),
                    //   ],
                    // ),
<<<<<<< HEAD
=======
=======
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          onPressed: () {
                            // Google login logic
                          },
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          icon: Icons.facebook_outlined,
                          onPressed: () {
                            // Apple login logic
                          },
                        ),
                      ],
                    ),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                  ],
                ),
              ),
            ],
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
          borderSide: const BorderSide(color: Color(0xFF8A1538), width: 2),
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

  Widget _buildAuthButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleSignIn,
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
        backgroundColor: const Color(0xFF8A1538),
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
=======
<<<<<<< HEAD
          ? const CircularProgressIndicator(color: Color(0xFF8A1538))
=======
<<<<<<< HEAD
          ? const CircularProgressIndicator(color: Color(0xFF8A1538))
=======
          ? const CircularProgressIndicator(color: Colors.white)
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
          : const Text(
              'Sign In',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
<<<<<<< HEAD
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
=======
<<<<<<< HEAD
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
=======
<<<<<<< HEAD
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
=======
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.grey[600]),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/signUp');
          },
          child: const Text(
            'Sign Up',
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
              color: Color(0xFF8A1538),
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

  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final result = await _userService.loginUser(email, password, context);
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

<<<<<<< HEAD
 
}
=======
<<<<<<< HEAD
 
}
=======
  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
<<<<<<< HEAD
        foregroundColor: const Color(0xFF8A1538),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
=======
        foregroundColor: Colors.black,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(15),
        side: BorderSide(color: Colors.grey.shade300),
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
      ),
      child: Icon(icon, size: 30),
    );
  }
}
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
//   Widget _buildAuthButton() {
//     return ElevatedButton(
//       onPressed: _isLoading ? null : _handleAuth,
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
//           : Text(
//               isLogin ? 'Sign In' : 'Create Account',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
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
//           value: 'Student',
//           child: Text('Student'),
//         ),
//         DropdownMenuItem(
//           value: 'Driver',
//           child: Text('Driver'),
//         ),
//       ],
//     );
//   }

//   Widget _buildToggleButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           isLogin ? "Don't have an account? " : 'Already have an account? ',
//           style: TextStyle(color: Colors.grey[600]),
//         ),
//         TextButton(
//           onPressed: () {
//             setState(() {
//               isLogin = !isLogin;
//             });
//           },
//           child: Text(
//             isLogin ? 'Sign Up' : 'Sign In',
//             style: const TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<void> _handleAuth() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() => _isLoading = true);

//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();

//       if (isLogin) {
//         // Handle login
//         final result = await _userService.loginUser(email, password,context);
//         _showMessage(result);

//       } else {
//         // Handle sign up
//         final user = UserModel(
//           userID: '',
//           name: _nameController.text.trim(),
//           email: email,
//           age: 0, // Replace with age if required
//           gender: 'Unspecified',
//           phone: _phoneController.text.trim(),
//           address: 'Unspecified', // Replace with address if required
//         );

//         final result = await _userService.registerUser(user, password);
//         _showMessage(result);

//       }
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
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
