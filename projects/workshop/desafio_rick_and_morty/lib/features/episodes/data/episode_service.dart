import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_client.dart';
import '../../../core/providers.dart';
import '../../../core/paginated_response.dart';
import 'episode_model.dart';

class EpisodeService {
  EpisodeService(this._client);
  final ApiClient _client;

  Future<PaginatedResponse<Episode>> fetchEpisodes({
    int page = 1,
    String? name,
    String? episodeCode,
  }) async {
    final q = <String, dynamic>{'page': page};
    if (name?.isNotEmpty == true) q['name'] = name;
    if (episodeCode?.isNotEmpty == true) q['episode'] = episodeCode;

    final res = await _client.get<Map<String, dynamic>>('/episode', query: q);
    final data = res.data!;
    final info = PageInfo.fromJson(data['info']);
    final results = (data['results'] as List<dynamic>)
        .map((e) => Episode.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginatedResponse(info: info, results: results);
  }

  Future<Episode> fetchEpisode(int id) async {
    final res = await _client.get<Map<String, dynamic>>('/episode/$id');
    return Episode.fromJson(res.data!);
  }

  Future<List<Episode>> fetchMultiple(List<int> ids) async {
    if (ids.isEmpty) return [];
    final res = await _client.get<dynamic>('/episode/${ids.join(',')}');
    final d = res.data;
    if (d is List) return d.map((e) => Episode.fromJson(e)).toList();
    return [Episode.fromJson(d as Map<String, dynamic>)];
  }
}

final episodeServiceProvider = Provider<EpisodeService>(
    (ref) => EpisodeService(ref.read(apiClientProvider)));
