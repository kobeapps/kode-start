class PaginatedCharacters {
  final Info info;
  final List<Result> results;

  PaginatedCharacters({
    required this.info,
    required this.results,
  });

  factory PaginatedCharacters.fromMap(Map<String, dynamic> map) {
    return PaginatedCharacters(
      info: Info.fromMap(map['info'] as Map<String, dynamic>),
      results: List<Result>.from(
        (map['results'] as List).map(
          (x) => Result.fromMap(x as Map<String, dynamic>),
        ),
      ),
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
    required this.next,
    required this.prev,
  });

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      count: map['count'] as int,
      pages: map['pages'] as int,
      next: map['next'] as String?,
      prev: map['prev'] as String?,
    );
  }
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
      id: map['id'] as int,
      name: map['name'] as String,
      status: map['status'] as String,
      species: map['species'] as String,
      type: map['type'] as String,
      gender: map['gender'] as String,
      origin: Origin.fromMap(map['origin']),
      location: Location.fromMap(map['location']),
      image: map['image'] as String,
      episode: List<String>.from(map['episode']),
      url: map['url'] as String,
      created: map['created'] as String,
    );
  }
}

class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  factory Origin.fromMap(Map<String, dynamic> map) {
    return Origin(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}

class Location {
  final String name;
  final String url;

  Location({required this.name, required this.url});

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }
}
