import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/features/character/domain/entities/entities.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String image;
  final String species;
  final String gender;
  final String status;
  final CharacterOrigin origin;
  final CharacterLocation location;
  final String firstEpisodeUrl;

  const Character({
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

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    species,
    gender,
    status,
    origin,
    location,
    firstEpisodeUrl,
  ];
}
