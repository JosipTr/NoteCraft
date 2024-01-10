part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {}

final class NoteLoadInProgress extends NoteState {}

final class NoteLoadSuccess extends NoteState {
  final List<Note> notes;
  final String title;

  const NoteLoadSuccess(this.notes, this.title);

  @override
  List<Object> get props => [notes, title];
}

final class NoteLoadFailure extends NoteState {}
