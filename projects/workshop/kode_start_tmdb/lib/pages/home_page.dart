import 'package:flutter/material.dart';
import 'package:kode_start_tmdb/components/app_bar_component.dart';
import 'package:kode_start_tmdb/components/movie_card.dart';
import 'package:kode_start_tmdb/data/repository.dart';
import 'package:kode_start_tmdb/models/paginated_movies.dart';
import 'package:kode_start_tmdb/pages/details_page.dart';
import 'package:kode_start_tmdb/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PaginatedMovies>? movies;

  @override
  initState() {
    movies = Repository.getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: movies,
        builder: (context, AsyncSnapshot<PaginatedMovies> snapshot) {
          if (snapshot.hasData) {
            final dataResults = snapshot.data!.results;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 7.5),
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: dataResults[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetailsPage.routeId,
                      arguments: dataResults[index].id,
                    );
                  },
                );
              },
              itemCount: dataResults.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
