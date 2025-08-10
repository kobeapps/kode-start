class LocationRM {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residentUrls;

  LocationRM({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residentUrls,
  });

  factory LocationRM.fromJson(Map<String, dynamic> json) => LocationRM(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        type: json['type'] ?? '',
        dimension: json['dimension'] ?? '',
        residentUrls:
            (json['residents'] as List<dynamic>? ?? []).cast<String>(),
      );
}
