import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/presentation/bloc/note_bloc.dart';

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
          title: Text(notes[index].title),
          subtitle: Text(notes[index].description),
          trailing: const Icon(Icons.star_border),
          onLongPress: () => context
              .read<NoteBloc>()
              .add(NoteDeleted(notes[index].id!)), //Always has id from db
        ),
      ),
    );
  }
}
