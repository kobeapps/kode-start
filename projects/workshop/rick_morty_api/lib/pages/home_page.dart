import 'package:flutter/material.dart';
import 'package:rick_morty_api/components/app_bar_widget.dart';
import 'package:rick_morty_api/components/character_card.dart';
import 'package:rick_morty_api/data/repository.dart';
import 'package:rick_morty_api/models/character_list.dart';
import 'package:rick_morty_api/pages/details_page.dart';
import 'package:rick_morty_api/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Result> _characters = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isSearching = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _fetchCharacters();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchCharacters() async {
    if (_isLoading || !_hasMore) return;

    setState(() => _isLoading = true);

    try {
      final characterList = await Repository.getCharactersPage(_currentPage);
      setState(() {
        _currentPage++;
        _characters.addAll(characterList.results);
        _hasMore = characterList.info.next != null;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!_isSearching) {
        _fetchCharacters();
      }
    }
  }

  void _updateCharacters(List<dynamic> filteredCharactersDynamic) {
    final filteredCharacters = filteredCharactersDynamic.cast<Result>();
    setState(() {
      _characters = filteredCharacters;
      _isSearching = true;
      _hasMore = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _characters = [];
      _currentPage = 1;
      _hasMore = true;
      _isSearching = false;
    });
    _fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBarWidgets(
        isSecondPage: false,
        onResultsChanged: _updateCharacters,
      ),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        thickness: 6.0,
        radius: const Radius.circular(3),
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          itemCount: _characters.length + (_hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _characters.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final character = _characters[index];
            return CharacterCard(
              character: character,
              onTap: () {
                Navigator.of(context).pushNamed(
                  DetailsPage.routeId,
                  arguments: character.id,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: _isSearching
          ? FloatingActionButton(
              onPressed: _clearSearch,
              tooltip: 'Clear Search',
              child: const Icon(Icons.clear),
            )
          : null,
    );
  }
}
