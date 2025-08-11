import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/result.dart';
import '../data/episode_model.dart';
import '../data/episode_service.dart';

final episodesControllerProvider =
    StateNotifierProvider<EpisodesController, AsyncValue<List<Episode>>>(
  (ref) => EpisodesController(ref),
);

class EpisodesController extends StateNotifier<AsyncValue<List<Episode>>> {
  EpisodesController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  final Ref ref;

  int _page = 1;
  int _totalPages = 1;
  bool _loadingMore = false;
  List<Episode> _items = [];
  String _name = '';
  String _code = '';

  Future<void> refresh({String name = '', String code = ''}) async {
    _name = name;
    _code = code;
    state = const AsyncValue.loading();
    _page = 1;
    _items = [];
    final res = await _loadPage(_page);
    res.when(
      ok: (d) => state = AsyncValue.data(d),
      err: (m) => state = AsyncValue.error(m, StackTrace.current),
    );
  }

  Future<void> loadMore() async {
    if (_loadingMore || _page >= _totalPages) return;
    _loadingMore = true;
    _page++;
    final res = await _loadPage(_page);
    res.when(
      ok: (d) => state = AsyncValue.data(d),
      err: (m) => state = AsyncValue.error(m, StackTrace.current),
    );
    _loadingMore = false;
  }

  Future<Result<List<Episode>>> _loadPage(int page) async {
    try {
      final service = ref.read(episodeServiceProvider);
      final resp = await service.fetchEpisodes(
        page: page,
        name: _name.isEmpty ? null : _name,
        episodeCode: _code.isEmpty ? null : _code,
      );
      _totalPages = resp.info.pages;
      _items = [..._items, ...resp.results];
      return Ok(_items);
    } catch (e) {
      return Err(e.toString());
    }
  }
}
