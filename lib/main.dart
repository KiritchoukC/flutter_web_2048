import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'core/router/route_paths.dart';
import 'core/router/router.dart';
import 'core/theme/custom_theme.dart';
import 'features/authentication/presentation/bloc/bloc.dart';
import 'features/game/presentation/bloc/game_bloc.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';

Future main() async {
  // configure Logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) => print(record.toString()));

  // init logging of BLoC transitions
  initBlocLogging();

  // ensure the widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // no need to init hive for browser
  if (!kIsWeb) {
    // init Hive for mobile
    Hive.init((await path_provider.getApplicationDocumentsDirectory()).path);
  }

  // dependency injection
  await di.init();

  // run the app
  runApp(MyApp());
}

void initBlocLogging() {
  // only in debug mode
  if (!kReleaseMode) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(create: (_) => sl<GameBloc>()),
        BlocProvider<AuthenticationBloc>(create: (_) => sl<AuthenticationBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '2048',
        theme: customTheme,
        initialRoute: RoutePaths.game,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  final _logger = Logger('Bloc');
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    _logger.info(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _logger.info(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    _logger.info(error);
  }
}
