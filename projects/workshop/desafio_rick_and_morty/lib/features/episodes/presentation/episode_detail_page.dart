import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/error_retry.dart';
import '../../../widgets/loading.dart';
import '../data/episode_model.dart';
import '../data/episode_service.dart';

final episodeDetailProvider =
    FutureProvider.family<Episode, int>((ref, id) async {
  final s = ref.read(episodeServiceProvider);
  return s.fetchEpisode(id);
});

class EpisodeDetailPage extends ConsumerWidget {
  const EpisodeDetailPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(episodeDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Episode')),
      body: state.when(
        loading: () => const Center(child: Loading()),
        error: (e, _) => ErrorRetry(
            message: e.toString(),
            onRetry: () {
              ref.refresh(episodeDetailProvider(id));
            }),
        data: (e) => Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(e.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('${e.code} • ${e.airDate}'),
            const SizedBox(height: 16),
            Text('Characters in episode: ${e.characterUrls.length}'),
          ]),
        ),
      ),
    );
  }
}
