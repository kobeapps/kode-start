import 'package:flutter/material.dart';
import 'package:kode_start_tmdb/components/app_bar_component.dart';
import 'package:kode_start_tmdb/components/detailed_movie_card.dart';
import 'package:kode_start_tmdb/data/repository.dart';
import 'package:kode_start_tmdb/models/detailed_movie.dart';
import 'package:kode_start_tmdb/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({required this.movieId, super.key});

  final int movieId;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<DetailedMovie>? detailedMovie;

  @override
  initState() {
    detailedMovie = Repository.getMovieDetails(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: detailedMovie,
        builder: (context, AsyncSnapshot<DetailedMovie> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(children: [DetailedMovieCard(detailedMovie: data)]);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
