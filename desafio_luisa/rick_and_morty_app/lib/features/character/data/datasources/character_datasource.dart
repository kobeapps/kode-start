import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';

abstract class CharacterDatasource {
  Future<List<CharacterModel>> getCharacterFromApi({String? query});
  Future<EpisodesModel> getEpisodeByUrl(String url);
}

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;

  CharacterDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<CharacterModel>> getCharacterFromApi({String? query}) async {
    String url = 'https://rickandmortyapi.com/api/character';

    if (query != null && query.isNotEmpty) {
      url += '/?name=$query';
    }

    try {
      final response = await _dio.get(url);

      final results = response.data['results'] as List;

      final characters = results
          .map((json) => CharacterModel.fromJson(json))
          .toList();

      return characters;
    } on DioException catch (e) {
      print('Erro de Dio ao buscar os personagens: $e');
      throw Exception('Falha na comunicação com o servidor');
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return [];
      }
      print('Erro inesperado: $e');
      throw Exception('Ocorreu um erro inesperado');
    }
  }

  @override
  Future<EpisodesModel> getEpisodeByUrl(String url) async {
    try {
      final response = await _dio.get(url);

      final episode = EpisodesModel.fromJson(response.data);

      return episode;
    } catch (e) {
      print('Não foi possivel buscar episódio');
      throw Exception('Falha ao buscar dados do episódio');
    }
  }
}
