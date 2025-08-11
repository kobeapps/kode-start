import 'package:dio/dio.dart';
import 'package:rick_morty_thiago_arend/models/episode.dart';
import 'package:rick_morty_thiago_arend/models/paginated_characters.dart';

abstract class Repository {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: "https://rickandmortyapi.com/api",
    ),
  );

  static Future<PaginatedCharacters> getCharactersByPage(int pageNumber) async {
    var response = await _dio.get('/character/?page=$pageNumber');
    return PaginatedCharacters.fromJson(response.data);
  }

  static Future<Episode> getEpisodeById(String id) async {
    var response = await _dio.get('/episode/$id');
    return Episode.fromJson(response.data);
  }

  static Future<PaginatedCharacters> getCharactersByNameAndPage(String name, int page) async {
    var response = await _dio.get("/character/?name=$name&page=$page");
    return PaginatedCharacters.fromJson(response.data);
  }
}
