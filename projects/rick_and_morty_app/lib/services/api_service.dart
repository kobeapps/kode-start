import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';

  static Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$baseUrl/character'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => Character.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar personagens');
    }
  }

  // ✅ Método para pegar o nome do 1º episódio
  static Future<String> fetchEpisodeName(String episodeUrl) async {
    try {
      final res = await http.get(Uri.parse(episodeUrl));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data['name'] as String? ?? 'Desconhecido';
      }
    } catch (_) {}
    return 'Desconhecido';
  }
}