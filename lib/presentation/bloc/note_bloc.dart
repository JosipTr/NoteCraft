import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notecraft/data/models/add_note_param.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';

import '../../domain/entities/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository _notesRepository;

  NoteBloc(this._notesRepository) : super(NoteInitial()) {
    on<NoteGetRequested>(_onNoteGetRequested);
    on<NoteAdded>(_onNoteAdded);
    on<NoteDeleted>(_onNoteDeleted);
  }

  Future<void> _onNoteGetRequested(
      NoteGetRequested event, Emitter<NoteState> emit) async {
    await emit.forEach(_notesRepository.getNotes(),
        onData: (notes) => NoteLoadSuccess(notes),
        onError: (error, stackTrace) {
          log(error.toString());
          log(stackTrace.toString());
          return NoteLoadFailure();
        });
  }

  Future<void> _onNoteAdded(NoteAdded event, Emitter<NoteState> emit) async {
    if (event.param.title.isEmpty && event.param.description.isEmpty) return;
    await _notesRepository.addNote(event.param);
  }

  Future<void> _onNoteDeleted(
      NoteDeleted event, Emitter<NoteState> emit) async {
    await _notesRepository.deleteNote(event.id);
  }
}
