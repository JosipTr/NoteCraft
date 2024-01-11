part of 'note_bloc.dart';

enum NoteFilter { trash, favorite, main }

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {}

final class NoteLoadInProgress extends NoteState {}

final class NoteLoadSuccess extends NoteState {
  final List<Note> notes;
  final NoteFilter noteFilter;

  const NoteLoadSuccess(this.notes, this.noteFilter);

  @override
  List<Object> get props => [notes, noteFilter];
}

final class NoteLoadFailure extends NoteState {}
