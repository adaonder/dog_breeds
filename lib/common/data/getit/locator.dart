
import 'package:dog_breeds/common/data/rest/dog_api_client.dart';
import 'package:dog_breeds/common/data/rest/dog_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => DogRepository());
  locator.registerLazySingleton(() => DogApiClient());
}
