import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/note_bloc.dart';

class DeleteAllNotesButton extends StatelessWidget {
  const DeleteAllNotesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteLoadSuccess) {
          if (state.noteFilter == NoteFilter.trash) {
            return PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: const Text("Empty Trash"),
                        onTap: () => context
                            .read<NoteBloc>()
                            .add(const NoteDeleteAllRequested()),
                      ),
                    ]);
          }
        }
        return const SizedBox();
      },
    );
  }
}
