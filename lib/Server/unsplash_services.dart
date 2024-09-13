import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_task/model/unsplash_model.dart';
import 'package:flutter_task/secrets/access_key.dart';

class UnsplashService {
  final Dio dio = Dio();
  final String accessKey = gloablAcessKey;

  UnsplashService() {
    dio.options.baseUrl = 'https://api.unsplash.com/';
    dio.options.headers['Authorization'] = 'Client-ID $accessKey';
  }
  Future<List<ImageData>> searchUnsplash(String query, int pageNum) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        'https://api.unsplash.com/search/photos',
        queryParameters: {
          'query': query,
          'page': pageNum,
          'per_page': 15,
          'client_id': 'eUjykK1eXhjDmfHCDZIfBT4_p2lyIZPymYXdLM8Qdcg',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final results = response.data['results'] as List;
        return results.map((item) => ImageData.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<List<dynamic>> fetchImages(
    int page,
  ) async {
    try {
      final response = await dio.get(
        '/photos',
        queryParameters: {
          'page': page,
          'per_page': 20,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("sucess--------");
        final List<dynamic> jsonResponse = response.data as List<dynamic>;
        return jsonResponse
            .map((json) => ImageData.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching images: $e');
      return [];
    }
  }
}
