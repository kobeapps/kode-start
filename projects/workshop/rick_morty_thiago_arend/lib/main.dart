import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/app_routes.dart';
import 'package:rick_morty_thiago_arend/screens/character_details_screen.dart';
import 'package:rick_morty_thiago_arend/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RickMortyApp());
}

class RickMortyApp extends StatelessWidget {
  const RickMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.homeScreen,
      routes: {
        AppRoutes.homeScreen: (BuildContext context) => MainScreen(),
        AppRoutes.characterDetailsScreen: (BuildContext context) => CharacterDetailsScreen(),
      },
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
