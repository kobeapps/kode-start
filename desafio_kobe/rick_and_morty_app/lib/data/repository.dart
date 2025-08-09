import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/models/character_details.dart';
import 'package:rick_and_morty_app/models/paginated_characters.dart';

abstract class Repository {
  static final _dio = Dio(
    BaseOptions(baseUrl: "https://rickandmortyapi.com/api"),
  );

  static Future<PaginatedCharacters> getCharacters({
    String? status,
    String? species,
    String? gender,
  }) async {
    Map<String, dynamic> queryParams = {};

    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }
    if (species != null && species.isNotEmpty) {
      queryParams['species'] = species;
    }
    if (gender != null && gender.isNotEmpty) {
      queryParams['gender'] = gender;
    }

    var response = await _dio.get("/character", queryParameters: queryParams);
    return PaginatedCharacters.fromJson(response.data);
  }

  static Future<CharacterDetails> getCharacterDetails(int characterId) async {
    var response = await _dio.get("/character/$characterId");
    return CharacterDetails.fromJson(response.data);
  }

  static Future<String> getEpisodeNameFromUrl(String episodeUrl) async {
    try {
      var response = await _dio.get(episodeUrl);
      return response.data['name'];
    } catch (e) {
      print("Erro ao buscar nome do episódio: $e");
      return "Desconhecido";
    }
  }
}
