import 'package:equatable/equatable.dart';

class CharacterLocation extends Equatable {
  final String name;

  const CharacterLocation({required this.name});

  @override
  List<Object?> get props => [name];
}
