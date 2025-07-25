import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData getTheme() => _themeData;

  void toggleTheme() {
    _themeData = _themeData.brightness == Brightness.light
        ? ThemeData.dark()
        : ThemeData.light();
    notifyListeners();
  }
}