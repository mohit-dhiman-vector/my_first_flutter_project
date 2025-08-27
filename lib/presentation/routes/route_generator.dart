import 'package:flutter/material.dart';
import 'package:my_first_flutter_project/presentation/features/home/screens/home_screen.dart';
import 'package:my_first_flutter_project/presentation/features/auth/screens/login_screen.dart';
import 'package:my_first_flutter_project/presentation/features/auth/screens/register_screen.dart';
import 'package:my_first_flutter_project/presentation/features/splash/splash_screen.dart';
import 'route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RouteNames.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text("Route not found"))),
    );
  }
}
