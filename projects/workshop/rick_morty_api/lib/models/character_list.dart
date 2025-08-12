import 'dart:convert';

class CharacterListModel {
  final Info info;
  final List<Result> results;

  CharacterListModel({
    required this.info,
    required this.results,
  });

  factory CharacterListModel.fromMap(Map<String, dynamic> map) {
    return CharacterListModel(
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      results: map['results'] != null
          ? List<Result>.from(
              (map['results'] as List).map(
                (x) => Result.fromMap(x as Map<String, dynamic>),
              ),
            )
          : [],
    );
  }
}

class Info {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev,
  });

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: (map['count'] as num).toInt(),
      pages: (map['pages'] as num).toInt(),
      next: map['next'] as String?,
      prev: map['prev'] as String?,
    );
  }

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Result {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final List<String> episode;
  final String url;
  final String created;

  Result({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      id: (map['id'] as num).toInt(),
      name: map['name'] as String? ?? '',
      status: map['status'] as String? ?? '',
      species: map['species'] as String? ?? '',
      type: map['type'] as String? ?? '',
      gender: map['gender'] as String? ?? '',
      origin: map['origin'] != null
          ? Origin.fromMap(map['origin'] as Map<String, dynamic>)
          : Origin(name: '', url: ''),
      location: map['location'] != null
          ? Location.fromMap(map['location'] as Map<String, dynamic>)
          : Location(name: '', url: ''),
      image: map['image'] as String? ?? '',
      episode: map['episode'] != null
          ? List<String>.from(map['episode'] as List)
          : <String>[],
      url: map['url'] as String? ?? '',
      created: map['created'] as String? ?? '',
    );
  }

  factory Result.fromJson(String source) =>
      Result.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Origin {
  final String name;
  final String url;

  Origin({
    required this.name,
    required this.url,
  });

  factory Origin.fromMap(Map<String, dynamic> map) {
    return Origin(
      name: map['name'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }

  factory Origin.fromJson(String source) =>
      Origin.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Location {
  final String name;
  final String url;

  Location({
    required this.name,
    required this.url,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }

  factory Location.fromJson(String source) =>
      Location.fromMap(json.decode(source) as Map<String, dynamic>);
}
