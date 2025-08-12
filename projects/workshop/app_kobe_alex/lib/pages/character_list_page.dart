

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:app_kobe_alex/data/character_repository.dart';
import 'package:app_kobe_alex/models/character_model.dart';
import 'package:app_kobe_alex/pages/character_detail_page.dart';
import 'package:app_kobe_alex/widgets/character_card.dart';
import 'package:app_kobe_alex/widgets/main_layout.dart';


class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();

}
class _CharacterListPageState extends State<CharacterListPage> {
  final CharacterRepository _repository = CharacterRepository();
  final TextEditingController _searchController = TextEditingController();


// Variaveis para gerenciar o estado da UI
  bool _isLoading = true;
  List<CharacterModel> _characters = [];
  String? _errorMessage;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    //Inicializa a lista de personagens
    _fetchCharacters();
  }

  @override
  void dispose() {
    // Cancela o timer e libera o controller para evitar memory leaks
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCharacters({String? query}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      
      final result = await _repository.getCharacters(query: query);
      setState(() {
        _characters = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
     
    }
  }

 // Função de debounce para a busca
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchCharacters(query: query);
    });
  }

  // Constrói o corpo da página com base no estado atual
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.cyanAccent));
    }
    if (_errorMessage != null) {
      return Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)));
    }
    if (_characters.isEmpty) {
      return const Center(child: Text('Nenhum personagem encontrado.'));
    }
    return ListView.builder(
      itemCount: _characters.length,
      itemBuilder: (context, index) {
        final character = _characters[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CharacterDetailPage(character: character)),
            );
          },
          child: CharacterCard(
            name: character.name,
            imageUrl: character.image,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      // Passa o campo de busca para a AppBar
      appBarBottom: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Buscar por nome...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }
}


  