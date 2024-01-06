import 'package:flutter/material.dart';

import '../../domain/entities/note.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  const NoteList({required this.notes, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const CircleAvatar(),
          title: Text(notes[index].title),
          subtitle: Text(notes[index].description),
        ),
      ),
    );
  }
}
