import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/data/models/add_note_param.dart';

import '../../di/injector.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';

class AddNotePage extends StatelessWidget {
  final Note? note;
  const AddNotePage({this.note, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => injector(),
      child: AddNoteView(
        note: note,
      ),
    );
  }
}

class AddNoteView extends StatelessWidget {
  final Note? note;
  const AddNoteView({this.note, super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Save"),
      ),
      appBar: AppBar(
        title: const Text("Add new Note"),
      ),
      body: PopScope(
        onPopInvoked: (didPop) {
          if (note != null) {
            if (note!.title == titleController.text &&
                note!.description == descriptionController.text) {
              return;
            } else {
              context.read<NoteBloc>().add(
                    NoteUpdated(
                      note: note!,
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                    ),
                  );
              return;
            }
          }
          context.read<NoteBloc>().add(
                NoteAdded(
                  AddNoteParam(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                  ),
                ),
              );
          return;
        },
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                maxLength: 32,
                controller: titleController,
                textCapitalization: TextCapitalization.sentences,
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text("Title: "),
                ),
              ),
              Expanded(
                child: TextField(
                  maxLines: null,
                  controller: descriptionController,
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
