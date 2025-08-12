import 'package:app_kobe_alex/pages/auth_check_page.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const AuthCheckPage(),
    );
  }
}
