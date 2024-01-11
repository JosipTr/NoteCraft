import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/note.dart';
import '../../bloc/note_bloc.dart';

class NoteTrashIconButton extends StatelessWidget {
  final List<Note> notes;
  final int index;
  const NoteTrashIconButton(
      {required this.notes, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return notes[index].isSelected
        ? IconButton(
            onPressed: () => context.read<NoteBloc>().add(
                  NoteDeleted(notes),
                ),
            icon: const Icon(Icons.delete),
          )
        : IconButton(
            onPressed: () => context.read<NoteBloc>().add(
                  NoteRestored(notes[index].id!),
                ),
            icon: const Icon(Icons.undo),
          );
  }
}
