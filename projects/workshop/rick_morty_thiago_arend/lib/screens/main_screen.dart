import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/app_routes.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';
import 'package:rick_morty_thiago_arend/components/preview_card_component.dart';
import 'package:rick_morty_thiago_arend/data/repository.dart';
import 'package:rick_morty_thiago_arend/models/paginated_characters.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';
import 'package:rick_morty_thiago_arend/theme/app_strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<PaginatedCharacters>? _characters;

  @override
  initState() {
    _characters = Repository.getCharactersByPage(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20, 15, 20, 0),
        child: Column(
          children: [
            SearchBar(
              trailing: [Icon(Icons.search)],
              onChanged: (String text) {
                updateCharacters(text);
              },
            ),
            Expanded(
              child: FutureBuilder(
                future: _characters,
                builder:
                    (context, AsyncSnapshot<PaginatedCharacters> snapshot) {
                      if (snapshot.hasData) {
                        final dataResults = snapshot.data!.results;

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return PreviewCardComponent(
                              character: dataResults[index],
                              onTap: () => Navigator.of(context).pushNamed(
                                AppRoutes.characterDetailsScreen,
                                arguments: dataResults[index],
                              ),
                            );
                          },
                          itemCount: dataResults.length,
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            AppStrings.apiFetchErrorMessage,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }

  Future<void> updateCharacters(String text) async {
    setState(() {
      _characters = Repository.getCharactersByName(text);
    });
  }
}
