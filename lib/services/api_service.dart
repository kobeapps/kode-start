import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<Character>> fetchCharacters({int page = 1}) async {
    final response = await http.get(Uri.parse('$baseUrl/character?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar personagens');
    }
  }
}
