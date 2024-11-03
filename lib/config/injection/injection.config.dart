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

import '../../core/common/presentation/logics/providers/responsive_ui/page_provider.dart'
    as _i239;
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
import '../../src/language/domain/usecases/load_language_from_local_storage.dart'
    as _i424;
import '../../src/language/domain/usecases/save_language_to_local_storage.dart'
    as _i665;
import '../../src/language/presentation/logics/language_provider.dart'
    as _i1069;
import '../../src/ui/data/datasource/ui_local_data_source.dart' as _i961;
import '../../src/ui/data/datasource/ui_local_data_source_impl.dart' as _i192;
import '../../src/ui/data/datasource/ui_storage_hive.dart' as _i926;
import '../../src/ui/data/mappers/text_scale_details_mapper.dart' as _i442;
import '../../src/ui/data/mappers/theme_details_mapper.dart' as _i494;
import '../../src/ui/data/repository/ui_repository_impl.dart' as _i1050;
import '../../src/ui/domain/repository/ui_repository.dart' as _i957;
import '../../src/ui/domain/usecases/load_text_scale_from_local_storage.dart'
    as _i220;
import '../../src/ui/domain/usecases/load_theme_from_local_storage.dart'
    as _i755;
import '../../src/ui/domain/usecases/save_text_scale_from_local_storage.dart'
    as _i798;
import '../../src/ui/domain/usecases/save_theme_from_local_storage.dart'
    as _i161;
import '../../src/ui/presentation/logics/text_scale_provider.dart' as _i210;
import '../../src/ui/presentation/logics/theme_provider.dart' as _i88;
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
    gh.singleton<_i239.PageProvider>(() => _i239.PageProvider());
    gh.singleton<_i681.LanguageStorageHive>(
      () => _i681.LanguageStorageHive(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i926.UiStorageHive>(
      () => _i926.UiStorageHive(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i442.TextScaleDetailsMapper>(
        () => _i442.TextScaleDetailsMapper());
    gh.singleton<_i494.ThemeDetailsMapper>(() => _i494.ThemeDetailsMapper());
    gh.singleton<_i87.LanguageLocalDataSorce>(() =>
        _i380.LanguageLocalDataSorceImpl(
            languageStorageHive: gh<_i681.LanguageStorageHive>()));
    gh.singleton<_i497.SecureStorageManager>(
        () => _i271.SecureStorageImplementation());
    gh.singleton<_i369.DeviceInfoManager>(
        () => _i698.DeviceInfoImplementation());
    gh.singleton<_i31.LoggerManagerParameters>(
        () => _i31.LoggerManagerParametersFromAppEnv());
    gh.singleton<_i961.UiLocalDataSource>(() =>
        _i192.UiLocalDataSourceImpl(uiStorageHive: gh<_i926.UiStorageHive>()));
    gh.singleton<_i127.LoggerManager>(() => _i806.LoggerManagerImplementation(
          deviceInfo: gh<_i369.DeviceInfoManager>(),
          parameters: gh<_i31.LoggerManagerParameters>(),
        ));
    gh.singleton<_i706.LanguageRepository>(() => _i472.LanguageRepositoryImpl(
          languageLocalDataSorce: gh<_i87.LanguageLocalDataSorce>(),
          logger: gh<_i127.LoggerManager>(),
        ));
    gh.singleton<_i957.UiRepository>(() => _i1050.UiRepositoryImpl(
          textScaleDetailsMapper: gh<_i442.TextScaleDetailsMapper>(),
          themeDetailsMapper: gh<_i494.ThemeDetailsMapper>(),
          uiLocalDataSource: gh<_i961.UiLocalDataSource>(),
          logger: gh<_i127.LoggerManager>(),
        ));
    gh.singleton<_i424.LoadLanguageFromLocalStorage>(() =>
        _i424.LoadLanguageFromLocalStorage(
            repository: gh<_i706.LanguageRepository>()));
    gh.singleton<_i665.SaveLanguageToLocalStorage>(() =>
        _i665.SaveLanguageToLocalStorage(
            repository: gh<_i706.LanguageRepository>()));
    gh.singleton<_i220.LoadTextScaleFromLocalStorage>(() =>
        _i220.LoadTextScaleFromLocalStorage(
            repository: gh<_i957.UiRepository>()));
    gh.singleton<_i755.LoadThemeFromLocalStorage>(() =>
        _i755.LoadThemeFromLocalStorage(repository: gh<_i957.UiRepository>()));
    gh.singleton<_i798.SaveTextScaleFromLocalStorage>(() =>
        _i798.SaveTextScaleFromLocalStorage(
            repository: gh<_i957.UiRepository>()));
    gh.singleton<_i161.SaveThemeFromLocalStorage>(() =>
        _i161.SaveThemeFromLocalStorage(repository: gh<_i957.UiRepository>()));
    gh.singleton<_i88.ThemeProvider>(() => _i88.ThemeProvider(
          loadThemeFromLocalStorage: gh<_i755.LoadThemeFromLocalStorage>(),
          saveThemeFromLocalStorage: gh<_i161.SaveThemeFromLocalStorage>(),
        ));
    gh.singleton<_i1069.LanguageProvider>(() => _i1069.LanguageProvider(
          getLanguageFromStorage: gh<_i424.LoadLanguageFromLocalStorage>(),
          saveLanguageToStorage: gh<_i665.SaveLanguageToLocalStorage>(),
        ));
    gh.singleton<_i210.TextScaleProvider>(() => _i210.TextScaleProvider(
          loadTextScaleFromLocalStorage:
              gh<_i220.LoadTextScaleFromLocalStorage>(),
          saveTextScaleFromLocalStorage:
              gh<_i798.SaveTextScaleFromLocalStorage>(),
        ));
    return this;
  }
}
