import 'package:flow_zero_waste/src/language/data/datasources/language_local_data_source.dart';
import 'package:flow_zero_waste/src/language/data/datasources/language_storage_hive.dart';
import 'package:injectable/injectable.dart';

/// Language code key used for hive storage
const String languageKey = 'languageCode';

/// Language local data source implementation
@Singleton(as: LanguageLocalDataSource)
class LanguageLocalDataSourceImpl implements LanguageLocalDataSource {
  /// Constructor for LanguageLocalDataSorceImpl
  const LanguageLocalDataSourceImpl({
    required LanguageStorageHive languageStorageHive,
  }) : _languageStorageHive = languageStorageHive;

  final LanguageStorageHive _languageStorageHive;

  @override
  Future<String?> loadLanguageFromStorage() async {
    return _languageStorageHive.read(key: languageKey);
  }

  @override
  Future<void> saveLanguageToStorage(String languageCode) async {
    return _languageStorageHive.write(languageCode, key: languageKey);
  }
}
