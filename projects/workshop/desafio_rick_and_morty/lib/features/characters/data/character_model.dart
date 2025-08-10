class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String? originUrl;
  final String locationName;
  final String? locationUrl;
  final List<String> episodeUrls;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.episodeUrls,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        status: json['status'] ?? 'unknown',
        species: json['species'] ?? '',
        type: json['type'] ?? '',
        gender: json['gender'] ?? 'unknown',
        image: json['image'] ?? '',
        originName: (json['origin']?['name']) ?? '',
        originUrl: (json['origin']?['url']),
        locationName: (json['location']?['name']) ?? '',
        locationUrl: (json['location']?['url']),
        episodeUrls: (json['episode'] as List<dynamic>? ?? []).cast<String>(),
      );
}
