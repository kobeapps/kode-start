import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/features/character/data/datasources/character_datasource.dart';
import 'package:rick_and_morty_app/features/character/data/repositories/character_repository.dart';

import 'features/character/presentation/presentation.dart';

void main() async {
  Get.put<Dio>(Dio());
  Get.put<CharacterDatasource>(CharacterDatasourceImpl(dio: Get.find()));
  Get.put<CharacterRepository>(CharacterRepositoryImpl(datasource: Get.find()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rick and Morty APP',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
