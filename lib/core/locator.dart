import 'package:get_it/get_it.dart';
import 'package:sezinsoft_demo/core/services/dialog_service.dart';
import 'api/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => Api());
}
