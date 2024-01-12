import 'package:notecraft/data/repositories/settings_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSettingsApi implements SettingsApi {
  final SharedPreferences _pref;

  const LocalStorageSettingsApi(this._pref);

  @override
  Future<void> setSortType(String sortType) async {
    await _pref.setString('sort', sortType);
  }

  @override
  String getSortType() {
    return _pref.getString("sort") ?? 'titleAsc';
  }
}
