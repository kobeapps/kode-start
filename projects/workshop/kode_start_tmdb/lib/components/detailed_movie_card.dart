import 'package:flutter/material.dart';
import 'package:kode_start_tmdb/models/detailed_movie.dart';
import 'package:kode_start_tmdb/theme/app_colors.dart';

class DetailedMovieCard extends StatelessWidget {
  const DetailedMovieCard({required this.detailedMovie, Key? key})
      : super(key: key);

  final DetailedMovie detailedMovie;

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(detailedMovie.releaseDate);

    final companieNames =
        detailedMovie.productionCompanies.map((company) => company.name);
    final allCompanies =
        companieNames.reduce((value, element) => value + ', ' + element);

    return Card(
      color: AppColors.primaryColorLight,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "https://image.tmdb.org/t/p/w1000_and_h450_multi_faces${detailedMovie.backdropPath}",
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${detailedMovie.title.toUpperCase()} (${date.year})",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: detailedMovie.genres
                      .map(
                        (genre) => Chip(
                          backgroundColor: AppColors.primaryColorLight,
                          labelStyle: TextStyle(color: AppColors.white),
                          side: BorderSide(color: AppColors.white),
                          label: Text(genre.name),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 15),
                Text(
                  detailedMovie.overview,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Production Companies:',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  allCompanies,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
