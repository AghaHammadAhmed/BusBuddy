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
  final _emailController = TextEditingController(text: "student@gmail.com");
  final _passwordController = TextEditingController(text: "123456789");
  final UserService _userService = UserService();
  bool _isLoading = false;
  static late SharedPreferences _prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8A1538),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Welcome back',
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
              'Sign In',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
    );
  }

  Widget _buildToggleButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/signUp');
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
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

 
}
