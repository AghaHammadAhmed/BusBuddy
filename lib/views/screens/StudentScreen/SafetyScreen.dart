<<<<<<< HEAD
// import 'package:flutter/material.dart';

// class SafetyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: const Text(
//           'Safety',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildButton(Icons.support_agent, 'Support'),
//                 _buildButton(Icons.contacts, 'Emergency contacts'),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.redAccent,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {},
//               icon: const Icon(Icons.warning, color: Colors.white),
//               label: const Text(
//                 'Call emergency',
//                 style: TextStyle(color: Colors.white, fontSize: 18),
//               ),
//             ),
//             const SizedBox(height: 24),
//             const Text(
//               'How you are protected',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//                 children: [
//                   _buildGridTile(Icons.info, 'Before the ride'),
//                   _buildGridTile(Icons.verified_user,
//                       'Driver identity and selfie verification'),
//                   _buildGridTile(Icons.shield, 'Safety features'),
//                   _buildGridTile(Icons.chat, '24/7 emergency chat'),
//                   _buildGridTile(Icons.car_repair, 'How we check cars'),
//                   _buildGridTile(Icons.message, 'Safe communications'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(IconData icon, String label) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.grey[850],
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//       ),
//       onPressed: () {},
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, color: Colors.white),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGridTile(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[850],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.green, size: 36),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: const TextStyle(color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }

=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
import 'package:flutter/material.dart';

class SafetyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
<<<<<<< HEAD
        backgroundColor: const Color(0xFF8A1538),
        title: const Text(
          'Safety',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
=======
        backgroundColor: Colors.transparent,
        title: const Text(
          'Safety',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(Icons.support_agent, 'Support'),
<<<<<<< HEAD
                _buildButton(Icons.contacts, 'Emergency Contacts'),
=======
                _buildButton(Icons.contacts, 'Emergency contacts'),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
<<<<<<< HEAD
                backgroundColor: Color.fromARGB(255, 255, 0, 0),
=======
                backgroundColor: Colors.redAccent,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
<<<<<<< HEAD
              onPressed: () {
                // Handle emergency call action
              },
              icon: const Icon(Icons.warning, color: Colors.white),
              label: const Text(
                'Call Emergency',
=======
              onPressed: () {},
              icon: const Icon(Icons.warning, color: Colors.white),
              label: const Text(
                'Call emergency',
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
<<<<<<< HEAD
              'How You Are Protected',
              style: TextStyle(
                color: Color(0xFF8A1538),
=======
              'How you are protected',
              style: TextStyle(
                color: Colors.black,
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
<<<<<<< HEAD
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _buildGridTile(Icons.info, 'Before the Ride'),
                  _buildGridTile(
                      Icons.verified_user, 'Driver Identity Verification'),
                  _buildGridTile(Icons.shield, 'Safety Features'),
                  _buildGridTile(Icons.chat, '24/7 Emergency Chat'),
                  _buildGridTile(Icons.car_repair, 'How We Check Cars'),
                  _buildGridTile(Icons.message, 'Safe Communications'),
=======
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  _buildGridTile(Icons.info, 'Before the ride'),
                  _buildGridTile(Icons.verified_user,
                      'Driver identity and selfie verification'),
                  _buildGridTile(Icons.shield, 'Safety features'),
                  _buildGridTile(Icons.chat, '24/7 emergency chat'),
                  _buildGridTile(Icons.car_repair, 'How we check cars'),
                  _buildGridTile(Icons.message, 'Safe communications'),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
<<<<<<< HEAD
        backgroundColor: const Color(0xFF8A1538),
=======
        backgroundColor: Colors.grey[850],
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
<<<<<<< HEAD
      onPressed: () {
        // Handle button action
      },
=======
      onPressed: () {},
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildGridTile(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
<<<<<<< HEAD
        color: const Color(0xFF8A1538),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
=======
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
<<<<<<< HEAD
          Icon(icon, color: Colors.white, size: 36),
=======
          Icon(icon, color: Colors.green, size: 36),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
<<<<<<< HEAD
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
=======
            style: const TextStyle(color: Colors.white),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
          ),
        ],
      ),
    );
  }
}
