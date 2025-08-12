import 'package:dio/dio.dart';
import 'package:rick_morty_api/models/character_list.dart';
import 'package:rick_morty_api/models/detailed_character.dart'; 

class Repository {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api/',
      connectTimeout: Duration(milliseconds: 5000),
      receiveTimeout: Duration(milliseconds: 3000),
    ),
  );

  static Future<CharacterListModel> getCharactersPage(int page) async {
    final response = await _dio.get('character?page=$page');
    if (response.statusCode == 200) {
      return CharacterListModel.fromMap(response.data);
    } else {
      throw Exception('Failed to load characters: ${response.statusCode}');
    }
  }

  static Future<DetailedCharacter> getCharacterDetails(int id) async {
    final response = await _dio.get('character/$id');

    if (response.statusCode == 200) {
      return DetailedCharacter.fromMap(response.data);
    } else {
      throw Exception('Failed to load character details: ${response.statusCode}');
    }
  }
  
  static Future<CharacterListModel> searchCharacters({
    String? name,
    String? status,
    String? species,
    String? gender,
    int? page,
  }) async {
    final queryParameters = <String, dynamic>{};

    if (name != null && name.isNotEmpty) {
      queryParameters['name'] = name;
    }
    if (status != null && status.isNotEmpty) {
      queryParameters['status'] = status;
    }
    if (species != null && species.isNotEmpty) {
      queryParameters['species'] = species;
    }
    if (gender != null && gender.isNotEmpty) {
      queryParameters['gender'] = gender;
    }
    if (page != null && page > 0) {
      queryParameters['page'] = page.toString();
    }

    try {
      final response = await _dio.get(
        'character',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return CharacterListModel.fromMap(response.data);
      } else {
        throw Exception('Failed to search characters: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return CharacterListModel(
          info: Info(next: null, prev: null, count: 0, pages: 0),
          results: [],
        );
      }
      rethrow; 
    }
  }

  static Future<List<String>> fetchAvailableGenders() async {
    final response = await _dio.get('character?page=1');
    if (response.statusCode == 200) {
      final data = response.data;
      final results = data['results'] as List<dynamic>;
      final genders = results
          .map((e) => e['gender'] as String)
          .toSet() 
          .toList();
      return genders;
    } else {
      throw Exception('Failed to fetch genders');
    }
  }
}
