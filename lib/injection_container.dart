import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'core/network/network_info.dart';
import 'features/game/data/datasources/board_datasource.dart';
import 'features/game/data/datasources/hive_board_datasource.dart';
import 'features/game/data/repositories/local_board_repository.dart';
import 'features/game/domain/repositories/board_repository.dart';
import 'features/game/domain/usecases/get_current_board.dart';
import 'features/game/domain/usecases/get_highscore.dart';
import 'features/game/domain/usecases/get_previous_board.dart';
import 'features/game/domain/usecases/reset_board.dart';
import 'features/game/domain/usecases/update_board.dart';
import 'features/game/presentation/bloc/game_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  initGameFeature();

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => DataConnectionCheckerNetworkInfo(sl()));

  //! External
  var box = await Hive.openBox<int>('highscoreBox');
  sl.registerLazySingleton<Box<int>>(() => box);
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void initGameFeature() {
  // Bloc
  sl.registerFactory(
    () => GameBloc(
      updateBoard: sl(),
      getCurrentBoard: sl(),
      resetBoard: sl(),
      getHighscore: sl(),
      getPreviousBoard: sl(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => UpdateBoard(boardRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentBoard(boardRepository: sl()));
  sl.registerLazySingleton(() => ResetBoard(boardRepository: sl()));
  sl.registerLazySingleton(() => GetHighscore(boardRepository: sl()));
  sl.registerLazySingleton(() => GetPreviousBoard(boardRepository: sl()));

  // Repositories
  sl.registerLazySingleton<BoardRepository>(() => LocalBoardRepository(datasource: sl()));

  // Datasource
  sl.registerLazySingleton<BoardDataSource>(() => HiveBoardDataSource(localStorage: sl()));
}
