import '../main.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  Future<dynamic>? navigateRemoveAndUntilNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (_) => false, arguments: arguments);
  }

  Future<dynamic>? navigatePushNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? navigatePushReplacementNamed(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? navigatePushReplacementNamedAnimation(String routeName, {dynamic arguments}) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop({dynamic result}) {
    return navigatorKey.currentState?.pop(result ?? false);
  }
}
