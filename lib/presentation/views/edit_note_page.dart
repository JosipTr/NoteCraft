import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injector.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';

class EditNotePage extends StatelessWidget {
  final Note note;
  const EditNotePage({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => injector(),
      child: EditNoteView(
        note: note,
      ),
    );
  }
}

class EditNoteView extends StatelessWidget {
  final Note note;
  const EditNoteView({required this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    titleController.text = note.title;
    descriptionController.text = note.description;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Save"),
      ),
      appBar: AppBar(
        title: const Text("Edit Note"),
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          if (note.title == titleController.text &&
              note.description == descriptionController.text) {
            return;
          } else {
            context.read<NoteBloc>().add(
                  NoteUpdated(
                    note: note,
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                  ),
                );
            return;
          }
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                maxLength: 32,
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  label: Text("Title: "),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: descriptionController,
                  maxLength: 255,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    label: Text("Description: "),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
