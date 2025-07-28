import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/task_service.dart';

class DailyTasksScreen extends StatefulWidget {
  final DateTime? selectedDate;

  const DailyTasksScreen({super.key, this.selectedDate});

  @override
  _DailyTasksScreenState createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends State<DailyTasksScreen> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.selectedDate ?? DateTime.now();
  }

  int _getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day; // Автоматически определяет максимальное число дней
  }

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    final tasksForDate = taskService.getTasksForDate(_currentDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        children: [
          // ИЗМЕНЕНИЕ - ВОЗВРАЩЕНИЕ РАБОЧЕЙ СТРОКИ С DROPDOWNBUTTON
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<int>(
                  value: _currentDate.day,
                  items: List.generate(
                    _getDaysInMonth(_currentDate.year, _currentDate.month),
                    (index) => index + 1,
                  ).map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _currentDate = DateTime(
                          _currentDate.year,
                          _currentDate.month,
                          newValue,
                        );
                        taskService.notifyListeners();
                      });
                    }
                  },
                ),
                DropdownButton<int>(
                  value: _currentDate.month,
                  items: List.generate(12, (index) => index + 1)
                      .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()), // Используем числовое значение месяца
                        );
                      }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        final maxDays = _getDaysInMonth(_currentDate.year, newValue);
                        final newDay = _currentDate.day > maxDays ? maxDays : _currentDate.day;
                        _currentDate = DateTime(
                          _currentDate.year,
                          newValue,
                          newDay,
                        );
                        taskService.notifyListeners();
                      });
                    }
                  },
                ),
                DropdownButton<int>(
                  value: _currentDate.year,
                  items: List.generate(11, (index) => 2020 + index)
                      .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                  onChanged: (int? newValue) {
                    if (newValue != null) {
                      setState(() {
                        final maxDays = _getDaysInMonth(newValue, _currentDate.month);
                        final newDay = _currentDate.day > maxDays ? maxDays : _currentDate.day;
                        _currentDate = DateTime(
                          newValue,
                          _currentDate.month,
                          newDay,
                        );
                        taskService.notifyListeners();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          // КОНЕЦ ИЗМЕНЕНИЯ
          Expanded(
            child: tasksForDate.isEmpty
                ? const Center(child: Text('ещё нет плана'))
                : ListView.builder(
                    itemCount: tasksForDate.length,
                    itemBuilder: (context, index) {
                      final task = tasksForDate[index];
                      return ListTile(
                        title: Text(task),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            taskService.removeTask(_currentDate, index);
                          },
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'New Task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  taskService.addTask(_currentDate, value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}