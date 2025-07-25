import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/note_service.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteService = Provider.of<NoteService>(context, listen: false);
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (titleController.text.isNotEmpty ||
                  contentController.text.isNotEmpty) {
                noteService.addNote(
                  titleController.text,
                  contentController.text,
                  null, // categoryId для MVP
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}