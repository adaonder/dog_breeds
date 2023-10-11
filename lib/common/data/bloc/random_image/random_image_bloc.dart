

import 'package:dog_breeds/common/data/getit/locator.dart';
import 'package:dog_breeds/common/data/model/api_response.dart';
import 'package:dog_breeds/common/data/rest/dog_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'random_image_event.dart';

part 'random_image_state.dart';

class RandomImageBloc extends Bloc<RandomImageEvent, RandomImageState> {
  final DogRepository repository = locator<DogRepository>();

  RandomImageBloc() : super(RandomImageInitial()) {
    on<FetchRandomImageEvent>((event, emit) async {

      emit(RandomImageLoadingState());

      debugPrint("Test RandomImageBloc on 2 ${event.breed}");

      try {
        ApiResponse apiResponse = await repository.getBreedRandomImage(event.breed);

        debugPrint("Test 1 apiResponse: ${apiResponse.message}");

        if (apiResponse.message == null) {
          emit(RandomImageErrorState(apiResponse.status ?? "Bilinmeyen bir hata oluştu"));
        } else {
          debugPrint("Test 2");
          emit(RandomImageLoadedState(imageUrl: apiResponse.message));
        }
      } catch (error) {
        debugPrint("Test 5 $error}");
        emit(RandomImageErrorState("Bilinmeyen bir hata oluştu"));
      }
    });
  }
}
