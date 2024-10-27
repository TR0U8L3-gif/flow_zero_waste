import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/config/l10n/l10n.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/error_page.dart';
import 'package:flow_zero_waste/core/enums/build_type.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/services/setup/app_env.dart';
import 'package:flow_zero_waste/core/services/setup/app_setup.dart';
import 'package:flow_zero_waste/core/utils/exceptions.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Core application widget
class App extends StatelessWidget {
  /// Constructor
  const App._(this.result);

  /// Setup the app
  static Future<void> setup({
    required String flavour,
    BuildType? buildType,
  }) async {
    var exception = const AppSetupException(
      sender: 'MyApp.setup',
      description: 'Unknown error occurred while initializing the app',
    );

    var stackTrace = StackTrace.current;

    try {
      // get the environment variables
      await dotenv.load(fileName: 'assets/env/.env');

      // set the environment variables
      AppEnv.setFromEnv(
        env: dotenv.env,
        flavour: flavour,
        buildType: buildType ?? BuildType.fromFlutter,
      );
    } catch (e, st) {
      exception = AppSetupException(
        sender: 'MyApp.setup',
        description: 'Error occurred during setting environment variables'
            ' ${e.runtimeType}',
      );
      stackTrace = st;
    }

    // initialize the app
    AppSetup.init(
      buildType: buildType ?? BuildType.fromFlutter,
      success: App._(MyAppSuccess()),
      failure: App._(MyAppFailure(exception, stackTrace)),
    );
  }

  /// The result of the app setup
  final MyAppResult result;

  @override
  Widget build(BuildContext context) {
    const title = 'Flow - Zero Waste App';
    const localizationsDelegates = L10n.supportedDelegates;
    const supportedLocales = L10n.supportedLocales;
    final providers = [
      BlocProvider(
        create: (context) =>
            locator<LanguageCubit>()..loadLanguageOrSetDeviceLocale(),
      ),
    ];

    if (result is MyAppFailure) {
      final exception = (result as MyAppFailure).exception;
      final stackTrace = (result as MyAppFailure).stackTrace;
      String message;

      if (exception is BaseException) {
        message = exception.message;
      } else {
        message = context.l10n.unknownErrorOccurred;
      }

      return MultiBlocProvider(
        providers: providers,
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              title: title,
              localizationsDelegates: localizationsDelegates,
              supportedLocales: supportedLocales,
              locale: state.currentLanguage,
              home: ErrorPage(
                reportError: true,
                data: ErrorPageData(
                  title: context.l10n.appInitErrorTitle,
                  message: message,
                  exception: exception,
                  stackTrace: stackTrace,
                ),
              ),
            );
          },
        ),
      );
    }

    return MultiBlocProvider(
      providers: providers,
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: title,
            localizationsDelegates: localizationsDelegates,
            supportedLocales: supportedLocales,
            locale: state.currentLanguage,
            routerConfig: locator<NavigationRouter>().config(),
          );
        },
      ),
    );
  }
}

/// Class to represent the result of the app setup
abstract class MyAppResult {
  /// Constructor
  const MyAppResult();
}

/// Class to represent the success result of the app setup
class MyAppSuccess extends MyAppResult {}

/// Class to represent the failure result of the app setup
class MyAppFailure extends MyAppResult {
  /// Constructor
  const MyAppFailure(this.exception, [this.stackTrace]);

  /// The exception that caused the failure
  final Exception exception;

  /// The stack trace of the exception
  final StackTrace? stackTrace;
}
