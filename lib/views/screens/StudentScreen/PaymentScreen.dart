// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment Successful!')),
                  );
                  Navigator.pushNamed(context, "/mainNavigation");
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
}
