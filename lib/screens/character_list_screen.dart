import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter_app/services/api_service.dart';
import 'package:rick_and_morty_flutter_app/widgets/character_card.dart';
import 'package:rick_and_morty_flutter_app/widgets/custom_app_bar.dart';
import '../models/character.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({Key? key}) : super(key: key);

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<Character>> characters;

  @override
  void initState() {
    super.initState();
    characters = ApiService().fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18181A),
      appBar: CustomAppBar(),
      body: FutureBuilder<List<Character>>(
        future: characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado'));
          }
          final chars = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 24),
            itemCount: chars.length,
            itemBuilder: (context, index) {
              final character = chars[index];
              return CharacterCard(character: character);
            },
          );
        },
      ),
    );
  }
}
