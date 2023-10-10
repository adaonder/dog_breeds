import 'package:dog_breeds/common/data/getit/locator.dart';
import 'package:dog_breeds/common/data/model/api_response.dart';
import 'package:dog_breeds/common/data/rest/dog_api_client.dart';

class DogRepository {
  DogApiClient apiClient = locator<DogApiClient>();

  Future<ApiResponse<Map<String, dynamic>>> getDogBreeds() async {
    return await apiClient.getDogBreeds();
  }

  Future<ApiResponse> getBreedRandomImage(String breed) async {
    return await apiClient.getDogBreedImageUrl(breed);
  }
}