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
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NoteScreen()),
              );
            },
          ),
        ],
      ),
      body: noteService.notes.isEmpty
          ? const Center(child: Text('No notes yet'))
          : ListView.builder(
              itemCount: noteService.notes.length,
              itemBuilder: (context, index) {
                final note = noteService.notes[index];
                return NoteCard(note: note);
              },
            ),
    );
  }
}