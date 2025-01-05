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
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
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
            Center(
              child: Text(
                'Payment Methods',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildPaymentMethod("JazzCash", "******* 684", Icons.credit_card,
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
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful!')),
                  );
                  Navigator.pushNamed(context, "/mainNavigation");
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
=======
<<<<<<< HEAD
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4

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
=======
>>>>>>> 35279862e86385b28ab01148b276f1b391af24d0
>>>>>>> 68562972bec7d14ae995e33f438c8332a2044b6a
>>>>>>> 4d8a1679c8fd3545bb711970263e6223a7d445a4
}
