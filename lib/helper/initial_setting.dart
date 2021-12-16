import 'package:get_it/get_it.dart';
import 'package:sns_auth_demo/service/auth_service.dart';
import 'package:sns_auth_demo/storage/storage.dart';

class InitialSetting {
  final GetIt getit = GetIt.I;
  InitialSetting() {
    getit.registerSingleton<Storage>(Storage());
    getit.registerSingleton<AuthService>(AuthService());
  }
}
