class Episode {
  final int id;
  final String name;
  final String airDate;
  final String code;
  final List<String> characterUrls;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.code,
    required this.characterUrls,
  });

  factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        airDate: json['air_date'] ?? '',
        code: json['episode'] ?? '',
        characterUrls:
            (json['characters'] as List<dynamic>? ?? []).cast<String>(),
      );
}
