class PaginatedCharacters {
  final List<Character> results;

  PaginatedCharacters({required this.results});

  factory PaginatedCharacters.fromJson(Map<String, dynamic> json) {
    return PaginatedCharacters(
      results: List<Character>.from(
        json['results'].map((x) => Character.fromJson(x)),
      ),
    );
  }
}

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      image: json['image'],
    );
  }
}
