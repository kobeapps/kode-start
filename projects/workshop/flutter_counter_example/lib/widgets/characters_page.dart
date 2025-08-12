import 'package:flutter/material.dart';
import '../repositories/rick_and_morty_repository.dart';
import '../data/result.dart';

class CharactersPage extends StatelessWidget {
  CharactersPage({super.key});

  final _repo = RickAndMortyRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: FutureBuilder<List<Result>>(
        future: _repo.fetchCharactersPage(page: 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }
  
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado'));
          }
        
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final c = items[index];
              return ListTile(
                title: Text(c.name),
                subtitle: Text('${c.status} • ${c.species}'),
              );
            },
          );
        },
      ),
    );
  }
}
