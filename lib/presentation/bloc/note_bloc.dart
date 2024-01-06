import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';

import '../../domain/entities/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository _notesRepository;

  NoteBloc(this._notesRepository) : super(NoteInitial()) {
    on<NoteGetRequested>(_onNoteGetRequested);
  }

  Future<void> _onNoteGetRequested(
      NoteGetRequested event, Emitter<NoteState> emit) async {
    emit.forEach(_notesRepository.getNotes(),
        onData: (notes) => NoteLoadSuccess(notes),
        onError: (_, __) => NoteLoadFailure());
  }
}