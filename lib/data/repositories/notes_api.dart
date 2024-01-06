import '../models/note_model.dart';

abstract interface class NotesApi {
  Stream<List<NoteModel>> getNotes();
}
