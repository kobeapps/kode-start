// lib/data/services/location_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/location_model.dart';

class LocationService {
  // A URL base da API.
  final String _baseUrl = 'https://rickandmortyapi.com/api/location';

  // O método para buscar os lugares com suporte a paginação.
  Future<List<Location>> getLocations({int page = 1}) async {
    final uri = Uri.parse('$_baseUrl?page=$page');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'] ?? [];

        final List<Location> locations = results.map((locationJson) {
          return Location.fromJson(locationJson);
        }).toList();

        return locations;
      } else {
        throw Exception('Falha ao carregar os lugares');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
