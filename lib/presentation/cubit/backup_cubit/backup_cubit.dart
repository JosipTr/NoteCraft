import 'package:bloc/bloc.dart';
import 'package:notecraft/domain/entities/entities.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';

class BackupCubit extends Cubit<bool> {
  final NotesRepository _repository;
  BackupCubit(this._repository) : super(false);

  Future<void> importNotes() async => await _repository.importNotes();
  Future<void> exportNotes(List<Note> notes) async =>
      await _repository.exportNotes(notes);
}
