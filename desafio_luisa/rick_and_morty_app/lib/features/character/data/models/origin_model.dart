import 'package:rick_and_morty_app/features/character/domain/entities/entities.dart';

class OriginModel extends CharacterOrigin {
  const OriginModel({required super.name});

  factory OriginModel.fromJson(Map<String, dynamic> json) {
    return OriginModel(name: json['name'] as String);
  }
}
