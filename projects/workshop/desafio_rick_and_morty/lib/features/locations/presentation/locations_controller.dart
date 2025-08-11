import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/result.dart';
import '../data/location_model.dart';
import '../data/location_service.dart';

final locationsControllerProvider =
    StateNotifierProvider<LocationsController, AsyncValue<List<LocationRM>>>(
  (ref) => LocationsController(ref),
);

class LocationsController extends StateNotifier<AsyncValue<List<LocationRM>>> {
  LocationsController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  final Ref ref;

  int _page = 1;
  int _totalPages = 1;
  bool _loadingMore = false;
  List<LocationRM> _items = [];
  String _name = '';

  Future<void> refresh({String name = ''}) async {
    _name = name;
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

  Future<Result<List<LocationRM>>> _loadPage(int page) async {
    try {
      final service = ref.read(locationServiceProvider);
      final resp = await service.fetchLocations(
        page: page,
        name: _name.isEmpty ? null : _name,
      );
      _totalPages = resp.info.pages;
      _items = [..._items, ...resp.results];
      return Ok(_items);
    } catch (e) {
      return Err(e.toString());
    }
  }
}
