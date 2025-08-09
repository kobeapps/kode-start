import 'package:rick_and_morty_app/features/character/data/datasources/datasources.dart';
import 'package:rick_and_morty_app/features/character/data/models/models.dart';

abstract class CharacterRepository {
  Future<List<CharacterModel>> getCharacters();
  Future<EpisodesModel> getEpisode(String url);
}

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterDatasource datasource;

  CharacterRepositoryImpl({required this.datasource});

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final characterModels = await datasource.getCharacterFromApi();

      return characterModels;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<EpisodesModel> getEpisode(String url) async {
    try {
      final episode = await datasource.getEpisodeByUrl(url);

      return episode;
    } catch (e) {
      throw Exception(e);
    }
  }
}
