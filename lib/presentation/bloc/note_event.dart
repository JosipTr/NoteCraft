part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class NoteGetRequested extends NoteEvent {}

final class NoteAdded extends NoteEvent {
  final AddNoteParam param;

  const NoteAdded(this.param);

  @override
  List<Object> get props => [param];
}

final class NoteDeleted extends NoteEvent {
  final int id;

  const NoteDeleted(this.id);

  @override
  List<Object> get props => [id];
}
