import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/app_routes.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';
import 'package:rick_morty_thiago_arend/components/preview_card_component.dart';
import 'package:rick_morty_thiago_arend/data/repository.dart';
import 'package:rick_morty_thiago_arend/models/character.dart';
import 'package:rick_morty_thiago_arend/models/paginated_characters.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';
import 'package:rick_morty_thiago_arend/theme/app_strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Character> _allCharacters = [];
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMorePages = true;
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _loadCharacters(_currentPage);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        if (!_isLoadingMore && _hasMorePages) {
          _loadMore();
        }
      }
    });
  }

  Future<void> _loadCharacters(int page) async {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    try {
      PaginatedCharacters newData;

      if (_searchText.isEmpty) {
        newData = await Repository.getCharactersByPage(page);
      } else {
        newData = await Repository.getCharactersByNameAndPage(_searchText, page);
      }

      setState(() {
        _allCharacters.addAll(newData.results);
        _isLoadingMore = false;
        _hasMorePages = newData.info?.next != null;
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _loadMore() {
    _currentPage++;
    _loadCharacters(_currentPage);
  }

  Future<void> _updateCharacters(String text) async {
    _allCharacters.clear();
    _currentPage = 1;
    _searchText = text;
    _hasMorePages = true;
    await _loadCharacters(_currentPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: [
            SearchBar(
              trailing: [const Icon(Icons.search)],
              onChanged: (String text) {
                _updateCharacters(text);
              },
              hintText: AppStrings.searchBarPlaceholder,
            ),
            Expanded(
              child: _allCharacters.isEmpty && !_isLoadingMore
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          _allCharacters.length + (_isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _allCharacters.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        return PreviewCardComponent(
                          character: _allCharacters[index],
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.characterDetailsScreen,
                            arguments: _allCharacters[index],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
