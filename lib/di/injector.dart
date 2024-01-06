import 'package:get_it/get_it.dart';
import 'package:notecraft/data/datasource/local_storage_notes_api.dart';
import 'package:notecraft/data/models/database.dart';
import 'package:notecraft/data/repositories/notes_api.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';
import 'package:notecraft/presentation/bloc/note_bloc.dart';

final GetIt injector = GetIt.instance;

Future<void> initDependencies() async {
  final database = AppDatabase();

  injector.registerSingleton(database);

  injector.registerFactory(() => NoteBloc(injector()));

  injector.registerLazySingleton(() => NotesRepository(injector()));

  injector
      .registerLazySingleton<NotesApi>(() => LocalStorageNotesApi(injector()));
}
