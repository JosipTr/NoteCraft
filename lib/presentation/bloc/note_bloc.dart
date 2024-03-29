import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';
import 'package:notecraft/domain/repositories/settings_repository.dart';
import 'package:notecraft/utils/functions/sort_notes.dart';

import '../../data/models/models.dart';
import '../../domain/entities/note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NotesRepository _notesRepository;
  final SettingsRepository _settingsRepository;

  NoteBloc(this._notesRepository, this._settingsRepository)
      : super(NoteInitial()) {
    on<NoteGetRequested>(_onNoteGetRequested);
    on<NoteAdded>(_onNoteAdded);
    on<NoteDeleted>(_onNoteDeleted);
    on<NoteFavoriteToggled>(_onNoteFavoriteToggled);
    on<NoteSelectToggled>(_onNoteSelectToggled);
    on<NoteDeleteToggled>(_onNoteDeleteToggled);
    on<NoteUpdated>(_onNoteUpdated);
    on<NoteDeleteAllRequested>(_onNoteDeleteAllRequested);
    on<NoteRestored>(_onNoteRestored);
    on<NoteSearched>(_onNoteSearched);
    on<NoteExported>(_onNoteExported);
    on<NoteImported>(_onNoteImported);
  }

  Future<void> _onNoteGetRequested(
      NoteGetRequested event, Emitter<NoteState> emit) async {
    emit(NoteLoadInProgress());
    final sortType = _settingsRepository.getSortType();
    await emit.forEach(_notesRepository.getNotes(), onData: (notes) {
      sortNotes(notes, sortType);
      if (event.noteFilter == NoteFilter.favorite) {
        return NoteLoadSuccess(notes.where((note) => note.isFavorite).toList(),
            NoteFilter.favorite);
      }
      if (event.noteFilter == NoteFilter.trash) {
        return NoteLoadSuccess(
            notes.where((note) => note.isDeleted).toList(), NoteFilter.trash);
      }

      return NoteLoadSuccess(
          notes
              .map((note) => note.copyWith(isSelected: false))
              .where((note) => !note.isDeleted)
              .toList(),
          NoteFilter.main);
    }, onError: (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      return NoteLoadFailure();
    });
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

  Future<void> _onNoteDeleteToggled(
      NoteDeleteToggled event, Emitter<NoteState> emit) async {
    for (final note in event.notes) {
      if (note.isSelected) {
        await _notesRepository.toggleDelete(note.id!);
      }
    }
  }

  Future<void> _onNoteRestored(
      NoteRestored event, Emitter<NoteState> emit) async {
    await _notesRepository.toggleDelete(event.id);
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
      emit(
          NoteLoadSuccess(updatedNotes, (state as NoteLoadSuccess).noteFilter));
    }
  }

  Future<void> _onNoteDeleteAllRequested(
      NoteDeleteAllRequested event, Emitter<NoteState> emit) async {
    await _notesRepository.deleteAllNotes();
  }

  Future<void> _onNoteSearched(
    NoteSearched event,
    Emitter<NoteState> emit,
  ) async {
    if (state is NoteLoadSuccess) {
      final filter = (state as NoteLoadSuccess).noteFilter;

      final notes = await _notesRepository.searchNotes(event.text);

      final filteredNotes = notes
          .where((note) =>
              note.title.toLowerCase().startsWith(event.text.toLowerCase()))
          .toList();

      emit(NoteLoadSuccess(filteredNotes, filter));
    }
  }

  Future<void> _onNoteExported(
      NoteExported event, Emitter<NoteState> emit) async {
    await _notesRepository.exportNotes(event.notes, event.path);
  }

  Future<void> _onNoteImported(
      NoteImported event, Emitter<NoteState> emit) async {
    await _notesRepository.importNotes(event.path);
  }
}
