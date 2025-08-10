import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api_client.dart';
import '../../../core/providers.dart';
import '../../../core/paginated_response.dart';
import 'location_model.dart';

class LocationService {
  LocationService(this._client);
  final ApiClient _client;

  Future<PaginatedResponse<LocationRM>> fetchLocations({
    int page = 1,
    String? name,
    String? type,
    String? dimension,
  }) async {
    final q = <String, dynamic>{'page': page};
    if (name?.isNotEmpty == true) q['name'] = name;
    if (type?.isNotEmpty == true) q['type'] = type;
    if (dimension?.isNotEmpty == true) q['dimension'] = dimension;

    final res = await _client.get<Map<String, dynamic>>('/location', query: q);
    final data = res.data!;
    final info = PageInfo.fromJson(data['info']);
    final results = (data['results'] as List<dynamic>)
        .map((e) => LocationRM.fromJson(e as Map<String, dynamic>))
        .toList();
    return PaginatedResponse(info: info, results: results);
  }

  Future<LocationRM> fetchLocation(int id) async {
    final res = await _client.get<Map<String, dynamic>>('/location/$id');
    return LocationRM.fromJson(res.data!);
  }

  Future<List<LocationRM>> fetchMultiple(List<int> ids) async {
    if (ids.isEmpty) return [];
    final res = await _client.get<dynamic>('/location/${ids.join(',')}');
    final d = res.data;
    if (d is List) return d.map((e) => LocationRM.fromJson(e)).toList();
    return [LocationRM.fromJson(d as Map<String, dynamic>)];
  }
}

final locationServiceProvider = Provider<LocationService>(
    (ref) => LocationService(ref.read(apiClientProvider)));
