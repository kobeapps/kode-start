import 'package:equatable/equatable.dart';

class CharacterOrigin extends Equatable {
  final String name;

  const CharacterOrigin({required this.name});

  @override
  List<Object?> get props => [name];
}
