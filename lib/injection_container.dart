import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';
import 'features/game/data/repositories/local_board_repository.dart';
import 'features/game/domain/repositories/board_repository.dart';
import 'features/game/domain/usecases/get_current_board.dart';
import 'features/game/domain/usecases/update_board.dart';
import 'features/game/presentation/bloc/game_bloc.dart';

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
    () => GameBloc(updateBoard: sl(), getCurrentBoard: sl()),
  );

  // Usecases
  sl.registerLazySingleton(() => UpdateBoard(boardRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentBoard(boardRepository: sl()));

  // Repositories
  sl.registerLazySingleton<BoardRepository>(() => LocalBoardRepository());
}
