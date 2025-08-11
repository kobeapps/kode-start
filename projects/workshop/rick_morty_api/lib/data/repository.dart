import 'package:dio/dio.dart';
import 'package:rick_morty_api/models/character_list.dart';
import 'package:rick_morty_api/models/detailed_character.dart';  // Importe seu modelo detalhado aqui

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
      throw Exception('Falha ao carregar personagens: ${response.statusCode}');
    }
  }

  static Future<DetailedCharacter> getCharacterDetails(int id) async {
    final response = await _dio.get('character/$id');

    if (response.statusCode == 200) {
      return DetailedCharacter.fromMap(response.data);
    } else {
      throw Exception('Falha ao carregar detalhes do personagem: ${response.statusCode}');
    }
  }
  


}
