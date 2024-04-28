import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MoodCalendarPage extends StatefulWidget {
  @override
  _MoodCalendarPageState createState() => _MoodCalendarPageState();
}

class _MoodCalendarPageState extends State<MoodCalendarPage> {
  final Map<DateTime, Color> _moodColors = {};
  Color? _selectedColor;

  void _handleMoodSelected(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _handleDateSelected(DateTime selectedDate, DateTime focusedDay) {
    if (_selectedColor != null) {
      setState(() {
        _moodColors[selectedDate] = _selectedColor!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    // Check if there's a color for the current date
    if (_moodColors[currentDate] == null && _selectedColor != null) {
      // Set the color for the current date automatically
      _moodColors[currentDate] = _selectedColor!;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: DateTime.now(),
            calendarStyle: CalendarStyle(),
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final color = _moodColors[date];
                if (color != null) {
                  return CircleAvatar(
                    backgroundColor: color,
                    radius: 5,
                  );
                }
                return null;
              },
            ),
            onDaySelected: _handleDateSelected,
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _handleMoodSelected(Colors.green),
                child: Text('Happy'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
              ),
              ElevatedButton(
                onPressed: () => _handleMoodSelected(Colors.blue),
                child: Text('Sad'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
              ),
              ElevatedButton(
                onPressed: () => _handleMoodSelected(Colors.amber),
                child: Text('Anxious'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}