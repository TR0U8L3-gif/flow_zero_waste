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

  /// Returns the input type for the navigation type
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

/// Navigation input
enum NavigationInput {
  /// No input
  none,
  /// Route input
  route,
  /// List of Routes input
  list,
}
