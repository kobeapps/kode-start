import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/character_model.dart';
import '../widgets/character_card.dart'; // CharacterExpandableCard
import 'character_detail_page.dart';
import '../main.dart'; // AppColors

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,

      // Cabeçalho com logo + título 
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: Container(
          color: AppColors.black,
          padding: const EdgeInsets.only(top: 30, left: 16, right: 16, bottom: 12),
          child: Row(
            children: [
              Image.asset('assets/images/kode_start_branco.png', height: 34),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'RICK AND MORTY API',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.6,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined, color: Colors.white),
                splashRadius: 20,
              ),
            ],
          ),
        ),
      ),

      body: FutureBuilder<List<Character>>(
        future: ApiService.fetchCharacters(),
        builder: (context, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (s.hasError) {
            return Center(
              child: Text('Erro ao carregar: ${s.error}',
                  style: const TextStyle(color: Colors.white)),
            );
          }

          final data = s.data ?? [];
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            itemCount: data.length,
            itemBuilder: (_, i) {
              final c = data[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: CharacterExpandableCard(
                  character: c,
                  onOpenDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CharacterDetailPage(character: c),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}