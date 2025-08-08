import 'package:rick_and_morty_app/features/character/data/models/models.dart';

class CharacterModel {
  CharacterModel({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.gender,
    required this.status,
    required this.origin,
    required this.location,
    required this.firstEpisodeUrl,
  });

  final int id;
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;
  final OriginModel origin;
  final CharacterLocationModel location;
  final String firstEpisodeUrl;

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final episodeList = (json['episode'] as List?) ?? [];
    final firstEpisode = episodeList.isNotEmpty
        ? episodeList.first.toString()
        : '';

    return CharacterModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      species: json['species']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      origin: OriginModel.fromJson(
        (json['origin'] as Map<String, dynamic>?) ?? {},
      ),
      location: CharacterLocationModel.fromJson(
        (json['location'] as Map<String, dynamic>?) ?? {},
      ),
      firstEpisodeUrl: firstEpisode,
    );
  }
}
