import 'package:flutter/foundation.dart';

class TaskService extends ChangeNotifier {
  final Map<DateTime, List<String>> _tasks = {};

  List<String> getTasksForDate(DateTime date) {
    final dateKey = DateTime(date.year, date.month, date.day);
    return _tasks[dateKey] ?? [];
  }

  void addTask(DateTime date, String task) {
    final dateKey = DateTime(date.year, date.month, date.day);
    if (_tasks.containsKey(dateKey)) {
      _tasks[dateKey]!.add(task);
    } else {
      _tasks[dateKey] = [task];
    }
    notifyListeners();
  }

  void removeTask(DateTime date, int index) {
    final dateKey = DateTime(date.year, date.month, date.day);
    if (_tasks.containsKey(dateKey) && _tasks[dateKey]!.length > index) {
      _tasks[dateKey]!.removeAt(index);
      if (_tasks[dateKey]!.isEmpty) {
        _tasks.remove(dateKey);
      }
      notifyListeners();
    }
  }
}