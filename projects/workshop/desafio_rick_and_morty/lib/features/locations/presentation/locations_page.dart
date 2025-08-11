import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/error_retry.dart';
import '../../../widgets/loading.dart';
import 'locations_controller.dart';

class LocationsPage extends ConsumerStatefulWidget {
  const LocationsPage({super.key});
  @override
  ConsumerState<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends ConsumerState<LocationsPage> {
  final _scroll = ScrollController();
  final _nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 200) {
        ref.read(locationsControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _apply() {
    ref
        .read(locationsControllerProvider.notifier)
        .refresh(name: _nameCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(locationsControllerProvider);

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _nameCtrl,
              onSubmitted: (_) => _apply(),
              decoration: InputDecoration(
                hintText: 'Filter by name',
                prefixIcon: null,
                suffixIcon: IconButton(
                  onPressed: _apply,
                  icon: const Icon(Icons.search, color: Colors.white70),
                  tooltip: 'Search',
                ),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: state.when(
              loading: () => const Center(child: Loading()),
              error: (e, _) => ErrorRetry(
                message: e.toString(),
                onRetry: () {
                  ref.read(locationsControllerProvider.notifier).refresh();
                },
              ),
              data: (items) => RefreshIndicator(
                onRefresh: () =>
                    ref.read(locationsControllerProvider.notifier).refresh(),
                child: ListView.separated(
                  controller: _scroll,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, i) => ListTile(
                    title: Text(items[i].name),
                    subtitle: Text('${items[i].type} • ${items[i].dimension}'),
                    onTap: () =>
                        context.push('/locations/detail/${items[i].id}'),
                  ),
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemCount: items.length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
