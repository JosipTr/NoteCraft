import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/presentation/bloc/note_bloc.dart';
import 'package:date_format/date_format.dart';
import 'package:notecraft/presentation/widgets/widgets.dart';

import '../../domain/entities/note.dart';
import '../views/views.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;
  final NoteFilter noteFilter;
  const NoteList({required this.notes, required this.noteFilter, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (context, index) => Card(
        color: notes[index].isSelected ? Colors.blueGrey : null,
        child: ListTile(
            title: Text(notes[index].title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notes[index].description, maxLines: 1),
                Text(
                  formatDate(
                    DateTime.fromMillisecondsSinceEpoch(notes[index].date),
                    [dd, '-', mm, '-', yyyy, ' ', hh, ":", nn, ":", ss],
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            trailing: noteFilter == NoteFilter.trash
                ? NoteTrashIconButton(notes: notes, index: index)
                : NoteIconButton(
                    notes: notes,
                    index: index,
                  ),
            onLongPress: () => context.read<NoteBloc>().add(
                  NoteSelectToggled(notes[index].id!),
                ),
            onTap: () {
              var isSelected = false;
              for (final note in notes) {
                if (note.isSelected) {
                  isSelected = true;
                  break;
                }
              }
              if (isSelected) {
                context.read<NoteBloc>().add(
                      NoteSelectToggled(notes[index].id!),
                    );
                return;
              }
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditNotePage(
                    note: notes[index],
                  ),
                ),
              );
              return;
            } //Always has id from db
            ),
      ),
    );
  }
}

class NoteIconButton extends StatelessWidget {
  final List<Note> notes;
  final int index;
  const NoteIconButton({required this.notes, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return notes[index].isSelected
        ? IconButton(
            onPressed: () => context.read<NoteBloc>().add(
                  NoteDeleteToggled(notes),
                ),
            icon: const Icon(Icons.delete),
          )
        : notes[index].isFavorite
            ? IconButton(
                onPressed: () => context.read<NoteBloc>().add(
                      NoteFavoriteToggled(notes[index].id!),
                    ),
                icon: const Icon(Icons.star),
              )
            : IconButton(
                onPressed: () => context.read<NoteBloc>().add(
                      NoteFavoriteToggled(notes[index].id!),
                    ),
                icon: const Icon(Icons.star_border),
              );
  }
}
