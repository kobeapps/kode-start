import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';
import 'package:rick_and_morty_app/features/character/data/repositories/character_repository.dart';

class CharacterController extends GetxController {
  final CharacterRepository _repository = Get.find();

  final characters = <CharacterModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      isLoading.value = true;

      final charactersList = await _repository.getCharacters();
      characters.assignAll(charactersList);
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não foi possível carregar os personagens',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
