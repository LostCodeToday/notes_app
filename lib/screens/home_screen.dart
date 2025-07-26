import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/note_service.dart';
import '../widgets/note_card.dart';
import 'note_screen.dart';
import '../utils/theme_manager.dart';
import 'theme_settings_screen.dart'; 


// НОВЫЙ РАЗДЕЛ - ДОБАВЛЕНИЕ КЛЮЧА ДЛЯ УПРАВЛЕНИЯ SCAFFOLD
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteService = Provider.of<NoteService>(context);
    final themeManager = Provider.of<ThemeManager>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Notes'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      // ИЗМЕНЕНИЕ - ПЕРЕРАБОТКА DRAWER ДЛЯ РАЗДЕЛА THEME
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Theme'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ThemeSettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      // КОНЕЦ ИЗМЕНЕНИЯ
      body: Stack(
        children: [
          noteService.notes.isEmpty
              ? const Center()
              : ListView.builder(
                  itemCount: noteService.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteService.notes[index];
                    return NoteCard(note: note);
                  },
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NoteScreen()),
                  );
                },
                child: const Icon(Icons.add),
                backgroundColor: Colors.blue,
                elevation: 6.0,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}