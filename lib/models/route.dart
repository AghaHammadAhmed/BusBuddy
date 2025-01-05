<<<<<<< HEAD

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
  // }
=======
// Define your data model here
>>>>>>> 91ada8e3ae45d451fda9917c6d014f925e30e54c
