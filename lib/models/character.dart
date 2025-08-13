class Character {
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String location;
  final String origin;
  final String firstEpisode;

  Character({
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.location,
    required this.origin,
    required this.firstEpisode,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      location: json['location']['name'] ?? '',
      origin: json['origin']['name'] ?? '',
      firstEpisode: json['episode'] != null && json['episode'].isNotEmpty
          ? json['episode'][0]
          : '',
    );
  }
}
