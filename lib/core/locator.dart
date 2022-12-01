import 'package:get_it/get_it.dart';
import 'api/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {

  locator.registerLazySingleton(() => Api());
}
