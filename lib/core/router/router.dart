import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_2048/features/authentication/presentation/pages/sign_up_page.dart';

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
          settings: const RouteSettings(
            name: RoutePaths.game,
          ),
        );

      // Authentication route
      case RoutePaths.authentication:
        return MaterialPageRoute(
          builder: (_) => AuthenticationPage(),
          settings: const RouteSettings(name: RoutePaths.authentication),
        );

      // Authentication route
      case RoutePaths.signUp:
        final args = settings.arguments as SignUpPageArguments;
        return MaterialPageRoute(
          builder: (_) => SignUpPage(name: args.name, email: args.email, password: args.password),
          settings: const RouteSettings(name: RoutePaths.signUp),
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
