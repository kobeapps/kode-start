import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';
import 'package:rick_and_morty_app/features/character/data/repositories/character_repository.dart';

class EpisodeController extends GetxController {
  EpisodeController({required this.character});

  final CharacterRepository _repository = Get.find();
  final CharacterModel character;

  final episode = Rx<EpisodesModel?>(null);
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEpisode();
  }

  Future<void> fetchEpisode() async {
    try {
      isLoading.value = true;

      final result = await _repository.getEpisode(character.firstEpisodeUrl);

      episode.value = result;
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
