import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/result.dart';
import '../data/character_model.dart';
import '../data/character_service.dart';

class CharacterQuery {
  final String name;
  final String status;
  final String gender;

  const CharacterQuery({
    this.name = '',
    this.status = '',
    this.gender = '',
  });

  CharacterQuery copyWith({
    String? name,
    String? status,
    String? gender,
  }) {
    return CharacterQuery(
      name: name ?? this.name,
      status: status ?? this.status,
      gender: gender ?? this.gender,
    );
  }
}

final charactersControllerProvider =
    StateNotifierProvider<CharactersController, AsyncValue<List<Character>>>(
  (ref) => CharactersController(ref),
);

class CharactersController extends StateNotifier<AsyncValue<List<Character>>> {
  CharactersController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  final Ref ref;

  int _page = 1;
  int _totalPages = 1;
  bool _loadingMore = false;
  CharacterQuery _query = const CharacterQuery();
  List<Character> _items = [];

  Future<void> refresh([CharacterQuery? query]) async {
    if (query != null) _query = query;
    state = const AsyncValue.loading();
    _page = 1;
    _items = [];

    final res = await _loadPage(_page);
    res.when(
      ok: (data) => state = AsyncValue.data(data),
      err: (msg) => state = AsyncValue.error(msg, StackTrace.current),
    );
  }

  Future<void> loadMore() async {
    if (_loadingMore || _page >= _totalPages) return;
    _loadingMore = true;
    _page++;

    final res = await _loadPage(_page);
    res.when(
      ok: (data) => state = AsyncValue.data(data),
      err: (msg) => state = AsyncValue.error(msg, StackTrace.current),
    );

    _loadingMore = false;
  }

  Future<Result<List<Character>>> _loadPage(int page) async {
    try {
      final service = ref.read(characterServiceProvider);
      final resp = await service.fetchCharacters(
        page: page,
        name: _query.name.isEmpty ? null : _query.name,
        status: _query.status.isEmpty ? null : _query.status,
        gender: _query.gender.isEmpty ? null : _query.gender,
      );

      _totalPages = resp.info.pages;
      _items = [..._items, ...resp.results];

      return Ok(_items);
    } catch (e) {
      return Err(e.toString());
    }
  }

  void applyFilters(CharacterQuery q) => refresh(q);
}
