import 'package:rick_and_morty_app/features/character/data/models/models.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/entities.dart';

class CharacterModel extends Character {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.image,
    required super.species,
    required super.gender,
    required super.status,
    required super.origin,
    required super.location,
    required super.firstEpisodeUrl,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final episodeList = json['episode'] as List;
    final firstEpisode = episodeList.isNotEmpty
        ? episodeList.first as String
        : '';

    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      status: json['status'] as String,
      origin: OriginModel.fromJson(json['origin'] as Map<String, dynamic>),
      location: LocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      firstEpisodeUrl: firstEpisode,
    );
  }
}
