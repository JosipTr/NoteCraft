import 'package:notecraft/data/repositories/notes_api.dart';

import '../../data/models/models.dart';
import '../entities/note.dart';

class NotesRepository {
  final NotesApi _notesApi;

  const NotesRepository(this._notesApi);

  Stream<List<Note>> getNotes() => _notesApi.getNotes();
  Future<void> addNote(AddNoteParam param) => _notesApi.addNote(param);
  Future<void> deleteNote(int id) => _notesApi.deleteNote(id);
  Future<void> deleteAllNotes() => _notesApi.deleteAllNotes();
  Future<void> toggleFavorite(int id) => _notesApi.toggleFavorite(id);
  Future<void> toggleDelete(int id) => _notesApi.toggleDelete(id);

  Future<void> updateNote(Note note) =>
      _notesApi.updateNote(NoteModel.fromNote(note));

  Future<List<NoteModel>> searchNotes(String text) =>
      _notesApi.searchNotes(text);

  Future<void> importNotes(String path) => _notesApi.importNotes(path);
  Future<void> exportNotes(List<Note> notes, String path) {
    final noteModelList =
        notes.map((note) => NoteModel.fromNote(note)).toList();
    return _notesApi.exportNotes(noteModelList, path);
  }
}
