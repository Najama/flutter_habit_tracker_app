class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String home = 'home';
  static const String signup = 'signup';
  static const String details = 'details';
  static const String profile = 'profile';
  static const String addhabit = 'addhabit';
}
extension GoRouterPath on String
{
  String path() => '/$this';
}
