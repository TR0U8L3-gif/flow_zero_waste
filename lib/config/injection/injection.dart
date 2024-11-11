import 'package:flow_zero_waste/config/injection/injection.config.dart';
import 'package:flow_zero_waste/core/enums/build_type_enum.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// GetIt instance
final locator = GetIt.instance;

/// Environment development
const development = Env.development;

/// Environment demonstration
const demonstration = Env.demonstration;

/// Environment production
const production = Env.production;

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
      return Env.development;
    case BuildType.profile:
      return Env.demonstration;
    case BuildType.release:
      return Env.production;
  }
}

/// Environment
class Env {
  /// Development environment
  static const development = 'development';

  /// Demonstration environment
  static const demonstration = 'demonstration';

  /// Production environment
  static const production = 'production';
}
