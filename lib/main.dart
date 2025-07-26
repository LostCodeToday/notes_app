import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/note_service.dart';
import 'utils/theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteService()),
        ChangeNotifierProvider(create: (_) => ThemeManager()),
      ],
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp(
            title: 'Notes App',
            // Используем динамическую тему из ThemeManager
            theme: themeManager.getTheme(context),
            // Режим темы управляется ThemeManager
            themeMode: themeManager.themeMode,
            // Начальный экран без const из-за GlobalKey в HomeScreen
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}