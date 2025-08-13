class Episode {
  final String name;
  final String code;

  Episode({required this.name, required this.code});

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      name: json['name'] ?? '',
      code: json['episode'] ?? '',
    );
  }

  @override
  String toString() => '$name ($code)';
}
