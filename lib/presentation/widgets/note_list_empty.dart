import 'package:flutter/material.dart';

class NoteListEmpty extends StatelessWidget {
  const NoteListEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No notes!"),
    );
  }
}
