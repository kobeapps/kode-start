import 'package:dio/dio.dart';

import 'datasources.dart';

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;

  CharacterDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<void> getCharacterFromApi() async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character',
      );

      // TODO: implementar lógica do Json

      print('resposta da api chegou');
    } on DioException catch (e) {
      print('Erro de Dio ao buscar os personagens: $e');
      throw Exception('Falha na comunicação com o servidor');
    } catch (e) {
      print('Erro inesperado: $e');
      throw Exception('Ocorreu um erro inesperado');
    }
  }
}
