import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const RickMortyApp());
}

class RickMortyApp extends StatelessWidget {
  const RickMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}
