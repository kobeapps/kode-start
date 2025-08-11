import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../widgets/error_retry.dart';
import '../../../widgets/loading.dart';
import '../data/location_model.dart';
import '../data/location_service.dart';

final locationDetailProvider =
    FutureProvider.family<LocationRM, int>((ref, id) async {
  final s = ref.read(locationServiceProvider);
  return s.fetchLocation(id);
});

class LocationDetailPage extends ConsumerWidget {
  const LocationDetailPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(locationDetailProvider(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: state.when(
        loading: () => const Center(child: Loading()),
        error: (e, _) => ErrorRetry(
            message: e.toString(),
            onRetry: () {
              ref.refresh(locationDetailProvider(id));
            }),
        data: (l) => Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(l.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('${l.type} • ${l.dimension}'),
            const SizedBox(height: 16),
            Text('Residents: ${l.residentUrls.length}'),
          ]),
        ),
      ),
    );
  }
}
