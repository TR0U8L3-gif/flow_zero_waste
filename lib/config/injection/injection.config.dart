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
    gh.singleton<_i31.LoggerManagerParameters>(
        () => _i806.LoggerManagerParametersFromAppEnv());
    gh.singleton<_i497.SecureStorageManager>(
        () => _i271.SecureStorageImplementation());
    gh.singleton<_i369.DeviceInfoManager>(
        () => _i698.DeviceInfoImplementation());
    gh.singleton<_i127.LoggerManager>(() => _i806.LoggerManagerImplementation(
          deviceInfo: gh<_i369.DeviceInfoManager>(),
          parameters: gh<_i31.LoggerManagerParameters>(),
        ));
    return this;
  }
}
