/// Language local data source abstract class
abstract class LanguageLocalDataSorce {
  /// Save language code to local storage
  Future<void> saveLanguageToStorage(String languageCode);

  /// Get language code from local storage
  Future<String?> loadLanguageFromStorage();
}
