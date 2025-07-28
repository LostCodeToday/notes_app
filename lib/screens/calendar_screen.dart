import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'daily_tasks_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ИЗМЕНЕНИЕ - ДОБАВЛЕНИЕ ОТЛАДОЧНОГО ВЫВОДА И КОРРЕКЦИЯ TABLECALENDAR
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              print('Day selected: $selectedDay'); // ОТЛАДОЧНЫЙ ВЫВОД
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // Обновляем focusedDay
              });
              // ИЗМЕНЕНИЕ - ПРОВЕРКА КОНТЕКСТА ПЕРЕД НАВИГАЦИЕЙ
              if (_selectedDay != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyTasksScreen(selectedDate: _selectedDay),
                  ),
                ).then((_) => setState(() {})); // Обновление состояния после возврата
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          // КОНЕЦ ИЗМЕНЕНИЯ
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Add note to date (TODO)')),
              );
            },
            child: const Text('Add Note'),
          ),
        ],
      ),
    );
  }
}