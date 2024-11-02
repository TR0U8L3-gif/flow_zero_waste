import 'package:flow_zero_waste/src/language/data/datasources/language_local_data_sorce.dart';
import 'package:flow_zero_waste/src/language/data/datasources/language_storage_hive.dart';
import 'package:injectable/injectable.dart';

/// Language code key used for hive storage
const String languageCodeId = 'languageCode';

/// Language local data source implementation
@Singleton(as: LanguageLocalDataSorce)
class LanguageLocalDataSorceImpl implements LanguageLocalDataSorce {
  /// Constructor for LanguageLocalDataSorceImpl
  LanguageLocalDataSorceImpl({
    required LanguageStorageHive languageStorageHive,
  }) : _languageStorageHive = languageStorageHive;

  final LanguageStorageHive _languageStorageHive;

  @override
  Future<String?> loadLanguageFromStorage() async {
    return _languageStorageHive.read(key: languageCodeId);
  }

  @override
  Future<void> saveLanguageToStorage(String languageCode) async {
    return _languageStorageHive.write(languageCode, key: languageCodeId);
  }
}
