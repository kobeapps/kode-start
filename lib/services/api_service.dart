import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiService {
  static Future<List<Character>> fetchCharacters({int page = 1}) async {
    final url = Uri.parse('https://rickandmortyapi.com/api/character?page=\$page');
    final res = await http.get(url);
    if (res.statusCode != 200) {
      throw Exception('Failed to load characters');
    }
    final data = json.decode(res.body);
    final results = data['results'] as List<dynamic>;
    return results.map((e) => Character.fromJson(e as Map<String,dynamic>)).toList();
  }
}
