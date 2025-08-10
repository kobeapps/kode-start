import 'package:flutter/material.dart';
import 'router/app_router.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6F8EF6),
      brightness: Brightness.dark,
      useMaterial3: true,
    );
    return MaterialApp.router(
      title: 'Rick and Morty API',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: appRouter,
    );
  }
}
