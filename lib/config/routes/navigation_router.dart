import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'navigation_router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class NavigationRouter extends RootStackRouter {

  @override
  RouteType get defaultRouteType => RouteType.material(); 
  
  @override
  List<AutoRoute> get routes => [
  ];

  @override
  List<AutoRouteGuard> get guards => [];
}
