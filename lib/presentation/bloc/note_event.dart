part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class NoteGetRequested extends NoteEvent {
  final NoteFilter noteFilter;

  const NoteGetRequested(this.noteFilter);

  @override
  List<Object> get props => [noteFilter];
}

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

class NoteDeleteToggled extends NoteEvent {
  final List<Note> notes;

  const NoteDeleteToggled(this.notes);

  @override
  List<Object> get props => [notes];
}

class NoteRestored extends NoteEvent {
  final int id;

  const NoteRestored(this.id);

  @override
  List<Object> get props => [id];
}

class NoteDeleteAllRequested extends NoteEvent {
  const NoteDeleteAllRequested();
}

class NoteSearched extends NoteEvent {
  final String text;

  const NoteSearched(this.text);

  @override
  List<Object> get props => [text];
}

class NoteExported extends NoteEvent {
  final List<Note> notes;
  final String path;
  const NoteExported(this.notes, this.path);

  @override
  List<Object> get props => [notes, path];
}

class NoteImported extends NoteEvent {
  final String path;
  const NoteImported(this.path);

  @override
  List<Object> get props => [path];
}
