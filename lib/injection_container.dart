import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import 'core/network/network_info.dart';
import 'features/authentication/data/datasources/authentication_datasource.dart';
import 'features/authentication/data/datasources/firebase_authentication_datasource.dart';
import 'features/authentication/data/repositories/authentication_repository_impl.dart';
import 'features/authentication/domain/repositories/authentication_repository.dart';
import 'features/authentication/domain/usecases/signin_anonymous.dart';
import 'features/authentication/domain/usecases/signin_email_and_password.dart';
import 'features/authentication/domain/usecases/signout.dart';
import 'features/authentication/domain/usecases/signup_email_and_password.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
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

final GetIt sl = GetIt.instance;

/// Initialize de depdendency injection
Future<void> init() async {
  //! FEATURES
  initGameFeature();
  initAuthenticationFeature();

  //! CORE
  sl.registerLazySingleton<NetworkInfo>(
      () => DataConnectionCheckerNetworkInfo(sl<DataConnectionChecker>()));

  //! EXTERNAL
  final box = await Hive.openBox<int>('highscoreBox');
  sl.registerLazySingleton<Box<int>>(() => box);
  sl.registerLazySingleton(() => DataConnectionChecker());

  // Firebase dependencies
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<Firestore>(() => Firestore.instance);

  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
}

/// Register the dependencies needed for the game feature
void initGameFeature() {
  // Bloc
  sl.registerFactory(
    () => GameBloc(
      updateBoard: sl<UpdateBoard>(),
      getCurrentBoard: sl<GetCurrentBoard>(),
      resetBoard: sl<ResetBoard>(),
      getHighscore: sl<GetHighscore>(),
      getPreviousBoard: sl<GetPreviousBoard>(),
    ),
  );

  // Usecases
  sl.registerLazySingleton(() => UpdateBoard(boardRepository: sl<BoardRepository>()));
  sl.registerLazySingleton(() => GetCurrentBoard(boardRepository: sl<BoardRepository>()));
  sl.registerLazySingleton(() => ResetBoard(boardRepository: sl<BoardRepository>()));
  sl.registerLazySingleton(() => GetHighscore(boardRepository: sl<BoardRepository>()));
  sl.registerLazySingleton(() => GetPreviousBoard(boardRepository: sl<BoardRepository>()));

  // Repositories
  sl.registerLazySingleton<BoardRepository>(
      () => LocalBoardRepository(datasource: sl<BoardDataSource>()));

  // Datasource
  sl.registerLazySingleton<BoardDataSource>(
      () => HiveBoardDataSource(localStorage: sl<Box<int>>()));
}

/// Register the dependencies needed for the authentication feature
void initAuthenticationFeature() {
  // Bloc
  sl.registerFactory(() => AuthenticationBloc(
        signInAnonymous: sl<SignInAnonymous>(),
        signout: sl<SignOut>(),
        signInEmailAndPassword: sl<SignInEmailAndPassword>(),
        signUpEmailAndPassword: sl<SignUpEmailAndPassword>(),
      ));

  // Usecases
  sl.registerLazySingleton(() => SignInAnonymous(repository: sl<AuthenticationRepository>()));
  sl.registerLazySingleton(() => SignOut(repository: sl<AuthenticationRepository>()));
  sl.registerLazySingleton(
      () => SignInEmailAndPassword(repository: sl<AuthenticationRepository>()));
  sl.registerLazySingleton(
      () => SignUpEmailAndPassword(repository: sl<AuthenticationRepository>()));

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(datasource: sl<AuthenticationDatasource>()));

  // Datasource
  sl.registerLazySingleton<AuthenticationDatasource>(
    () => FirebaseAuthenticationDatasource(
      firebaseAuth: sl<FirebaseAuth>(),
      firestore: sl<Firestore>(),
      googleSignIn: sl<GoogleSignIn>(),
    ),
  );
}
