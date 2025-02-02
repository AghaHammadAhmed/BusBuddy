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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              ),
            ),
          ],
        ),
      ),
    );
  }

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

    setState(() {
      _isProcessing = false;
      _paymentSuccess = true;
    });
  }
}
