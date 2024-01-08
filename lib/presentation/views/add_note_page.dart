import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/data/models/add_note_param.dart';

import '../../di/injector.dart';
import '../bloc/note_bloc.dart';

class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NoteBloc>(
      create: (_) => injector(),
      child: const AddNoteView(),
    );
  }
}

class AddNoteView extends StatelessWidget {
  const AddNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<NoteBloc>().add(
                NoteAdded(
                  AddNoteParam(
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim(),
                  ),
                ),
              );
          Navigator.pop(context);
        },
        child: const Text("Save"),
      ),
      appBar: AppBar(
        title: const Text("Add new Note"),
      ),
      body: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text("Title: "),
              ),
            ),
            TextField(
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                  label: Text("Description: "), border: InputBorder.none),
            ),
          ],
        ),
      ),
    );
  }
}
