import 'package:dio/dio.dart';
import '../models/character_model.dart';

class CharacterRepository {
  final Dio _dio;

  CharacterRepository()
    : _dio = Dio(
        BaseOptions(
          baseUrl: 'https://rickandmortyapi.com/api',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      );

  Future<List<CharacterModel>> getCharacters({String? query}) async {
    try {
      final response = await _dio.get(
        '/character',
        queryParameters: (query != null && query.isNotEmpty)
            ? {'name': query}
            : null,
      );
      final result = response.data['results'] as List;
      final characterList = result
          .map((json) => CharacterModel.fromJson(json))
          .toList();
      return characterList;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }

      throw Exception('Falha ao buscar personagens: ${e.message}');
    } catch (e) {
      throw Exception('Falha ao buscar personagens:(Exception) $e');
    }
  }
}
