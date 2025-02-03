<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
// import 'package:flutter/material.dart';

// class PaymentScreen extends StatelessWidget {
//   const PaymentScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context); // Return to previous screen
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Center(
//               child: Text(
//                 'Payment Methods',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             _buildPaymentMethod("JazzCash", "******* 684", Icons.credit_card,
//                 const Color(0xFFE53935)),
//             _buildPaymentMethod("EasyPaisa", "******* 684", Icons.credit_card,
//                 const Color.fromARGB(255, 13, 110, 0)),
//             _buildPaymentMethod("NayaPay", "******* 684", Icons.credit_card,
//                 const Color.fromARGB(255, 228, 91, 0)),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Payment Successful!')),
//                   );
//                   Navigator.pushNamed(context, "/mainNavigation");
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF0047BA),
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Pay Now',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPaymentMethod(
//       String title, String subtitle, IconData icon, Color color) {
//     return Card(
//       color: color,
//       margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListTile(
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: const TextStyle(color: Colors.white),
//         ),
//         trailing: Icon(icon, color: Colors.white),
//       ),
//     );
//   }
// }

<<<<<<< HEAD
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

class PaymentScreen extends StatefulWidget {
  final double amount;
  final String bookingId;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.bookingId,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool _isProcessing = false;
  bool _paymentSuccess = false;
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
=======
<<<<<<< HEAD
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
=======
<<<<<<< HEAD
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
=======
<<<<<<< HEAD
// ignore_for_file: prefer_const_constructors

<<<<<<< HEAD
=======
>>>>>>> f14665d864e51132ab3f6380a09b0d255bafd81e
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
=======
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
=======
import 'package:flutter/material.dart';


class PaymentScreen extends StatelessWidget {


>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  const PaymentScreen({Key? key}) : super(key: key);
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        title: const Text('Payment'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _paymentSuccess
          ? _buildSuccessScreen()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    _buildAmountDisplay(),
                    const SizedBox(height: 20),
                    _buildCardNumberField(),
                    const SizedBox(height: 15),
                    _buildExpiryAndCvcRow(),
                    const SizedBox(height: 15),
                    _buildNameField(),
                    const SizedBox(height: 30),
                    _buildPayButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildAmountDisplay() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Amount:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Rs${widget.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Return to previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
            const Center(
              child: Text(
                'Payment Methods',
                style: TextStyle(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
            Center(
              child: Text(
                'Payment Methods',
                style: const TextStyle(
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPaymentMethod("JazzCash", "******* 684", Icons.credit_card,
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                const Color(0xFFE53935)),
            _buildPaymentMethod("EasyPaisa", "******* 684", Icons.credit_card,
                const Color.fromARGB(255, 13, 110, 0)),
            _buildPaymentMethod("NayaPay", "******* 684", Icons.credit_card,
                const Color.fromARGB(255, 228, 91, 0)),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                Color(0xFFE53935)),
            _buildPaymentMethod("EasyPaisa", "******* 684", Icons.credit_card,
                Color.fromARGB(255, 13, 110, 0)),
            _buildPaymentMethod("NayaPay", "******* 684", Icons.credit_card,
                Color.fromARGB(255, 228, 91, 0)),
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking for driver.name',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Amount: \$driver.monthlyFee',
              style: TextStyle(fontSize: 18, color: Colors.grey[800]),
            ),
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
<<<<<<< HEAD
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful!')),
                  );
                  Navigator.pushNamed(context, "/mainNavigation");
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
                  // Handle payment logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful!')),
                  );
                  Navigator.pop(context); // Return to previous screen
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0047BA),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

  Widget _buildCardNumberField() {
    return TextFormField(
      controller: _cardNumberController,
      decoration: InputDecoration(
        labelText: 'Card Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.credit_card),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter card number';
        }
        if (value.length < 16) {
          return 'Invalid card number';
        }
        return null;
      },
    );
  }

  Widget _buildExpiryAndCvcRow() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _expiryController,
            decoration: InputDecoration(
              labelText: 'MM/YY',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(Icons.calendar_today),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter expiry date';
              }
              if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
                return 'Invalid format';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: TextFormField(
            controller: _cvcController,
            decoration: InputDecoration(
              labelText: 'CVC',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: const Icon(Icons.lock),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter CVC';
              }
              if (value.length != 3) {
                return 'Invalid CVC';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Cardholder Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter name';
        }
        return null;
      },
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      onPressed: _isProcessing ? null : _processPayment,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0047BA),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: _isProcessing
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text(
              'Pay Now',
              style: TextStyle(fontSize: 18),
            ),
    );
  }

  Widget _buildSuccessScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 80),
          const SizedBox(height: 20),
          const Text(
            'Payment Successful!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Rs${widget.amount.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 20, color: Colors.green),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Return to Booking'),
          ),
        ],
      ),
    );
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;
<<<<<<< HEAD
=======

>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    setState(() => _isProcessing = true);

    // Simulate payment processing delay
    await Future.delayed(const Duration(seconds: 2));

    // Record payment in Firestore
    await FirebaseFirestore.instance.collection('payments').add({
      'bookingId': widget.bookingId,
      'amount': widget.amount,
      'timestamp': DateTime.now(),
      'status': 'completed',
      'studentId': FirebaseAuth.instance.currentUser!.uid,
      'driverId': widget.bookingId.split('_').first,
    });

    // Update booking status
    await FirebaseFirestore.instance
        .collection('booking_requests')
        .doc(widget.bookingId)
        .update({'status': 'confirmed'});
<<<<<<< HEAD
=======

>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    setState(() {
      _isProcessing = false;
      _paymentSuccess = true;
    });
  }
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
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
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e

  Widget _buildPaymentMethod(
      String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Icon(icon, color: Colors.white),
      ),
    );
  }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
}
