import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailedCharacter {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  DetailedCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory DetailedCharacter.fromMap(Map<String, dynamic> map) {
    return DetailedCharacter(
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      species: map['species'] as String,
      type: map['type'] as String,
      gender: map['gender'] as String,
      origin: Origin.fromMap(map['origin'] as Map<String, dynamic>),
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      image: map['image'] as String,
      episode: List<String>.from(map['episode'] as List),
      url: map['url'] as String,
      created: map['created'] as String,
    );
  }

  Future<String> getFirstSeenIn() async {
    if (episode.isEmpty) {
      return 'Unknown episode';
    }
    final firstEpisodeUrl = episode.first;
    final response = await http.get(Uri.parse(firstEpisodeUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['name'] ?? 'Unknown episode';
    } else {
      throw Exception('Failed to fetch first episode');
    }
  }
}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  factory Origin.fromMap(Map<String, dynamic> map) {
    return Origin(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}
