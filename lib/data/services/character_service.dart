// lib/data/services/character_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character_model.dart';
import '../../utils/constants.dart';

class CharacterService {
  // Este método busca a lista de personagens com suporte para busca e paginação.
  Future<List<Character>> getCharacters({String? name, int page = 1}) async {
    final uri = Uri.https(
      'rickandmortyapi.com',
      '/api/character',
      <String, String>{
        'page': page.toString(),
        if (name != null && name.isNotEmpty) 'name': name,
      },
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];

        final List<Character> characters = results.map((charJson) {
          return Character.fromJson(charJson);
        }).toList();

        return characters;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Falha ao carregar os personagens');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }

  
  // Ele busca dados de uma URL específica, como a de um episódio.
  Future<Map<String, dynamic>> getDataFromUrl(String url) async {
    // Se por algum motivo a URL estiver vazia, eu retorno um resultado padrão.
    if (url.isEmpty) {
      return {'name': 'N/A'};
    }

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Se a chamada for bem-sucedida, eu retorno o JSON decodificado.
        return json.decode(response.body);
      } else {
        throw Exception('Falha ao carregar dados da URL');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
