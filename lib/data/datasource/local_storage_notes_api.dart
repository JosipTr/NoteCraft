import 'package:drift/drift.dart';
import 'package:notecraft/data/repositories/notes_api.dart';

import '../models/models.dart';

class LocalStorageNotesApi implements NotesApi {
  final AppDatabase _appDatabase;

  const LocalStorageNotesApi(this._appDatabase);

  @override
  Stream<List<NoteModel>> getNotes() {
    final noteModelStreamList = (_appDatabase.select(_appDatabase.noteItems))
        .watch()
        .map((noteItemList) => noteItemList
            .map((noteItem) => NoteModel.fromJson(noteItem.toJson()))
            .toList());
    return noteModelStreamList;
  }

  @override
  Future<void> addNote(AddNoteParam params) async {
    await _appDatabase.into(_appDatabase.noteItems).insert(
          NoteItemsCompanion.insert(
            title: params.title,
            description: params.description,
            date: DateTime.now(),
          ),
        );
  }

  @override
  Future<void> deleteNote(int id) async {
    await (_appDatabase.delete(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  @override
  Future<void> toggleFavorite(int id) async {
    final note = await (_appDatabase.select(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    await (_appDatabase.update(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(id)))
        .write(NoteItemsCompanion(favorite: Value(!note.favorite)));
  }

  @override
  Future<void> updateNote(NoteModel noteModel) async {
    await (_appDatabase.update(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(noteModel.id!)))
        .write(
      NoteItemsCompanion(
          id: Value(noteModel.id!),
          title: Value(noteModel.title),
          description: Value(noteModel.description),
          date: Value(DateTime.now()),
          favorite: Value(noteModel.isFavorite),
          deleted: Value(noteModel.isDeleted)),
    );
  }

  @override
  Future<void> toggleDelete(int id) async {
    final note = await (_appDatabase.select(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();

    await (_appDatabase.update(_appDatabase.noteItems)
          ..where((tbl) => tbl.id.equals(id)))
        .write(NoteItemsCompanion(
            deleted: Value(!note.deleted), favorite: const Value(false)));
  }

  @override
  Future<void> deleteAllNotes() async {
    await (_appDatabase.delete(_appDatabase.noteItems)
          ..where((tbl) => tbl.deleted.equals(true)))
        .go();
  }
}
