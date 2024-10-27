// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger_manager/logger_manager.dart' as _i127;

import '../../core/services/device_info/device_info.dart' as _i369;
import '../../core/services/device_info/device_info_implementation.dart'
    as _i698;
import '../../core/services/logger_manager/logger_manager_implementation.dart'
    as _i806;
import '../../core/services/logger_manager/logger_manager_parameters.dart'
    as _i31;
import '../../core/services/secure_storage/secure_storage_implementation.dart'
    as _i271;
import '../../core/services/secure_storage/secure_storage_manager.dart'
    as _i497;
import '../../src/language/data/datasources/language_local_data_sorce.dart'
    as _i87;
import '../../src/language/data/datasources/language_local_data_sorce_impl.dart'
    as _i380;
import '../../src/language/data/datasources/language_storage_hive.dart'
    as _i681;
import '../../src/language/data/repositories/language_repository_impl.dart'
    as _i472;
import '../../src/language/domain/repositories/language_repository.dart'
    as _i706;
import '../../src/language/domain/usecases/get_language_from_local_storage.dart'
    as _i2;
import '../../src/language/domain/usecases/save_language_to_local_storage.dart'
    as _i665;
import '../../src/language/presentation/logics/language_cubit.dart' as _i460;
import '../routes/navigation_router.dart' as _i732;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i732.NavigationRouter>(() => _i732.NavigationRouter());
    gh.singleton<_i681.LanguageStorageHive>(
      () => _i681.LanguageStorageHive(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i87.LanguageLocalDataSorce>(() =>
        _i380.LanguageLocalDataSorceImpl(
            languageStorageHive: gh<_i681.LanguageStorageHive>()));
    gh.singleton<_i31.LoggerManagerParameters>(
        () => _i806.LoggerManagerParametersFromAppEnv());
    gh.singleton<_i497.SecureStorageManager>(
        () => _i271.SecureStorageImplementation());
    gh.singleton<_i369.DeviceInfoManager>(
        () => _i698.DeviceInfoImplementation());
    gh.lazySingleton<_i706.LanguageRepository>(() =>
        _i472.LanguageRepositoryImpl(
            languageLocalDataSorce: gh<_i87.LanguageLocalDataSorce>()));
    gh.lazySingleton<_i2.GetLanguageFromLocalStorage>(() =>
        _i2.GetLanguageFromLocalStorage(
            repository: gh<_i706.LanguageRepository>()));
    gh.lazySingleton<_i665.SaveLanguageToLocalStorage>(() =>
        _i665.SaveLanguageToLocalStorage(
            repository: gh<_i706.LanguageRepository>()));
    gh.singleton<_i127.LoggerManager>(() => _i806.LoggerManagerImplementation(
          deviceInfo: gh<_i369.DeviceInfoManager>(),
          parameters: gh<_i31.LoggerManagerParameters>(),
        ));
    gh.factory<_i460.LanguageCubit>(() => _i460.LanguageCubit(
          getLanguageFromStorage: gh<_i2.GetLanguageFromLocalStorage>(),
          saveLanguageToStorage: gh<_i665.SaveLanguageToLocalStorage>(),
        ));
    return this;
  }
}
