import 'package:notecraft/data/models/add_note_param.dart';
import 'package:notecraft/data/repositories/notes_api.dart';

import '../entities/note.dart';

class NotesRepository {
  final NotesApi _notesApi;

  const NotesRepository(this._notesApi);

  Stream<List<Note>> getNotes() => _notesApi.getNotes();
  Future<void> addNote(AddNoteParam param) => _notesApi.addNote(param);
  Future<void> deleteNote(int id) => _notesApi.deleteNote(id);
}
