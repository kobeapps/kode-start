import 'package:dio/dio.dart';
import 'package:kode_start_tmdb/models/detailed_movie.dart';
import 'package:kode_start_tmdb/models/paginated_movies.dart';

abstract class Repository {
  static final _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {"api_key": "c5850ed73901b8d268d0898a8a9d8bff"},
    ),
  );

  static Future<PaginatedMovies> getUpcomingMovies() async {
    var response = await _dio.get("/movie/upcoming");
    return PaginatedMovies.fromJson(response.data);
  }

  static Future<DetailedMovie> getMovieDetails(int movieId) async {
    var response = await _dio.get("/movie/$movieId");
    return DetailedMovie.fromJson(response.data);
  }
}
