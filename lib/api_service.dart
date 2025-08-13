import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kobeproj/char_model.dart';

Future<CharModel> fetchCharacter(int id) async {
  final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));
  if (response.statusCode == 200) {
    return CharModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load character');
  }
}

Future<List<CharModel>> fetchCharacters() async {
  final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final List<dynamic> results = data['results'];
    return results.map((json) => CharModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load characters');
  }
}