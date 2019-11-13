import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'core/theme/custom_theme.dart';
import 'core/router/route_paths.dart';
import 'core/router/router.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '2048 flutter game',
      theme: CustomTheme.themeData,
      initialRoute: RoutePaths.Game,
      onGenerateRoute: Router.generateRoute,
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}
