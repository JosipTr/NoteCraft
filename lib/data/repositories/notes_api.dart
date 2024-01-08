import '../models/note_model.dart';

abstract interface class NotesApi {
  Stream<List<NoteModel>> getNotes();
  Future<void> addNote();
  Future<void> deleteNote(int id);
}
