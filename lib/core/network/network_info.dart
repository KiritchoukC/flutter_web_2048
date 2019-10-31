import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class DataConnectionCheckerNetworkInfo implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  DataConnectionCheckerNetworkInfo(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
