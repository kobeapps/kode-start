import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_morty_api/pages/details_page.dart';
import 'package:rick_morty_api/pages/home_page.dart';

void main() {
  runApp(const RMApp());
}

class RMApp extends StatelessWidget {
  const RMApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(), 
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case DetailsPage.routeId: 
            final movieId = settings.arguments as int;
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