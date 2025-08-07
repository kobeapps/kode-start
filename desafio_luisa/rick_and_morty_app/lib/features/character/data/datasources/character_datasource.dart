import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> getCharacterFromApi();
}

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;

  CharacterDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<CharacterModel>> getCharacterFromApi() async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
      );

      final results = response.data['results'] as List;

      final characters = results
          .map((json) => CharacterModel.fromJson(json))
          .toList();

      return characters;
    } on DioException catch (e) {
      print('Erro de Dio ao buscar os personagens: $e');
      throw Exception('Falha na comunicação com o servidor');
    } catch (e) {
      print('Erro inesperado: $e');
      throw Exception('Ocorreu um erro inesperado');
    }
  }
}
