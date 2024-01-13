import 'package:get_it/get_it.dart';
import 'package:notecraft/data/datasource/local_storage_notes_api.dart';
import 'package:notecraft/data/datasource/local_storage_settings_api.dart';
import 'package:notecraft/data/models/database.dart';
import 'package:notecraft/data/repositories/notes_api.dart';
import 'package:notecraft/data/repositories/settings_api.dart';
import 'package:notecraft/domain/repositories/notes_repository.dart';
import 'package:notecraft/domain/repositories/settings_repository.dart';
import 'package:notecraft/presentation/bloc/note_bloc.dart';
import 'package:notecraft/presentation/cubit/backup_cubit/backup_cubit.dart';
import 'package:notecraft/presentation/cubit/settings_cubit/settings_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/cubit/search_cubit/search_cubit.dart';

final GetIt injector = GetIt.instance;

Future<void> initDependencies() async {
  final database = AppDatabase();
  final sharedPref = await SharedPreferences.getInstance();

  injector.registerSingleton(database);
  injector.registerSingleton(sharedPref);

  injector.registerFactory(() => NoteBloc(injector(), injector()));
  injector.registerFactory(() => SettingsCubit(injector()));
  injector.registerFactory(() => SearchCubit());
  injector.registerFactory(() => BackupCubit(injector()));

  injector.registerLazySingleton(() => NotesRepository(injector()));
  injector.registerLazySingleton(() => SettingsRepository(injector()));

  injector
      .registerLazySingleton<NotesApi>(() => LocalStorageNotesApi(injector()));

  injector.registerLazySingleton<SettingsApi>(
      () => LocalStorageSettingsApi(injector()));
}
