part of 'random_image_bloc.dart';

@immutable
abstract class RandomImageState {}

class RandomImageInitial extends RandomImageState {}

class RandomImageLoadingState extends RandomImageState {}

class RandomImageLoadedState extends RandomImageState {
  final String imageUrl;

  RandomImageLoadedState({required this.imageUrl});
}


class RandomImageErrorState extends RandomImageState {
  final String message;

  RandomImageErrorState(this.message);
}