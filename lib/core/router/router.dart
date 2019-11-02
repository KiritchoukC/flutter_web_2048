import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/game/presentation/bloc/game_bloc.dart';
import '../../features/game/presentation/pages/game_page.dart';
import '../../injection_container.dart';
import 'route_paths.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Game:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<GameBloc>(
                builder: (_) => sl<GameBloc>(), child: GamePage()));
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
