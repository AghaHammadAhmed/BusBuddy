// import 'package:flutter/material.dart';
// Widget buildManageCard({
//   required IconData icon,
//   required String label,
//   required VoidCallback onTap,
//   required double screenWidth,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       width: (screenWidth - (screenWidth * 0.1)) / 2,
//       padding: EdgeInsets.symmetric(
//         vertical: screenWidth * 0.04,
//         horizontal: screenWidth * 0.03,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey[300]!),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 5,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: screenWidth * 0.08, color: Colors.blue),
//           SizedBox(height: screenWidth * 0.02),
//           Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: screenWidth * 0.04,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';

Widget buildManageCard({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required double screenWidth,
}) {
  return Material(
    color: const Color(0xFF8A1538),
    borderRadius: BorderRadius.circular(12),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      splashColor: const Color(0xFF8A1538).withOpacity(0.1), // Ripple effect
      child: Container(
        width: (screenWidth - (screenWidth * 0.1)) / 2,
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.03,
          horizontal: screenWidth * 0.04,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFB23254)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: screenWidth * 0.08,
              color: Colors.white,
            ),
            SizedBox(height: screenWidth * 0.02),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
