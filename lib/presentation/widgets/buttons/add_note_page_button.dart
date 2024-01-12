import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/presentation/views/views.dart';

import '../../bloc/note_bloc.dart';

class AddNotePageButton extends StatelessWidget {
  const AddNotePageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadSuccess) {
          if (state.noteFilter == NoteFilter.trash ||
              state.noteFilter == NoteFilter.favorite) {
            return const SizedBox();
          }
        }
        return FloatingActionButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddNotePage())),
          child: const Icon(Icons.note_add),
        );
      },
    );
  }
}
