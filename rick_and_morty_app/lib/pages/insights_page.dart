import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../design/tokens.dart';
import '../models/character_model.dart';
import '../providers/character_list_provider.dart';

class InsightsPage extends ConsumerStatefulWidget {
  const InsightsPage({super.key});
  @override
  ConsumerState<InsightsPage> createState() => _InsightsPageState();
}

class _InsightsPageState extends ConsumerState<InsightsPage> {
  late final Future<_InsightsData> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<_InsightsData> _load() async {
    final repo = ref.read(characterRepositoryProvider);
    final all = <Character>[];

    String? next;
    do {
      final page = await repo.list(pageUrl: next);
      all.addAll(page.results);
      next = page.nextPageUrl;
    } while (next != null);

    final ranked = [...all]
      ..sort((a, b) => b.episodeUrls.length.compareTo(a.episodeUrls.length));
    final top10 = ranked.take(10).toList();

    final total = all.length;
    final mediaAparicoes = total == 0
        ? 0.0
        : all.map((c) => c.episodeUrls.length).reduce((a, b) => a + b) / total;

    final especie = <String, int>{};
    final status = <String, int>{};
    final origem = <String, int>{};

    for (final c in all) {
      especie[c.species] = (especie[c.species] ?? 0) + 1;
      status[c.status] = (status[c.status] ?? 0) + 1;
      origem[c.originName] = (origem[c.originName] ?? 0) + 1;
    }

    final topEspecies = (especie.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)))
        .take(5)
        .toList();

    final distStatus = (status.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)))
        .toList();

    final topOrigens = (origem.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value)))
        .take(5)
        .toList();

    return _InsightsData(
      top10: top10,
      mediaAparicoes: mediaAparicoes,
      topEspecies: topEspecies,
      distStatus: distStatus,
      topOrigens: topOrigens,
      total: total,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ranking & Curiosidades')),
      body: FutureBuilder<_InsightsData>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(
              child: Text('Erro: ${snap.error}',
                  style: const TextStyle(color: Colors.white)),
            );
          }
          final data = snap.data!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _sectionTitle('Top 10 — Aparições'),
              ...data.top10.map(_rankTile),
              const SizedBox(height: 16),
              _sectionTitle('Curiosidades'),
              _fact('Total de personagens', '${data.total}'),
              _fact(
                  'Média de aparições', data.mediaAparicoes.toStringAsFixed(2)),
              _subTitle('Top espécies'),
              _chips(data.topEspecies
                  .map((e) => '${e.key} (${e.value})')
                  .toList()),
              _subTitle('Distribuição de status'),
              _chips(
                  data.distStatus.map((e) => '${e.key} (${e.value})').toList()),
              _subTitle('Top origens'),
              _chips(
                  data.topOrigens.map((e) => '${e.key} (${e.value})').toList()),
            ],
          );
        },
      ),
    );
  }

  // ---- UI helpers
  Widget _rankTile(Character c) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Tokens.cardBlue,
          borderRadius: BorderRadius.circular(Tokens.radius),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(c.image,
                  width: 56, height: 56, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                c.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Tokens.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            _pill('${c.episodeUrls.length} eps'),
          ],
        ),
      );

  Widget _pill(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.18),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(text, style: const TextStyle(color: Tokens.textSecondary)),
      );

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          text,
          style: const TextStyle(
            color: Tokens.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
      );

  Widget _subTitle(String text) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            color: Tokens.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

  Widget _fact(String label, String value) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Tokens.cardBlue,
          borderRadius: BorderRadius.circular(Tokens.radius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label,
                  style: const TextStyle(
                      color: Tokens.textSecondary,
                      fontWeight: FontWeight.w700)),
            ),
            Text(value, style: const TextStyle(color: Tokens.textSecondary)),
          ],
        ),
      );

  Widget _chips(List<String> items) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: items
            .map(
              (t) => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.18),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(t,
                    style: const TextStyle(color: Tokens.textSecondary)),
              ),
            )
            .toList(),
      );
}

class _InsightsData {
  final List<Character> top10;
  final double mediaAparicoes;
  final List<MapEntry<String, int>> topEspecies;
  final List<MapEntry<String, int>> distStatus;
  final List<MapEntry<String, int>> topOrigens;
  final int total;
  _InsightsData({
    required this.top10,
    required this.mediaAparicoes,
    required this.topEspecies,
    required this.distStatus,
    required this.topOrigens,
    required this.total,
  });
}
