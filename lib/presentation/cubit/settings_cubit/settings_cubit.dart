import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notecraft/domain/entities/sort_filter.dart';
import 'package:notecraft/domain/repositories/settings_repository.dart';

class SettingsCubit extends Cubit<SortFilter> {
  final SettingsRepository _settingsRepository;
  SettingsCubit(this._settingsRepository) : super(SortFilter.dateAsc);

  void setSortType(SortFilter sortFilter) async =>
      await _settingsRepository.setSortType(sortFilter);
}
