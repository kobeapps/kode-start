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
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      dimension: json['dimension']?.toString() ?? '',
    );
  }
}
