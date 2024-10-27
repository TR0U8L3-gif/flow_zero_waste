import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/config/l10n/l10n.dart';
import 'package:flow_zero_waste/config/routes/navigation_router.dart';
import 'package:flow_zero_waste/core/common/data/exceptions.dart';
import 'package:flow_zero_waste/core/common/presentation/logics/providers/page_provider.dart';
import 'package:flow_zero_waste/core/common/presentation/pages/error_page.dart';
import 'package:flow_zero_waste/core/enums/build_type_enum.dart';
import 'package:flow_zero_waste/core/extensions/l10n_extension.dart';
import 'package:flow_zero_waste/core/services/setup/app_env.dart';
import 'package:flow_zero_waste/core/services/setup/app_setup.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flow_zero_waste/src/ui/presentation/logics/text_scale_provider.dart';
import 'package:flow_zero_waste/src/ui/presentation/logics/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

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
      ChangeNotifierProvider(
        create: (context) =>
            locator<LanguageProvider>()..loadLanguageOrSetDeviceLocale(),
      ),
      ChangeNotifierProvider(
        create: (context) => locator<PageProvider>(),
      ),
      ChangeNotifierProvider(
        create: (context) =>
            locator<ThemeProvider>()..brightnessFromThemeMode(ThemeMode.system),
      ),
      ChangeNotifierProvider(
        create: (context) => locator<TextScaleProvider>(),
      ),
    ];

    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        final languageProvider = context.watch<LanguageProvider>();
        final textScaleProvider = context.watch<TextScaleProvider>();
        final themeProvider = context.watch<ThemeProvider>();
        final pageProvider = context.read<PageProvider>();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          pageProvider.updatePageSize(MediaQuery.sizeOf(context));
        });

        if (result is MyAppFailure) {
          return MaterialApp(
            title: title,
            theme: themeProvider.themeData,
            supportedLocales: supportedLocales,
            locale: languageProvider.currentLanguage,
            localizationsDelegates: localizationsDelegates,
            home: ErrorPage(
              reportError: true,
              data: ErrorPageData(
                title: context.l10n.appInitErrorTitle,
                message: () {
                  try {
                    return ((result as MyAppFailure).exception as BaseException)
                        .message;
                  } catch (e) {
                    return context.l10n.unknownErrorOccurred;
                  }
                }(),
                exception: (result as MyAppFailure).exception,
                stackTrace: (result as MyAppFailure).stackTrace,
              ),
            ),
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: textScaleProvider.textScaler,
                ),
                child: child!,
              );
            },
          );
        } else {
          return MaterialApp.router(
            title: title,
            theme: themeProvider.themeData,
            supportedLocales: supportedLocales,
            locale: languageProvider.currentLanguage,
            localizationsDelegates: localizationsDelegates,
            routerConfig: locator<NavigationRouter>().config(),
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: textScaleProvider.textScaler,
                ),
                child: child!,
              );
            },
          );
        }
      },
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
