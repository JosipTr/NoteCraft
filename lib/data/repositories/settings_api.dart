abstract interface class SettingsApi {
  Future<void> setSortType(String sortType);
  String getSortType();
}
