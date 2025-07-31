class PaginatedMovies {
  PaginatedMovies({
    required this.page,
    required this.results,
    required this.dates,
    required this.totalPages,
    required this.totalResults,
  });
  final int page;
  final List<Movie> results;
  final Date dates;
  final int totalPages;
  final int totalResults;

  factory PaginatedMovies.fromJson(Map<String, dynamic> json) {
    return PaginatedMovies(
      page: json['page'],
      results:
          List.from(json['results']).map((e) => Movie.fromJson(e)).toList(),
      dates: Date.fromJson(json['dates']),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((e) => e.toJson()).toList(),
      'dates': dates.toJson(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class Movie {
  Movie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });
  final String posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double? voteAverage;

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      posterPath: json['poster_path'],
      adult: json['adult'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genreIds: List.castFrom<dynamic, int>(json['genre_ids']),
      id: json['id'],
      originalTitle: json['original_title'],
      originalLanguage: json['original_language'],
      title: json['title'],
      backdropPath: json['backdrop_path'],
      popularity: json['popularity'],
      voteCount: json['vote_count'],
      video: json['video'],
      voteAverage: json['vote_average']?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poster_path': posterPath,
      'adult': adult,
      'overview': overview,
      'release_date': releaseDate,
      'genre_ids': genreIds,
      'id': id,
      'original_title': originalTitle,
      'original_language': originalLanguage,
      'title': title,
      'backdrop_path': backdropPath,
      'popularity': popularity,
      'vote_count': voteCount,
      'video': video,
      'vote_average': voteAverage,
    };
  }
}

class Date {
  Date({
    required this.maximum,
    required this.minimum,
  });
  final String maximum;
  final String minimum;

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      maximum: json['maximum'],
      minimum: json['minimum'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maximum': maximum,
      'minimum': minimum,
    };
  }
}
