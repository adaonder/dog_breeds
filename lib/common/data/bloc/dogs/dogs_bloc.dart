import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breeds/common/data/getit/locator.dart';
import 'package:dog_breeds/common/data/model/api_response.dart';
import 'package:dog_breeds/common/data/model/dog_breeds_model.dart';
import 'package:dog_breeds/common/data/rest/dog_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dogs_event.dart';

part 'dogs_state.dart';

class DogsBloc extends Bloc<DogsEvent, DogsState> {
  final DogRepository repository = locator<DogRepository>();

  DogsBloc() : super(DogsInitial()) {
    on<DogsEvent>((event, emit) async {
      emit(DogsLoadingState());

      try {
        ApiResponse<Map<String, dynamic>> apiResponse = await repository.getDogBreeds();

        final list = DogBreedsModel.fromJson(apiResponse.message!);

        List<DogBreedsModel> breeds = [];

        List<Future> futureList = [];
        for (final item in list) {
          //debugPrint("item $item");
          Future<ApiResponse> responseImage = repository.getBreedRandomImage(item);

          responseImage.then((value) {
            //debugPrint("Breed : $item = ${value.message}");
            breeds.add(
              DogBreedsModel(
                item,
                value.message,
                CachedNetworkImage(imageUrl: value.message, fit: BoxFit.cover),
              ),
            );
          });

          futureList.add(responseImage);
        }

        await Future.wait(futureList);

        //debugPrint("Hepsi bitti... Total: ${breeds.length}");

        if (apiResponse.message == null) {
          emit(DogsErrorState(apiResponse.status ?? "Bilinmeyen bir hata oluştu"));
        } else {
          emit(DogsLoadedState(apiResponse: ApiResponse(message: breeds)));
        }
      } catch (_) {
        emit(DogsErrorState("Bilinmeyen bir hata oluştu"));
      }
    });
  }
}
