part of 'random_image_bloc.dart';

@immutable
abstract class RandomImageEvent {}

class FetchRandomImageEvent extends RandomImageEvent {
  final String breed;

  FetchRandomImageEvent(this.breed);
}
