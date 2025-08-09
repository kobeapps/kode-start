import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';
import 'package:rick_and_morty_app/features/character/data/repositories/character_repository.dart';

class CharacterController extends GetxController {
  final CharacterRepository _repository = Get.find();

  final characters = <CharacterModel>[].obs;
  final isLoading = false.obs;

  final searchQuery = ''.obs;

  final scrollController = ScrollController();
  final nextUrl = Rxn<String>();
  final isLoadingMore = false.obs;

  @override
  void onInit() {
    super.onInit();

    fetchCharacters();

    debounce(
      searchQuery,
      (_) => fetchCharacters(query: searchQuery.value),
      time: const Duration(milliseconds: 500),
    );

    scrollController.addListener(() {
      // Se o usuário chegou no final da lista, carregamos mais
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        loadMoreCharacters();
      }
    });
  }

  Future<void> fetchCharacters({String? query}) async {
    isLoading.value = true;
    try {
      final response = await _repository.getCharacters(query: query);
      characters.assignAll(response.characters);
      nextUrl.value = response.nextPageUrl;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreCharacters() async {
    if (isLoadingMore.value || nextUrl.value == null) return;

    isLoadingMore.value = true;
    try {
      final response = await _repository.getCharacters(url: nextUrl.value);
      characters.addAll(response.characters);
      nextUrl.value = response.nextPageUrl;
    } finally {
      isLoadingMore.value = false;
    }
  }

  // Não se esqueça de limpar o scroll controller quando a tela for fechada
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void onSearchQueryChanged(String query) {
    searchQuery.value = query;
  }
}
