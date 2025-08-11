import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import '../widgets/character_card.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Character> characters = [];
  List<Character> filteredCharacters = [];
  bool loading = true;
  String? error;

  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCharacters();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredCharacters = characters
          .where((c) => c.name.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> loadCharacters() async {
    try {
      final list = await ApiService.fetchCharacters();
      setState(() {
        characters = list;
        filteredCharacters = list;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100, // altura aumentada
        leading: const Icon(Icons.menu, color: Colors.white),
        title: !isSearching
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 55,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'RICK AND MORTY API',
                    style: TextStyle(letterSpacing: 1.2, color: Colors.white),
                  ),
                ],
              )
            : TextField(
                controller: searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Buscar personagem...',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
                cursorColor: Colors.white,
              ),
        centerTitle: true,
        actions: [
          if (!isSearching)
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                setState(() {
                  isSearching = false;
                  searchController.clear();
                  filteredCharacters = characters;
                });
              },
            ),
          const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.account_circle_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (loading) return const Center(child: CircularProgressIndicator());
          if (error != null) return Center(child: Text('Error: $error'));
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: filteredCharacters.length,
            itemBuilder: (context, index) {
              final c = filteredCharacters[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(character: c),
                    ),
                  );
                },
                child: CharacterCard(character: c),
              );
            },
          );
        },
      ),
    );
  }
}
