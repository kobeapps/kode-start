import 'package:flutter/material.dart';
import '../repositories/rick_and_morty_repository.dart';
import '../data/result.dart';
import 'character_detail_page.dart';
import '../services/favorites_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CharactersListView extends StatefulWidget {
  const CharactersListView({super.key});

  @override
  State<CharactersListView> createState() => _CharactersListViewState();
}

class _CharactersListViewState extends State<CharactersListView> {
  static const double kFieldWidth = 320;
  static const double kFieldHeight = 44;
  static const double kPlaceholderFontSize = 14;

  final _repo = RickAndMortyRepository();
  final _controller = TextEditingController();

  late Future<List<Result>> _future;
  String _query = '';
  bool _onlyFav = false;

  @override
  void initState() {
    super.initState();
    _future = _repo.fetchCharactersPage(page: 1);
    FavoritesService.I.init(); 

  }

  void _runSearch([String? text]) {
    final q = (text ?? _controller.text).trim();
    setState(() {
      _query = q;
      _future = _repo.fetchCharactersPage(
        page: 1,
        name: q.isEmpty ? null : q,
      );
    });
  }

  void _clear() {
    _controller.clear();
    _runSearch('');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xFF1D1F23);
    const chipBg = Color(0xFF2B2E34);

    return Container(
      color: dark,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: kFieldWidth,
                height: kFieldHeight,
                child: TextField(
                  controller: _controller,
                  onSubmitted: _runSearch,
                  textInputAction: TextInputAction.search,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Pesquisar por nome...',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.white70,
                      fontSize: kPlaceholderFontSize,
                    ),
                    filled: true,
                    fillColor: chipBg,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    suffixIconConstraints:
                        const BoxConstraints(minWidth: 18, maxHeight: 30),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: _IconChip(
                        icon: (_query.isNotEmpty || _controller.text.isNotEmpty)
                            ? Icons.clear
                            : Icons.search,
                        onTap:
                            (_query.isNotEmpty || _controller.text.isNotEmpty)
                                ? _clear
                                : () => _runSearch(),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: kFieldWidth,
                height: kFieldHeight,
                child: Material(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => setState(() => _onlyFav = !_onlyFav),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'Buscar somente favoritos',
                              style: GoogleFonts.lato(
                                color: Colors.white70,
                                fontSize: kPlaceholderFontSize,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: _IconChip(
                              icon: _onlyFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              iconColor: _onlyFav
                                  ? Colors.redAccent
                                  : Colors.white, 
                              height: 32,
                              onTap: () => setState(() => _onlyFav = !_onlyFav),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Result>>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        'Erro: ${snapshot.error}',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                final all = snapshot.data ?? [];
                final items = _onlyFav
                    ? all.where((c) => FavoritesService.I.isFav(c.id)).toList()
                    : all;

                if (items.isEmpty) {
                  return Center(
                    child: Text(
                      _onlyFav
                          ? 'Nenhum favorito nesta lista.'
                          : (_query.isEmpty
                              ? 'Nenhum personagem encontrado.'
                              : 'Nada encontrado para "${_query}".'),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  );
                }

                return ValueListenableBuilder<Set<int>>(
                  valueListenable: FavoritesService.I.favorites,
                  builder: (context, favs, _) {
                    final filtered = _onlyFav
                        ? items.where((c) => favs.contains(c.id)).toList()
                        : items;

                    return ListView.builder(
                      padding: const EdgeInsets.only(bottom: 16),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final c = filtered[index];

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                          child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: kFieldWidth, 
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CharacterDetailPage(character: c),
                                    ),
                                  );
                                },
                                child: _CharacterTile(
                                  id: c.id,
                                  name: c.name,
                                  imageUrl: c.image,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;
  final double width;
  final double height;

  const _IconChip({
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.width = 36,   
    this.height = 36,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: width,
          height: height,                 
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}



class _CharacterTile extends StatelessWidget {
  final int id;
  final String name;
  final String imageUrl;

  const _CharacterTile({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5C75F6);
    const tileBg = Color(0xFF2B2E34);

    return Container(
      decoration: BoxDecoration(
        color: tileBg,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Center(
                      child: Icon(Icons.image_not_supported,
                          color: Colors.white70),
                    ),
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: ValueListenableBuilder<Set<int>>(
                    valueListenable: FavoritesService.I.favorites,
                    builder: (context, favs, _) {
                      final isFav = favs.contains(id);
                      return Material(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => FavoritesService.I.toggle(id),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.redAccent : Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              name.toUpperCase(),
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16, 
                fontWeight: FontWeight.w700,
                height: 1.15, 
                letterSpacing: 0.4,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
