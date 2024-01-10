part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class NoteGetRequested extends NoteEvent {}

final class NoteDeletedGetRequested extends NoteEvent {}

final class NoteFavoriteGetRequested extends NoteEvent {}

final class NoteAdded extends NoteEvent {
  final AddNoteParam param;

  const NoteAdded(this.param);

  @override
  List<Object> get props => [param];
}

final class NoteDeleted extends NoteEvent {
  final List<Note> notes;

  const NoteDeleted(this.notes);

  @override
  List<Object> get props => [notes];
}

final class NoteUpdated extends NoteEvent {
  final Note note;
  final String title;
  final String description;

  const NoteUpdated({
    required this.note,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [note, title, description];
}

class NoteFavoriteToggled extends NoteEvent {
  final int id;

  const NoteFavoriteToggled(this.id);

  @override
  List<Object> get props => [id];
}

class NoteSelectToggled extends NoteEvent {
  final int id;

  const NoteSelectToggled(this.id);

  @override
  List<Object> get props => [id];
}
