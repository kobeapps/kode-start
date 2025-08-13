class CharModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String imageUrl;
  final String location;
  final String origin;

  CharModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.imageUrl,
    required this.location,
    required this.origin,
  });

factory CharModel.fromJson(Map<String, dynamic> json) {
    return CharModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      imageUrl: json['image'],
      location: json['location']['name'],
      origin: json['origin']['name'],
    );
  }
}