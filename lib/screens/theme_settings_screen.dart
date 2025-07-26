import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/theme_manager.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      // ИЗМЕНЕНИЕ - APPBAR ДЛЯ ЭКРАНА НАСТРОЕК
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      // КОНЕЦ ИЗМЕНЕНИЯ
      body: Padding(
        // ИЗМЕНЕНИЕ - КОНТЕЙНЕР ДЛЯ ПЕРЕКЛЮЧАТЕЛЕЙ
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Theme',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Light Theme'),
              trailing: Switch(
                value: themeManager.themeMode == ThemeMode.light,
                onChanged: (value) {
                  if (value) {
                    themeManager.setTheme(ThemeMode.light);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch(
                value: themeManager.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  if (value) {
                    themeManager.setTheme(ThemeMode.dark);
                  }
                },
              ),
            ),
          ],
        ),
        // КОНЕЦ ИЗМЕНЕНИЯ
      ),
    );
  }
}