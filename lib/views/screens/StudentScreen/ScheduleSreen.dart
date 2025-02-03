<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class TransportationCalendarPage extends StatefulWidget {
  
//   @override
//   _TransportationCalendarPageState createState() =>
//       _TransportationCalendarPageState();
// }

// class _TransportationCalendarPageState
//     extends State<TransportationCalendarPage> {
//   late DateTime _currentDate;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   Set<int> _selectedDates = {};
//   String? userId;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       userId = auth.currentUser!.uid;
//     });
//     _currentDate = DateTime.now();
//     _initializeDefaultSelection();
//   }

//   void _initializeDefaultSelection() async {
//     // Replace with the actual user ID
//     final userDoc =
//         await FirebaseFirestore.instance.collection('users').doc(userId).get();

//     if (userDoc.exists) {
//       final data = userDoc.data();
//       if (data != null && data['selectedDates'] != null) {
//         setState(() {
//           _selectedDates = Set<int>.from(data['selectedDates']);
//         });
//       }
//     } else {
//       super.initState();
//       _currentDate = DateTime.now();
//       _initializeDefaultSelection(); // Default logic for weekdays
//     }
//   }

//   void _toggleDateSelection(int day) {
//     setState(() {
//       if (_selectedDates.contains(day)) {
//         _selectedDates.remove(day);
//       } else {
//         _selectedDates.add(day);
//       }
//     });
//   }

//   void _resetToWeekdays() {
//     setState(() {
//       _selectedDates.clear();
//       _initializeDefaultSelection();
//     });
//   }

//   void _saveSchedule() async {
//     try {
//       final userID = userId; // Replace with the actual user ID
//       final userCollection = FirebaseFirestore.instance.collection('users');

//       await userCollection.doc(userID).update({
//         'selectedDates': _selectedDates.toList(),
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Schedule saved for ${_selectedDates.length} days'),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to save schedule: $e'),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: const Text(
//           'Transportation Schedule',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Month and Year Display
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               DateFormat('MMMM yyyy').format(_currentDate),
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
//                   .map((day) => Text(
//                         day,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.grey[600],
//                         ),
//                       ))
//                   .toList(),
//             ),
//           ),
//           const SizedBox(
//             height: 14,
//           ),

//           // Calendar Grid
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 7,
//                 crossAxisSpacing: 8,
//                 mainAxisSpacing: 8,
//               ),
//               itemCount: _getDaysInMonth() + _getFirstDayOffset(),
//               itemBuilder: (context, index) {
//                 if (index < _getFirstDayOffset()) {
//                   // Empty cells before the first day of the month
//                   return Container();
//                 }

//                 int day = index - _getFirstDayOffset() + 1;
//                 DateTime date =
//                     DateTime(_currentDate.year, _currentDate.month, day);
//                 bool isWeekend = date.weekday == DateTime.saturday ||
//                     date.weekday == DateTime.sunday;
//                 bool isSelected = _selectedDates.contains(day);

//                 return GestureDetector(
//                   onTap: isWeekend ? null : () => _toggleDateSelection(day),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: isWeekend
//                           ? Colors.grey[300]
//                           : (isSelected
//                               ? const Color(0xFF0047BA)
//                               : Colors.white),
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: isWeekend
//                             ? Colors.grey[300]!
//                             : (isSelected
//                                 ? const Color(0xFF0047BA)
//                                 : Colors.grey),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         '$day',
//                         style: TextStyle(
//                           color: isWeekend
//                               ? Colors.grey
//                               : (isSelected ? Colors.white : Colors.black),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Action Buttons
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _resetToWeekdays,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: const Color(0xFF0047BA),
//                       side: const BorderSide(color: Color(0xFF0047BA)),
//                     ),
//                     child: const Text('Reset to Weekdays'),
//                   ),
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: _saveSchedule,
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF0047BA)),
//                     child: const Text('Save Schedule'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   int _getDaysInMonth() {
//     return DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
//   }

//   int _getFirstDayOffset() {
//     DateTime firstDayOfMonth =
//         DateTime(_currentDate.year, _currentDate.month, 1);
//     return firstDayOfMonth.weekday % 7;
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransportationCalendarPage extends StatefulWidget {
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
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  @override
  _TransportationCalendarPageState createState() =>
      _TransportationCalendarPageState();
}

class _TransportationCalendarPageState
    extends State<TransportationCalendarPage> {
  late DateTime _currentDate;
<<<<<<< HEAD
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<int> _selectedDates = {};
  String? userId;
=======
<<<<<<< HEAD
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<int> _selectedDates = {};
  String? userId;
=======
<<<<<<< HEAD
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<int> _selectedDates = {};
  String? userId;
=======
<<<<<<< HEAD
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<int> _selectedDates = {};
  String? userId;
=======
<<<<<<< HEAD
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<int> _selectedDates = {};
  String? userId;
=======
  Set<int> _selectedDates = {};
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    userId = auth.currentUser!.uid;
=======
<<<<<<< HEAD
    userId = auth.currentUser!.uid;
=======
<<<<<<< HEAD
    setState(() {
      userId = auth.currentUser!.uid;
    });
=======
<<<<<<< HEAD
    setState(() {
      userId = auth.currentUser!.uid;
    });
=======
<<<<<<< HEAD
    setState(() {
      userId = auth.currentUser!.uid;
    });
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    _currentDate = DateTime.now();
    _initializeDefaultSelection();
  }

<<<<<<< HEAD
  void _initializeDefaultSelection() async {
=======
<<<<<<< HEAD
  void _initializeDefaultSelection() async {
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  void _initializeDefaultSelection() async {
    // Replace with the actual user ID
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final data = userDoc.data();
      if (data != null && data['selectedDates'] != null) {
        setState(() {
          _selectedDates = Set<int>.from(data['selectedDates']);
        });
      }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
    } else {
      super.initState();
      _currentDate = DateTime.now();
      _initializeDefaultSelection(); // Default logic for weekdays
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
  void _initializeDefaultSelection() {
    // Select all weekdays in the current month by default
    int daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(_currentDate.year, _currentDate.month, day);
      if (date.weekday >= DateTime.monday && date.weekday <= DateTime.friday) {
        _selectedDates.add(day);
      }
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
    }
  }

  void _toggleDateSelection(int day) {
    setState(() {
      if (_selectedDates.contains(day)) {
        _selectedDates.remove(day);
      } else {
        _selectedDates.add(day);
      }
    });
  }

  void _resetToWeekdays() {
    setState(() {
      _selectedDates.clear();
      _initializeDefaultSelection();
    });
  }

<<<<<<< HEAD
  void _saveSchedule() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
=======
<<<<<<< HEAD
  void _saveSchedule() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
  void _saveSchedule() async {
    try {
      final userID = userId; // Replace with the actual user ID
      final userCollection = FirebaseFirestore.instance.collection('users');

      await userCollection.doc(userID).update({
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        'selectedDates': _selectedDates.toList(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule saved for ${_selectedDates.length} days'),
<<<<<<< HEAD
          backgroundColor: const Color(0xFF8A1538),
=======
<<<<<<< HEAD
          backgroundColor: const Color(0xFF8A1538),
=======
          duration: const Duration(seconds: 2),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save schedule: $e'),
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
          backgroundColor: Colors.red,
        ),
      );
    }
<<<<<<< HEAD
=======
=======
          duration: const Duration(seconds: 2),
        ),
      );
    }
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
  void _saveSchedule() {
    // Implement your save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Schedule saved for ${_selectedDates.length} days'),
        duration: const Duration(seconds: 2),
      ),
    );
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Transportation Schedule',
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
          style: TextStyle(color: Color(0xFF8A1538)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF8A1538)),
          onPressed: () => Navigator.pop(context),
<<<<<<< HEAD
=======
=======
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
        ),
      ),
      body: Column(
        children: [
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
          // Information Header
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF5F5F5),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF8A1538)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Select your regular transportation days. Weekends are automatically disabled.',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),

          // Calendar Section
<<<<<<< HEAD
=======
=======
          // Month and Year Display
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat('MMMM yyyy').format(_currentDate),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
<<<<<<< HEAD
                color: Color(0xFF8A1538),
=======
<<<<<<< HEAD
                color: Color(0xFF8A1538),
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) => Text(
                        day,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ))
                  .toList(),
            ),
          ),
<<<<<<< HEAD
          const SizedBox(height: 14),
=======
<<<<<<< HEAD
          const SizedBox(height: 14),
=======
          const SizedBox(
            height: 14,
          ),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

          // Calendar Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _getDaysInMonth() + _getFirstDayOffset(),
              itemBuilder: (context, index) {
<<<<<<< HEAD
                if (index < _getFirstDayOffset()) return Container();
=======
<<<<<<< HEAD
                if (index < _getFirstDayOffset()) return Container();
=======
                if (index < _getFirstDayOffset()) {
                  // Empty cells before the first day of the month
                  return Container();
                }
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33

                int day = index - _getFirstDayOffset() + 1;
                DateTime date =
                    DateTime(_currentDate.year, _currentDate.month, day);
                bool isWeekend = date.weekday == DateTime.saturday ||
                    date.weekday == DateTime.sunday;
                bool isSelected = _selectedDates.contains(day);

                return GestureDetector(
                  onTap: isWeekend ? null : () => _toggleDateSelection(day),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isWeekend
                          ? Colors.grey[300]
<<<<<<< HEAD
                          : (isSelected
                              ? const Color(0xFF8A1538)
                              : Colors.white),
=======
<<<<<<< HEAD
                          : (isSelected
                              ? const Color(0xFF8A1538)
                              : Colors.white),
=======
<<<<<<< HEAD
                          : (isSelected
                              ? const Color(0xFF0047BA)
                              : Colors.white),
=======
<<<<<<< HEAD
                          : (isSelected
                              ? const Color(0xFF0047BA)
                              : Colors.white),
=======
<<<<<<< HEAD
                          : (isSelected
                              ? const Color(0xFF0047BA)
                              : Colors.white),
=======
                          : (isSelected ? const Color(0xFF0047BA) : Colors.white),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isWeekend
                            ? Colors.grey[300]!
<<<<<<< HEAD
                            : (isSelected
                                ? const Color(0xFF8A1538)
                                : Colors.grey[300]!),
=======
<<<<<<< HEAD
                            : (isSelected
                                ? const Color(0xFF8A1538)
                                : Colors.grey[300]!),
=======
<<<<<<< HEAD
                            : (isSelected
                                ? const Color(0xFF0047BA)
                                : Colors.grey),
=======
<<<<<<< HEAD
                            : (isSelected
                                ? const Color(0xFF0047BA)
                                : Colors.grey),
=======
<<<<<<< HEAD
                            : (isSelected
                                ? const Color(0xFF0047BA)
                                : Colors.grey),
=======
                            : (isSelected ? const Color(0xFF0047BA) : Colors.grey),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isWeekend
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                              ? Colors.grey[500]
                              : (isSelected ? Colors.white : Colors.black),
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
<<<<<<< HEAD
=======
=======
                              ? Colors.grey
                              : (isSelected ? Colors.white : Colors.black),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
          // Statistics and Actions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard('Selected Days', '${_selectedDates.length}'),
                    _buildStatCard('Remaining Days',
                        '${_getDaysInMonth() - _selectedDates.length}'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _resetToWeekdays,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF8A1538)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'Reset Selection',
                          style: TextStyle(color: Color(0xFF8A1538)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveSchedule,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8A1538),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Save Schedule', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
<<<<<<< HEAD
=======
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
          // Weekday Headers

>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
          // Action Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetToWeekdays,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0047BA),
                      side: const BorderSide(color: Color(0xFF0047BA)),
                    ),
                    child: const Text('Reset to Weekdays'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveSchedule,
<<<<<<< HEAD
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA)),
                    child: const Text('Save Schedule'),
=======
<<<<<<< HEAD
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA)),
                    child: const Text('Save Schedule'),
=======
<<<<<<< HEAD
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA)),
                    child: const Text('Save Schedule'),
=======
                    child: const Text('Save Schedule'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA)),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
>>>>>>> 7ba61d27233680a6f95338ab6f282461ebdf19c1
>>>>>>> f5b3073b2ee2890b4e12e83149e551d98825494e
                  ),
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF8A1538).withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF8A1538),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
=======
=======
>>>>>>> cea5cac4621c798d25577eac3c7ecf2e652850e2
>>>>>>> 4fa568564cf43395c9f8cab03b3b027cc7d84a33
  int _getDaysInMonth() {
    return DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
  }

  int _getFirstDayOffset() {
    DateTime firstDayOfMonth =
        DateTime(_currentDate.year, _currentDate.month, 1);
    return firstDayOfMonth.weekday % 7;
  }
}
