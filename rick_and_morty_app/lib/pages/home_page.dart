import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../design/tokens.dart';
import '../providers/character_list_provider.dart';
import '../widgets/character_card.dart';
import 'insights_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterListProvider);
    final notifier = ref.read(characterListProvider.notifier);
    final api = ref.read(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
        backgroundColor: Tokens.bgDark,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Ranking & Curiosidades',
            icon: const Icon(Icons.leaderboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InsightsPage()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: notifier.search,
              style: const TextStyle(color: Tokens.textPrimary),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(255, 255, 255, 0.08),
                hintText: 'Buscar por nome',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Tokens.radius),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
            notifier.loadMore();
          }
          return false;
        },
        child: state.isLoading && state.items.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: state.items.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.items.length) {
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (state.nextPageUrl == null) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text('Fim da lista',
                              style: TextStyle(color: Colors.white70)),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                  final c = state.items[index];
                  return CharacterCard(character: c, api: api);
                },
              ),
      ),
    );
  }
}
