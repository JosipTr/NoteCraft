import 'package:notecraft/data/models/database.dart';
import 'package:notecraft/data/models/note_model.dart';
import 'package:notecraft/data/repositories/notes_api.dart';

import '../models/add_note_param.dart';

class LocalStorageNotesApi implements NotesApi {
  final AppDatabase _appDatabase;

  const LocalStorageNotesApi(this._appDatabase);

  @override
  Stream<List<NoteModel>> getNotes() {
    return _appDatabase.select(_appDatabase.noteItems).watch().map((noteList) =>
        noteList
            .map((noteItem) => NoteModel.fromJson(noteItem.toJson()))
            .toList());
  }

  @override
  Future<void> addNote(AddNoteParam params) async {
    await _appDatabase.into(_appDatabase.noteItems).insert(
        NoteItemsCompanion.insert(
            title: params.title, description: params.description));
  }

  @override
  Future<void> deleteNote(int id) async {
    await (_appDatabase.delete(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }
}
