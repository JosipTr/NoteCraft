import '../models/add_note_param.dart';
import '../models/note_model.dart';

abstract interface class NotesApi {
  Stream<List<NoteModel>> getNotes();
  Future<void> addNote(AddNoteParam params);
  Future<void> deleteNote(int id);
  Future<void> toggleFavorite(int id);
  Future<void> toggleDelete(int id);
  Future<void> updateNote(NoteModel noteModel);
  Future<void> deleteAllNotes();
  Future<List<NoteModel>> searchNotes(String text);
}
