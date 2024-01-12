import 'package:notecraft/data/repositories/settings_api.dart';

import '../entities/sort_filter.dart';

class SettingsRepository {
  final SettingsApi _settingsApi;

  const SettingsRepository(this._settingsApi);

  Future<void> setSortType(SortFilter sortFilter) =>
      _settingsApi.setSortType(sortFilter.sortType);

  String getSortType() => _settingsApi.getSortType();
}
