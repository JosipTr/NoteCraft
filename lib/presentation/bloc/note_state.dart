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

  const NoteLoadSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

final class NoteLoadFailure extends NoteState {}
