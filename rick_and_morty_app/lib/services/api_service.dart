import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../models/episode_model.dart';
import '../repositories/character_repository.dart';

class ApiService {
  static const String baseUrl = 'https://rickandmortyapi.com/api';
  final Map<String, Episode> _episodeCache = {};

  Future<CharactersPage> fetchCharactersPaginated({
    String? name,
    String? pageUrl,
  }) async {
    final uri = pageUrl != null
        ? Uri.parse(pageUrl)
        : Uri.parse('$baseUrl/character').replace(queryParameters: {
            if (name != null && name.isNotEmpty) 'name': name.trim(),
          });

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as Map<String, dynamic>;
      final results = (data['results'] as List<dynamic>? ?? [])
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList();
      final info = data['info'] as Map<String, dynamic>? ?? {};
      final next = info['next'] as String?;
      return CharactersPage(results: results, nextPageUrl: next);
    } else if (res.statusCode == 404) {
      return CharactersPage(results: const [], nextPageUrl: null);
    } else {
      throw Exception('Erro ao buscar personagens: ${res.statusCode}');
    }
  }

  Future<Episode> fetchEpisodeByUrl(String url) async {
    final cached = _episodeCache[url];
    if (cached != null) return cached;

    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as Map<String, dynamic>;
      final ep = Episode.fromJson(data);
      _episodeCache[url] = ep;
      return ep;
    }
    throw Exception('Erro ao buscar episódio ($url)');
  }
}
