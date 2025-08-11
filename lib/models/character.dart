class Character {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;
  final Map<String,dynamic> origin;
  final Map<String,dynamic> location;
  final List<String> episodes;

  Character({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.episodes,
  });

  String get originName => origin['name'] ?? '';
  String get locationName => location['name'] ?? '';

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      origin: json['origin'] ?? {},
      location: json['location'] ?? {},
      episodes: (json['episode'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
}
