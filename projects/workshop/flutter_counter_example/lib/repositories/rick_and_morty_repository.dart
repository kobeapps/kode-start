import 'package:dio/dio.dart';
import '../data/result.dart'; 

class RickAndMortyRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Result>> fetchCharactersPage({int page = 1, String? name}) async {
    try {
      final response = await _dio.get(
        '/character',
        queryParameters: {
          'page': page,
          if (name != null && name.isNotEmpty) 'name': name,
        },
      );

      final data = response.data as Map<String, dynamic>;
      final results = (data['results'] as List<dynamic>? ?? [])
          .map((e) => Result.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList();

      return results;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }

  Future<String?> getEpisodeNameByUrl(String url) async {
    try {
      final response = await _dio.getUri(Uri.parse(url));
      final data = response.data as Map<String, dynamic>;
      return data['name'] as String?;
    } on DioException {
      return null;
    }
  }
}
