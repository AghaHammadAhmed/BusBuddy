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
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransportationCalendarPage extends StatefulWidget {
  @override
  _TransportationCalendarPageState createState() =>
      _TransportationCalendarPageState();
}

class _TransportationCalendarPageState
    extends State<TransportationCalendarPage> {
  late DateTime _currentDate;
  FirebaseAuth auth = FirebaseAuth.instance;
  Set<int> _selectedDates = {};
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = auth.currentUser!.uid;
    _currentDate = DateTime.now();
    _initializeDefaultSelection();
  }

  void _initializeDefaultSelection() async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final data = userDoc.data();
      if (data != null && data['selectedDates'] != null) {
        setState(() {
          _selectedDates = Set<int>.from(data['selectedDates']);
        });
      }
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

  void _saveSchedule() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'selectedDates': _selectedDates.toList(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule saved for ${_selectedDates.length} days'),
          backgroundColor: const Color(0xFF8A1538),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save schedule: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Transportation Schedule',
          style: TextStyle(color: Color(0xFF8A1538)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF8A1538)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat('MMMM yyyy').format(_currentDate),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8A1538),
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
          const SizedBox(height: 14),

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
                if (index < _getFirstDayOffset()) return Container();

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
                          : (isSelected
                              ? const Color(0xFF8A1538)
                              : Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isWeekend
                            ? Colors.grey[300]!
                            : (isSelected
                                ? const Color(0xFF8A1538)
                                : Colors.grey[300]!),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isWeekend
                              ? Colors.grey[500]
                              : (isSelected ? Colors.white : Colors.black),
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  int _getDaysInMonth() {
    return DateTime(_currentDate.year, _currentDate.month + 1, 0).day;
  }

  int _getFirstDayOffset() {
    DateTime firstDayOfMonth =
        DateTime(_currentDate.year, _currentDate.month, 1);
    return firstDayOfMonth.weekday % 7;
  }
}
