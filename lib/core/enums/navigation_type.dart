/// Navigation type
enum NavigationType {
  /// push route
  push,
  /// replace route
  replace,
  /// navigate route
  navigate,
  /// go back
  back,
  /// push all routes
  pushAll,
  /// replace all routes
  replaceAll,
  /// maybe pop route
  maybePop;

  NavigationInput get input {
    switch (this) {
      case NavigationType.push:
      case NavigationType.replace:
      case NavigationType.navigate:
        return NavigationInput.route;
      case NavigationType.pushAll:
      case NavigationType.replaceAll:
        return NavigationInput.list;
      case NavigationType.back:
      case NavigationType.maybePop:
        return NavigationInput.none;
    }
  }
}

enum NavigationInput {
  none,
  route,
  list,
}
