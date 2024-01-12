import 'package:flutter/material.dart';

import '../bloc/note_bloc.dart';

class NoteListEmpty extends StatelessWidget {
  final NoteFilter noteFilter;
  const NoteListEmpty({required this.noteFilter, super.key});

  @override
  Widget build(BuildContext context) {
    if (noteFilter == NoteFilter.trash) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_trash.png',
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Your trash is empty!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    } else if (noteFilter == NoteFilter.favorite) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/favorite_note.png',
              width: 150,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'You have no favorite notes!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_notes.png',
            width: 150,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'You have no notes!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
