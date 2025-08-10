import 'package:flutter/material.dart';

void main() {
  runApp(const DesafioRickAndMortyApp());
}

class DesafioRickAndMortyApp extends StatelessWidget {
  const DesafioRickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(), // Tela vazia, sem conteúdo
    );
  }
}
