class EpisodesModel {
  final int id;
  final String name;
  final String date;
  final String episode;

  EpisodesModel({
    required this.id,
    required this.name,
    required this.date,
    required this.episode,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    return EpisodesModel(
      id: json['id'] as int,
      name: json['name']?.toString() ?? '',
      date: json['air_date']?.toString() ?? '',
      episode: json['episode']?.toString() ?? '',
    );
  }
}
