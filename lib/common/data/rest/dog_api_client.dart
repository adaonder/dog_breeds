import 'package:dio/dio.dart';
import 'package:dog_breeds/common/constants/parameters.dart';
import 'package:dog_breeds/common/data/model/api_response.dart';
import 'package:flutter/material.dart';

class DogApiClient {
  final httpClientProvider = Dio(BaseOptions(baseUrl: Parameters.baseUrl));

  Future<ApiResponse<Map<String, dynamic>>> getDogBreeds() async {
    //debugPrint("httpClientProvider baseUrl: ${httpClientProvider.options.baseUrl}");

    final result = await httpClientProvider.get(Parameters.breedsAll);

    debugPrint("result: ${result.statusCode}");

    if (result.statusCode != 200) {
      return ApiResponse(status: "Veri getirilirken bir sorun oluştu.");
    }

    //debugPrint("result.data: ${result.data}");
    Map<String, dynamic> resultMap = result.data;

    return ApiResponse.fromMap(resultMap);
  }

  Future<ApiResponse> getDogBreedImageUrl(String breed) async {
    //debugPrint("httpClientProvider baseUrl: ${httpClientProvider.options.baseUrl}");

    final result = await httpClientProvider.get(Parameters.imageUrl.replaceFirst("breedVar", breed));

    //debugPrint("result: ${result.statusCode}");

    if (result.statusCode != 200) {
      return ApiResponse(status: "Veri getirilirken bir sorun oluştu.");
    }

    //debugPrint("result.data: ${result.data}");
    Map<String, dynamic> resultMap = result.data;

    return ApiResponse.fromMap(resultMap);
  }
}
