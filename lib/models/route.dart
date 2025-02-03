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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

  // Future<void> _bookDriver(String driverId) async {
  //   final TextEditingController durationController = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       title: const Text(
  //         'Book Driver',
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20,
  //         ),
  //         textAlign: TextAlign.center,
  //       ),
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [

  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               IconButton(
  //                 icon: const Icon(Icons.remove_circle_outline,
  //                     color: Colors.red),
  //                 onPressed: () {
  //                   int currentValue =
  //                       int.tryParse(durationController.text) ?? 1;
  //                   if (currentValue > 1) {
  //                     durationController.text = (currentValue - 1).toString();
  //                   }
  //                 },
  //               ),
  //               SizedBox(
  //                 width: 80,
  //                 child: TextField(
  //                   readOnly: true,
  //                   controller: durationController,
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                       fontSize: 18, fontWeight: FontWeight.bold),
  //                   decoration: InputDecoration(
  //                     labelText: 'Months',
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.circular(10),
  //                     ),
  //                     contentPadding: const EdgeInsets.symmetric(vertical: 10),
  //                   ),
  //                   keyboardType: TextInputType.number,
  //                 ),
  //               ),
  //               IconButton(
  //                 icon:
  //                     const Icon(Icons.add_circle_outline, color: Colors.green),
  //                 onPressed: () {
  //                   int currentValue =
  //                       int.tryParse(durationController.text) ?? 1;
  //                   durationController.text = (currentValue + 1).toString();
  //                 },
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 16),

  //           // Price Estimation Section
  //           _buildPriceEstimationSection(
  //               int.tryParse(durationController.text) ?? 1),
  //         ],
  //       ),
  //       actions: [

  //         Row(
  //           children: [
  //             Expanded(
  //               child: TextButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 style: TextButton.styleFrom(
  //                   foregroundColor: Colors.red,
  //                 ),
  //                 child: const Text('Cancel'),
  //               ),
  //             ),
  //             const SizedBox(width: 8),
  //             Expanded(
  //               child: ElevatedButton(
  //                 onPressed: () async {
  //                   Navigator.of(context).pop();

  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: const Color(0xFF0047BA),
  //                 ),
  //                 child: const Text('Confirm'),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPriceEstimationSection(int months) {
  //   // Assuming a base monthly rate - replace with actual calculation
  //   const baseMonthlyRate = 3000.0;
  //   final totalPrice = baseMonthlyRate * months;

  //   return Container(
  //     padding: const EdgeInsets.all(12),
  //     decoration: BoxDecoration(
  //       color: Colors.grey[100],
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Column(
  //       children: [
  //         Text(
  //           'Estimated Total Price',
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             color: Colors.grey[700],
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         RichText(
  //           text: TextSpan(
  //             style: const TextStyle(color: Colors.black),
  //             children: [
  //               TextSpan(
  //                 text: 'Rs${totalPrice.toStringAsFixed(2)}',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.green[700],
  //                 ),
  //               ),
  //               TextSpan(
  //                 text: ' (Rs${baseMonthlyRate.toStringAsFixed(0)}/month)',
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   color: Colors.grey[600],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
<<<<<<< HEAD
  // }
=======
<<<<<<< HEAD
  // }
=======
<<<<<<< HEAD
  // }
=======
<<<<<<< HEAD
  // }
=======
<<<<<<< HEAD
  // }
=======
  // }
=======
// Define your data model here
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
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
