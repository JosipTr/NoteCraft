import 'package:notecraft/data/models/database.dart';
import 'package:notecraft/data/models/note_model.dart';
import 'package:notecraft/data/repositories/notes_api.dart';

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
  Future<void> addNote() async {
    await _appDatabase.into(_appDatabase.noteItems).insert(
        NoteItemsCompanion.insert(
            title: "Hej",
            description:
                "sdfaasdfasdfasdfasdfasdfasdlkjgbadfpjbaedpigrnaeršoignaerpiognaerpoignaeroigpn"));
  }
}
