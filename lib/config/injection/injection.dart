import 'package:flow_zero_waste/config/injection/injection.config.dart';
import 'package:flow_zero_waste/core/enums/build_type_enum.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// GetIt instance
final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)

/// Configure the dependencies
void configureDependencies(BuildType buildType) => locator.init(
      environment: _getEnvironment(buildType),
    );

String? _getEnvironment(BuildType buildType) {
  switch (buildType) {
    case BuildType.debug:
      return Environment.dev;
    case BuildType.profile:
      return Environment.test;
    case BuildType.release:
      return Environment.prod;
  }
}
