import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';

abstract class CharacterDatasource {
  Future<CharacterResponse> getCharacterFromApi({String? query, String? url});
  Future<EpisodesModel> getEpisodeByUrl(String url);
}

class CharacterDatasourceImpl implements CharacterDatasource {
  final Dio _dio;

  CharacterDatasourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<CharacterResponse> getCharacterFromApi({
    String? query,
    String? url,
  }) async {
    String finalUrl = url ?? 'https://rickandmortyapi.com/api/character';

    if (query != null && query.isNotEmpty) {
      finalUrl += '/?name=$query';
    }

    try {
      final response = await _dio.get(finalUrl);

      final results = response.data['results'] as List;

      final characters = results
          .map((json) => CharacterModel.fromJson(json))
          .toList();

      final nextPageUrl = response.data['info']['next'] as String?;

      return CharacterResponse(
        characters: characters,
        nextPageUrl: nextPageUrl,
      );
    } on DioException catch (e) {
      print('Erro de Dio ao buscar os personagens: $e');
      throw Exception('Falha na comunicação com o servidor');
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return CharacterResponse(characters: [], nextPageUrl: null);
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
