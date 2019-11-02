import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_web_2048/features/game/domain/usecases/generate_initial_board.dart';
import 'package:flutter_web_2048/features/game/presentation/bloc/game_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';
import 'features/game/domain/usecases/update_board.dart';

final sl = GetIt.instance;

void init() {
  //! Features
  initGameFeature();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => DataConnectionCheckerNetworkInfo(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void initGameFeature() {
  // Bloc
  sl.registerFactory(
    () => GameBloc(
      updateBoard: sl(),
      generateInitialBoard: sl()
    ),
  );

  sl.registerLazySingleton(()=> UpdateBoard());
  sl.registerLazySingleton(()=> GenerateInitialBoard());
}
