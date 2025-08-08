class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final OriginLocation origin;
  final OriginLocation lastLocation;
  final String image;
  final List<String> episodeUrls;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.lastLocation,
    required this.image,
    required this.episodeUrls,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      origin: OriginLocation.fromJson(json['origin']),
      lastLocation: OriginLocation.fromJson(json['location']),
      image: json['image'],
      episodeUrls: List<String>.from(json['episode']),
    );
  }
}

class OriginLocation {
  final String name;
  final String url;

  OriginLocation({
    required this.name,
    required this.url,
  });

  factory OriginLocation.fromJson(Map<String, dynamic> json) {
    return OriginLocation(
      name: json['name'],
      url: json['url'],
    );
  }
}