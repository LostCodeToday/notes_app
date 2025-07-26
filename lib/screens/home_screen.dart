import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/note_service.dart';
import '../widgets/note_card.dart';
import 'note_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteService = Provider.of<NoteService>(context);

    return Scaffold(
      // ИЗМЕНЕНИЕ - УБРАТЬ СТАРУЮ КНОПКУ ИЗ ACTIONS
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [],
      ),
      // КОНЕЦ ИЗМЕНЕНИЯ
      // ИЗМЕНЕНИЕ - ЗАМЕНИТЬ BODY НА STACK ДЛЯ ДОБАВЛЕНИЯ КНОПКИ ВНИЗУ
      body: Stack(
        children: [
          noteService.notes.isEmpty
              ? const Center(child: Text('No notes yet'))
              : ListView.builder(
                  itemCount: noteService.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteService.notes[index];
                    return NoteCard(note: note);
                  },
                ),
          // ИЗМЕНЕНИЕ - ДОБАВИТЬ КНОПКУ ВНИЗУ ПО ЦЕНТРУ С ТЕНОЙ
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
                elevation: 6.0, // Тень
                shape: const CircleBorder(), // Круглая форма
              ),
            ),
          ),
          // КОНЕЦ ИЗМЕНЕНИЯ
        ],
      ),
      // КОНЕЦ ИЗМЕНЕНИЯ
    );
  }
}