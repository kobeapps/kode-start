class LocationModel {
  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
  });

  final int id;
  final String name;
  final String type;
  final String dimension;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      dimension: json['dimension']?.toString() ?? '',
    );
  }
}
