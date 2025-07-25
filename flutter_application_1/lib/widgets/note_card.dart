import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/note_service.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(note.title.isEmpty ? 'No Title' : note.title),
        subtitle: Text(
          note.content.isEmpty ? 'No Content' : note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<NoteService>(context, listen: false).deleteNote(note.id);
          },
        ),
      ),
    );
  }
}