<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransportationCalendarPage extends StatefulWidget {
<<<<<<< HEAD
  
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
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
  Set<int> _selectedDates = {};
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
    setState(() {
      userId = auth.currentUser!.uid;
    });
=======
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
    _currentDate = DateTime.now();
    _initializeDefaultSelection();
  }

<<<<<<< HEAD
  void _initializeDefaultSelection() async {
    // Replace with the actual user ID
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      final data = userDoc.data();
      if (data != null && data['selectedDates'] != null) {
        setState(() {
          _selectedDates = Set<int>.from(data['selectedDates']);
        });
      }
    } else {
      super.initState();
      _currentDate = DateTime.now();
      _initializeDefaultSelection(); // Default logic for weekdays
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
      final userID = userId; // Replace with the actual user ID
      final userCollection = FirebaseFirestore.instance.collection('users');

      await userCollection.doc(userID).update({
        'selectedDates': _selectedDates.toList(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Schedule saved for ${_selectedDates.length} days'),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save schedule: $e'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Transportation Schedule',
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
        ),
      ),
      body: Column(
        children: [
          // Month and Year Display
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              DateFormat('MMMM yyyy').format(_currentDate),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
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
          const SizedBox(
            height: 14,
          ),

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
                if (index < _getFirstDayOffset()) {
                  // Empty cells before the first day of the month
                  return Container();
                }

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
                              ? const Color(0xFF0047BA)
                              : Colors.white),
=======
                          : (isSelected ? const Color(0xFF0047BA) : Colors.white),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isWeekend
                            ? Colors.grey[300]!
<<<<<<< HEAD
                            : (isSelected
                                ? const Color(0xFF0047BA)
                                : Colors.grey),
=======
                            : (isSelected ? const Color(0xFF0047BA) : Colors.grey),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isWeekend
                              ? Colors.grey
                              : (isSelected ? Colors.white : Colors.black),
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
          // Weekday Headers

>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
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
                    child: const Text('Save Schedule'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0047BA)),
>>>>>>> 931b82405e7a8edfc4743cbab7ab90b315791c7c
                  ),
                ),
              ],
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
