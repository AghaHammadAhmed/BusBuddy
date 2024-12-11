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
  Set<int> _selectedDates = {};

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _initializeDefaultSelection();
  }

  void _initializeDefaultSelection() {
    // Select all weekdays in the current month by default
    int daysInMonth =
        DateTime(_currentDate.year, _currentDate.month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date = DateTime(_currentDate.year, _currentDate.month, day);
      if (date.weekday >= DateTime.monday && date.weekday <= DateTime.friday) {
        _selectedDates.add(day);
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

  void _saveSchedule() {
    // Implement your save logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Schedule saved for ${_selectedDates.length} days'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Transportation Schedule',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
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
              style: TextStyle(
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
          SizedBox(
            height: 14,
          ),

          // Calendar Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          : (isSelected ? Color(0xFF0047BA) : Colors.white),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isWeekend
                            ? Colors.grey[300]!
                            : (isSelected ? Color(0xFF0047BA) : Colors.grey),
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

          // Weekday Headers

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
                      foregroundColor: Color(0xFF0047BA),
                      side: BorderSide(color: Color(0xFF0047BA)),
                    ),
                    child: Text('Reset to Weekdays'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveSchedule,
                    child: Text('Save Schedule'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0047BA)),
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
