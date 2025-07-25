import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/note_service.dart';
import 'utils/theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

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
            theme: themeManager.getTheme(),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}