import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../services/note_service.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ИЗМЕНЕНИЕ - СОЗДАТЬ КАРТОЧКУ С ЗАКРУГЛЁННЫМИ УГЛАМИ, ПОЛУПРОЗРАЧНЫМ ФОНОМ И РЕГУЛЯТОРОМ РАЗМЕРА
    return Scaffold(
      body: Stack(
        children: [
          // ИЗМЕНЕНИЕ - ДОБАВИТЬ ПОЛУПРОЗРАЧНЫЙ ЗАТЕМНЁННЫЙ ФОН
          Container(
            color: Colors.black.withOpacity(0.5), // Полупрозрачный фон с затемнением
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5, // Половина высоты экрана
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Закруглённые углы
                ),
                elevation: 6.0, // Тень
                margin: const EdgeInsets.all(16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ИЗМЕНЕНИЕ - РАВНОМЕРНОЕ РАСПРЕДЕЛЕНИЕ ПРОСТРАНСТВА МЕЖДУ ПОЛЯМИ И КНОПКОЙ
                      Expanded(
                        child: Column(
                          children: [
                            //ИЗМЕНЕНИЕ - ДОБАВИТЬ НАДПИСЬ NEW NOTE СВЕРХУ ПО СЕРЕДИНЕ
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'New Note',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(labelText: 'Title'),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _contentController,
                                decoration: const InputDecoration(labelText: 'Content'),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ИЗМЕНЕНИЕ - ПЕРЕМЕСТИТЬ КНОПКУ SAVE ВНИЗ КАРТОЧКИ
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            final noteService = Provider.of<NoteService>(context, listen: false);
                            await noteService.addNote(
                              _titleController.text,
                              _contentController.text,
                              null, // categoryId, если не используется
                            );
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ),
                      // КОНЕЦ ИЗМЕНЕНИЯ
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // КОНЕЦ ИЗМЕНЕНИЯ
  }
}