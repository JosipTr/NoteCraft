import 'package:notecraft/data/repositories/notes_api.dart';

import '../entities/note.dart';

class NotesRepository {
  final NotesApi _notesApi;

  const NotesRepository(this._notesApi);

  Stream<List<Note>> getNotes() => _notesApi.getNotes();
}