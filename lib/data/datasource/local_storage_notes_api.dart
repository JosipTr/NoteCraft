import 'package:notecraft/data/models/database.dart';
import 'package:notecraft/data/models/note_model.dart';
import 'package:notecraft/data/repositories/notes_api.dart';

class LocalStorageNotesApi implements NotesApi {
  final AppDatabase _appDatabase;

  const LocalStorageNotesApi(this._appDatabase);

  @override
  Stream<List<NoteModel>> getNotes() {
    final noteItems = _appDatabase.select(_appDatabase.noteItems).get();

    final noteModels = noteItems.then((value) => value
        .map((noteItem) => NoteModel.fromJson(noteItem.toJson()))
        .toList());

    final stream = Stream.fromFuture(noteModels);

    return stream;
  }
}
