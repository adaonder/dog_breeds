import 'package:cached_network_image/cached_network_image.dart';

class DogBreedsModel {
  String? breedName;
  String? imageUrl;
  CachedNetworkImage image;

  DogBreedsModel(this.breedName, this.imageUrl, this.image);

  static List<String> fromJson(Map<String, dynamic> parsedJson) {
    List<String> list = [];
    parsedJson.forEach((key, value) {
      list.add(key);
    });

    //print(list);

    return list;
  }
}
