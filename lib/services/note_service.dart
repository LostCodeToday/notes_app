import 'package:flutter/material.dart';
import '../models/note.dart';
import 'package:uuid/uuid.dart';

class NoteService with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> init() async {
    // Инициализация не требуется, данные хранятся в памяти
    notifyListeners();
  }

  Future<void> addNote(String title, String content, String? categoryId) async {
    final note = Note(
      id: const Uuid().v4(),
      title: title,
      content: content,
      categoryId: categoryId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _notes.add(note);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index != -1) {
      _notes[index] = Note(
        id: note.id,
        title: note.title,
        content: note.content,
        categoryId: note.categoryId,
        createdAt: note.createdAt,
        updatedAt: DateTime.now(),
        isArchived: note.isArchived,
      );
      notifyListeners();
    }
  }

  Future<void> deleteNote(String id) async {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}