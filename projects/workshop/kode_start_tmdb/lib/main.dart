import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/details_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const TmdbApp());
}

class TmdbApp extends StatelessWidget {
  const TmdbApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomePage.routeId:
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => const HomePage(),
            );
          case DetailsPage.routeId:
            int movieId = settings.arguments as int;
            return MaterialPageRoute(
              settings: settings,
              builder: (context) => DetailsPage(movieId: movieId),
            );
          default:
            return null;
        }
      },
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
