import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../features/authentication/presentation/pages/authentication_page.dart';
import '../../features/game/presentation/pages/game_page.dart';
import 'route_paths.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Game route
      case RoutePaths.game:
        return MaterialPageRoute(
          builder: (_) => GamePage(),
          settings: RouteSettings(
            name: RoutePaths.game,
            isInitialRoute: true,
          ),
        );

      // Authentication route
      case RoutePaths.authentication:
        return MaterialPageRoute(
          builder: (_) => AuthenticationPage(),
          settings: RouteSettings(name: RoutePaths.authentication),
        );

      // NotFound route
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
