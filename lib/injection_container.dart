import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

void init() {
  //! Features

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => DataConnectionCheckerNetworkInfo(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
}

