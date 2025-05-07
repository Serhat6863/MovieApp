import 'package:flutter/material.dart';

import 'features/home/presentation/screen/home_screen.dart';
import 'features/splash/presentation/screen/splash_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text(
                '404 - Page non trouvée',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        );
    }
  }
}
