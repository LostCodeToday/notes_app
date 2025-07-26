import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system; // Добавляем поддержку ThemeMode

  // Геттер для получения текущего режима темы
  ThemeMode get themeMode => _themeMode;

  // Метод для установки конкретной темы
  void setTheme(ThemeMode mode) {
    _themeMode = mode; // Обновляем режим темы
    notifyListeners(); // Уведомляем все виджеты об изменении
  }

  // Метод для получения ThemeData на основе текущего режима
  ThemeData getTheme(BuildContext context) {
    switch (_themeMode) {
      case ThemeMode.light:
        return ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        );
      case ThemeMode.dark:
        return ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.grey[900],
        );
      case ThemeMode.system:
      default:
        return ThemeData(
          brightness: MediaQuery.of(context).platformBrightness,
          primarySwatch: Colors.blue,
        );
    }
  }
}