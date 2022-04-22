import 'package:flutter/material.dart';
import 'package:kode_start_tmdb/models/paginated_movies.dart';
import 'package:kode_start_tmdb/theme/app_colors.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, required this.onTap, Key? key}) : super(key: key);

  final Movie movie;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(movie.releaseDate);

    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "https://image.tmdb.org/t/p/w1000_and_h450_multi_faces${movie.backdropPath}",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "${movie.title.toUpperCase()} (${date.year})",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
