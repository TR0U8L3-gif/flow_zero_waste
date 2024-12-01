import 'package:auto_route/auto_route.dart';
import 'package:flow_zero_waste/config/injection/injection.dart';
import 'package:flow_zero_waste/src/browse/presentation/logics/shops_cubit.dart';
import 'package:flow_zero_waste/src/language/presentation/logics/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BrowseNavigationPage extends StatelessWidget implements AutoRouteWrapper {
  const BrowseNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final language = context.watch<LanguageProvider>();
    return BlocProvider(
      create: (context) => locator<ShopsCubit>()..getShops(language.currentLanguage.languageCode),
      child: this,
    );
  }
}
