part of 'dogs_bloc.dart';

@immutable
abstract class DogsState {}

class DogsInitial extends DogsState {}

class DogsLoadingState extends DogsState {}

class DogsLoadedState extends DogsState {
  final ApiResponse<List<DogBreedsModel>> apiResponse;

  DogsLoadedState({required this.apiResponse});
}


class DogsErrorState extends DogsState {
  final String message;

  DogsErrorState(this.message);
}