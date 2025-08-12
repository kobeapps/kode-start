
class CharacterModel {
  final int id;
  final String name;
  final String image;
  final String species;
  final String type;
  final String gender;
  final String created;
  final String status;
  final String origin;
  final String location;

  CharacterModel({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.type,
    required this.gender,
    required this.created,
    required this.status,
    required this.origin,
    required this.location,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id']?? 0,
      name: json['name'] ?? 'Sem Nome',
      image: json['image'] ?? '',
      species: json['species'] ?? 'Unknown', 
      type: json['type']?? '',
      gender: json['gender'] ?? 'Unknown',
      created: json['created'] ?? '',
      status: json['status'] ?? 'Unknown',
      origin: json['origin'] ? ['name'] ?? 'Unknown',
      location: json['location'] ? ['name'] ?? 'Unknown',
    );
  }
}
    
    
  

