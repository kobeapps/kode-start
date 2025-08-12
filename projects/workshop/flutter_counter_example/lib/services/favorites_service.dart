import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  FavoritesService._();
  static final FavoritesService I = FavoritesService._();

  static const _key = 'favorite_ids';
  final ValueNotifier<Set<int>> favorites = ValueNotifier<Set<int>>({});
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key)?.map(int.parse).toSet() ?? {};
    favorites.value = ids;
    _initialized = true;
  }

  bool isFav(int id) => favorites.value.contains(id);

  Future<void> toggle(int id) async {
    final set = Set<int>.from(favorites.value);
    if (!set.add(id)) set.remove(id);
    favorites.value = set;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, set.map((e) => e.toString()).toList());
  }
}
