import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const RickAndMortyApp());
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        scaffoldBackgroundColor: const Color(0xFF0F0F10),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF151515)),
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF87A1FA)),
      ),
      home: const HomePage(),
    );
  }
}
