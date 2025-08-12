//Classe para representar um personagem do Rick and Morty
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String originName;
  final String locationName;
  final String imageUrl;
  final String firstEpisodeUrl;

// Construtor da classe Character
  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.originName,
    required this.locationName,
    required this.imageUrl,
    required this.firstEpisodeUrl,
  });

  // Um "factory constructor" para criar um Character a partir de um JSON (Map)
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      originName: json['origin']['name'],
      locationName: json['location']['name'],
      imageUrl: json['image'],
      // A primeira aparição está na primeira URL da lista de episódios
      firstEpisodeUrl: (json['episode'] as List).isNotEmpty ? json['episode'][0] : '',
    );
  }
}