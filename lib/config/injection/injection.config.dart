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
import '../../src/auth/data/datasources/local/auth_local_data_source.dart'
    as _i689;
import '../../src/auth/data/datasources/local/auth_local_data_source_impl.dart'
    as _i489;
import '../../src/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i794;
import '../../src/auth/data/datasources/remote/auth_remote_data_source_impl_dev.dart'
    as _i338;
import '../../src/auth/data/datasources/remote/auth_remote_data_source_impl_prod.dart'
    as _i643;
import '../../src/auth/data/datasources/remote/auth_remote_data_source_impl_test.dart'
    as _i620;
import '../../src/auth/data/mappers/user_mapper.dart' as _i674;
import '../../src/auth/data/repositories/auth_repository_impl.dart' as _i105;
import '../../src/auth/domain/repositories/auth_repository.dart' as _i274;
import '../../src/auth/domain/usecases/get_current_user.dart' as _i458;
import '../../src/auth/domain/usecases/login_user.dart' as _i775;
import '../../src/auth/domain/usecases/logout_user.dart' as _i910;
import '../../src/auth/domain/usecases/register_user.dart' as _i651;
import '../../src/auth/presentation/logics/auth_provider.dart' as _i346;
import '../../src/language/data/datasources/language_local_data_source.dart'
    as _i40;
import '../../src/language/data/datasources/language_local_data_source_impl.dart'
    as _i690;
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
import '../../src/onboarding/data/datasources/onboarding_local_data_source.dart'
    as _i937;
import '../../src/onboarding/data/datasources/onboarding_local_data_source_impl.dart'
    as _i131;
import '../../src/onboarding/data/datasources/onboarding_storage_hive.dart'
    as _i296;
import '../../src/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i145;
import '../../src/onboarding/domain/repositories/onboarding_repository.dart'
    as _i1072;
import '../../src/onboarding/domain/usecases/load_onboarding_seen_from_local_storage.dart'
    as _i692;
import '../../src/onboarding/domain/usecases/save_onboarding_seen_to_local_storage.dart'
    as _i845;
import '../../src/onboarding/presentation/logics/onboarding_provider.dart'
    as _i491;
import '../../src/ui/data/datasources/ui_local_data_source.dart' as _i382;
import '../../src/ui/data/datasources/ui_local_data_source_impl.dart' as _i526;
import '../../src/ui/data/datasources/ui_storage_hive.dart' as _i475;
import '../../src/ui/data/mappers/text_scale_details_mapper.dart' as _i442;
import '../../src/ui/data/mappers/theme_details_mapper.dart' as _i494;
import '../../src/ui/data/repositories/ui_repository_impl.dart' as _i533;
import '../../src/ui/domain/repositories/ui_repository.dart' as _i106;
import '../../src/ui/domain/usecases/load_text_scale_from_local_storage.dart'
    as _i220;
import '../../src/ui/domain/usecases/load_theme_from_local_storage.dart'
    as _i755;
import '../../src/ui/domain/usecases/save_text_scale_to_local_storage.dart'
    as _i751;
import '../../src/ui/domain/usecases/save_theme_to_local_storage.dart' as _i523;
import '../../src/ui/presentation/logics/text_scale_provider.dart' as _i210;
import '../../src/ui/presentation/logics/theme_provider.dart' as _i88;
import '../routes/guards/auth_guard.dart' as _i284;
import '../routes/guards/onboarding_guard.dart' as _i11;
import '../routes/navigation_router.dart' as _i732;

const String _test = 'test';
const String _dev = 'dev';
const String _prod = 'prod';

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
    gh.singleton<_i239.PageProvider>(() => _i239.PageProvider());
    gh.singleton<_i674.UserMapper>(() => _i674.UserMapper());
    gh.singleton<_i681.LanguageStorageHive>(
      () => _i681.LanguageStorageHive(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i296.OnboardingStorageHive>(
      () => _i296.OnboardingStorageHive(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i475.UiStorageHive>(
      () => _i475.UiStorageHive(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i442.TextScaleDetailsMapper>(
        () => _i442.TextScaleDetailsMapper());
    gh.singleton<_i494.ThemeDetailsMapper>(() => _i494.ThemeDetailsMapper());
    gh.singleton<_i794.AuthRemoteDataSource>(
      () => _i620.AuthRemoteDataSourceImplProd(),
      registerFor: {_test},
    );
    gh.singleton<_i369.DeviceInfoManager>(
        () => _i698.DeviceInfoImplementation());
    gh.singleton<_i40.LanguageLocalDataSource>(() =>
        _i690.LanguageLocalDataSourceImpl(
            languageStorageHive: gh<_i681.LanguageStorageHive>()));
    gh.singleton<_i31.LoggerManagerParameters>(
        () => _i31.LoggerManagerParametersFromAppEnv());
    gh.singleton<_i382.UiLocalDataSource>(() =>
        _i526.UiLocalDataSourceImpl(uiStorageHive: gh<_i475.UiStorageHive>()));
    gh.singleton<_i794.AuthRemoteDataSource>(
      () => _i338.AuthRemoteDataSourceImplDev(),
      registerFor: {_dev},
    );
    gh.singleton<_i689.AuthLocalDataSource>(
        () => _i489.AuthLocalDataSourceImpl());
    gh.singleton<_i794.AuthRemoteDataSource>(
      () => _i643.AuthRemoteDataSourceImplProd(),
      registerFor: {_prod},
    );
    gh.singleton<_i937.OnboardingLocalDataSource>(() =>
        _i131.OnboardingLocalDataSourceImpl(
            onboardingStorageHive: gh<_i296.OnboardingStorageHive>()));
    gh.singleton<_i127.LoggerManager>(() => _i806.LoggerManagerImplementation(
          deviceInfo: gh<_i369.DeviceInfoManager>(),
          parameters: gh<_i31.LoggerManagerParameters>(),
        ));
    gh.singleton<_i1072.OnboardingRepository>(
        () => _i145.OnboardingRepositoryImpl(
              onboardingLocalDataSorce: gh<_i937.OnboardingLocalDataSource>(),
              logger: gh<_i127.LoggerManager>(),
            ));
    gh.singleton<_i106.UiRepository>(() => _i533.UiRepositoryImpl(
          textScaleDetailsMapper: gh<_i442.TextScaleDetailsMapper>(),
          themeDetailsMapper: gh<_i494.ThemeDetailsMapper>(),
          uiLocalDataSource: gh<_i382.UiLocalDataSource>(),
          logger: gh<_i127.LoggerManager>(),
        ));
    gh.singleton<_i274.AuthRepository>(() => _i105.AuthRepositoryImpl(
          authRemoteDataSource: gh<_i794.AuthRemoteDataSource>(),
          authLocalDataSource: gh<_i689.AuthLocalDataSource>(),
          userMapper: gh<_i674.UserMapper>(),
          logger: gh<_i127.LoggerManager>(),
        ));
    gh.singleton<_i692.LoadOnboardingSeenFromLocalStorage>(() =>
        _i692.LoadOnboardingSeenFromLocalStorage(
            repository: gh<_i1072.OnboardingRepository>()));
    gh.singleton<_i845.SaveOnboardingSeenToLocalStorage>(() =>
        _i845.SaveOnboardingSeenToLocalStorage(
            repository: gh<_i1072.OnboardingRepository>()));
    gh.singleton<_i458.GetCurrentUser>(
        () => _i458.GetCurrentUser(repository: gh<_i274.AuthRepository>()));
    gh.singleton<_i775.LoginUser>(
        () => _i775.LoginUser(repository: gh<_i274.AuthRepository>()));
    gh.singleton<_i910.LogoutUser>(
        () => _i910.LogoutUser(repository: gh<_i274.AuthRepository>()));
    gh.singleton<_i651.RegisterUser>(
        () => _i651.RegisterUser(repository: gh<_i274.AuthRepository>()));
    gh.singleton<_i220.LoadTextScaleFromLocalStorage>(() =>
        _i220.LoadTextScaleFromLocalStorage(
            repository: gh<_i106.UiRepository>()));
    gh.singleton<_i755.LoadThemeFromLocalStorage>(() =>
        _i755.LoadThemeFromLocalStorage(repository: gh<_i106.UiRepository>()));
    gh.singleton<_i751.SaveTextScaleToLocalStorage>(() =>
        _i751.SaveTextScaleToLocalStorage(
            repository: gh<_i106.UiRepository>()));
    gh.singleton<_i523.SaveThemeToLocalStorage>(() =>
        _i523.SaveThemeToLocalStorage(repository: gh<_i106.UiRepository>()));
    gh.singleton<_i706.LanguageRepository>(() => _i472.LanguageRepositoryImpl(
          languageLocalDataSorce: gh<_i40.LanguageLocalDataSource>(),
          logger: gh<_i127.LoggerManager>(),
        ));
    gh.singleton<_i88.ThemeProvider>(() => _i88.ThemeProvider(
          loadThemeFromLocalStorage: gh<_i755.LoadThemeFromLocalStorage>(),
          saveThemeFromLocalStorage: gh<_i523.SaveThemeToLocalStorage>(),
        ));
    gh.singleton<_i424.LoadLanguageFromLocalStorage>(() =>
        _i424.LoadLanguageFromLocalStorage(
            repository: gh<_i706.LanguageRepository>()));
    gh.singleton<_i665.SaveLanguageToLocalStorage>(() =>
        _i665.SaveLanguageToLocalStorage(
            repository: gh<_i706.LanguageRepository>()));
    gh.singleton<_i346.AuthProvider>(() => _i346.AuthProvider(
          getCurrentUser: gh<_i458.GetCurrentUser>(),
          loginUser: gh<_i775.LoginUser>(),
          logoutUser: gh<_i910.LogoutUser>(),
          registerUser: gh<_i651.RegisterUser>(),
        ));
    gh.singleton<_i491.OnboardingProvider>(() => _i491.OnboardingProvider(
          loadOnboardingSeenFromLocalStorage:
              gh<_i692.LoadOnboardingSeenFromLocalStorage>(),
          saveOnboardingSeenToLocalStorage:
              gh<_i845.SaveOnboardingSeenToLocalStorage>(),
        ));
    gh.singleton<_i210.TextScaleProvider>(() => _i210.TextScaleProvider(
          loadTextScaleFromLocalStorage:
              gh<_i220.LoadTextScaleFromLocalStorage>(),
          saveTextScaleFromLocalStorage:
              gh<_i751.SaveTextScaleToLocalStorage>(),
        ));
    gh.lazySingleton<_i11.OnboardingGuard>(() => _i11.OnboardingGuard(
        onboardingProvider: gh<_i491.OnboardingProvider>()));
    gh.singleton<_i1069.LanguageProvider>(() => _i1069.LanguageProvider(
          getLanguageFromStorage: gh<_i424.LoadLanguageFromLocalStorage>(),
          saveLanguageToStorage: gh<_i665.SaveLanguageToLocalStorage>(),
        ));
    gh.singleton<_i284.AuthGuard>(
        () => _i284.AuthGuard(authProvider: gh<_i346.AuthProvider>()));
    gh.singleton<_i732.NavigationRouter>(() => _i732.NavigationRouter(
          onboardingGuard: gh<_i11.OnboardingGuard>(),
          auth: gh<_i284.AuthGuard>(),
        ));
    return this;
  }
}
