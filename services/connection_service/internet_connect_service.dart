import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionService {
  static final InternetConnectionService _instance = InternetConnectionService._internal();

  factory InternetConnectionService() {
    return _instance;
  }

  InternetConnectionService._internal();

  Stream<ConnectivityResult> get internetStatusStream =>
      Connectivity().onConnectivityChanged;

  Future<bool> checkInternetStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
