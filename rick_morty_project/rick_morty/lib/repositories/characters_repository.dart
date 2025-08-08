import 'package:dio/dio.dart';
import '../models/characters_info.dart';
import '../models/episode_info.dart';
import '../dtos/characters_main_info.dart';

class CharactersRepository {
  final Dio _dio = Dio();

  Future<List<CharacterMainInfo>> fetchCharacterMainInfos() async {
    try {
      final response = await _dio.get('https://rickandmortyapi.com/api/character');
      final data = response.data;
      final List results = data['results'];

      List<CharacterMainInfo> infos = [];
      for (var json in results) {
        final character = Character.fromJson(json);

        // Busca o nome do primeiro episódio (primeira aparição)
        String firstEpisodeName = '';
        if (character.episodeUrls.isNotEmpty) {
          final firstEpisodeResponse = await _dio.get(character.episodeUrls.first);
          final episode = Episode.fromJson(firstEpisodeResponse.data);
          firstEpisodeName = episode.name;
        }

        infos.add(CharacterMainInfo(
          name: character.name,
          image: character.image,
          species: character.species,
          gender: character.gender,
          status: character.status,
          origin: character.origin.name,
          lastLocation: character.lastLocation.name,
          firstEpisode: firstEpisodeName,
        ));
      }
      return infos;
    } catch (e) {
      throw Exception('Failed to load character main infos: $e');
    }
  }
}
