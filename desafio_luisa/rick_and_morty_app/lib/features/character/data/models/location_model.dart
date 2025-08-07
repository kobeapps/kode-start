import 'package:rick_and_morty_app/features/character/domain/entities/entities.dart';

class LocationModel extends CharacterLocation {
  const LocationModel({required super.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(name: json['name'] as String);
  }
}
