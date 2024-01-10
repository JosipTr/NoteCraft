import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';

import '../../data/models/models.dart';
import '../../domain/entities/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository _notesRepository;

  NoteBloc(this._notesRepository) : super(NoteInitial()) {
    on<NoteGetRequested>(_onNoteGetRequested);
    on<NoteAdded>(_onNoteAdded);
    on<NoteDeleted>(_onNoteDeleted);
    on<NoteFavoriteToggled>(_onNoteFavoriteToggled);
    on<NoteSelectToggled>(_onNoteSelectToggled);
    on<NoteUpdated>(_onNoteUpdated);
    on<NoteFavoriteGetRequested>(_onNoteFavoriteGetRequested);
  }

  Future<void> _onNoteGetRequested(
      NoteGetRequested event, Emitter<NoteState> emit) async {
    emit(NoteLoadInProgress());
    await emit.forEach(_notesRepository.getNotes(),
        onData: (notes) => NoteLoadSuccess(
            notes.map((note) => note.copyWith(isSelected: false)).toList()),
        onError: (error, stackTrace) {
          log(error.toString());
          log(stackTrace.toString());
          return NoteLoadFailure();
        });
  }

  Future<void> _onNoteFavoriteGetRequested(
      NoteFavoriteGetRequested event, Emitter<NoteState> emit) async {
    emit(NoteLoadInProgress());
    final favoriteNotes = await _notesRepository.getFavoriteNotes();
    emit(NoteLoadSuccess(favoriteNotes));
  }

  Future<void> _onNoteAdded(NoteAdded event, Emitter<NoteState> emit) async {
    emit(NoteLoadInProgress());
    if (event.param.title.isEmpty && event.param.description.isEmpty) return;
    await _notesRepository.addNote(event.param);
  }

  Future<void> _onNoteDeleted(
      NoteDeleted event, Emitter<NoteState> emit) async {
    emit(NoteLoadInProgress());
    for (final note in event.notes) {
      if (note.isSelected) {
        await _notesRepository.deleteNote(note.id!);
      }
    }
  }

  Future<void> _onNoteUpdated(
      NoteUpdated event, Emitter<NoteState> emit) async {
    if (event.title.isEmpty && event.description.isEmpty) return;
    final note =
        event.note.copyWith(title: event.title, description: event.description);
    await _notesRepository.updateNote(note);
  }

  Future<void> _onNoteFavoriteToggled(
      NoteFavoriteToggled event, Emitter<NoteState> emit) async {
    await _notesRepository.toggleFavorite(event.id);
  }

  Future<void> _onNoteSelectToggled(
      NoteSelectToggled event, Emitter<NoteState> emit) async {
    if (state is NoteLoadSuccess) {
      final List<Note> updatedNotes = (state as NoteLoadSuccess)
          .notes
          .map((note) => note.id == event.id
              ? note.copyWith(isSelected: !note.isSelected)
              : note)
          .toList();
      emit(NoteLoadSuccess(updatedNotes));
    }
  }
}
