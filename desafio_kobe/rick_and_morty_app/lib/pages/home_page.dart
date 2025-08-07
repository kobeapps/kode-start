import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/components/character_card.dart';
import 'package:rick_and_morty_app/models/paginated_characters.dart';
import 'package:rick_and_morty_app/data/repository.dart';
import 'package:rick_and_morty_app/pages/details_page.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/components/app_bar_component.dart';
import 'package:rick_and_morty_app/components/filter_drawer.dart';

class HomePage extends StatefulWidget {
  static const routeId = '/';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<PaginatedCharacters>? characters;
  String? _selectedStatusFilter;
  String? _selectedSpeciesFilter;
  String? _selectedGenderFilter;

  @override
  initState() {
    _fetchCharacters();
    super.initState();
  }

  void _fetchCharacters() {
    setState(() {
      characters = Repository.getCharacters(
        status: _selectedStatusFilter,
        species: _selectedSpeciesFilter,
        gender: _selectedGenderFilter,
      );
    });
  }

  void _applyFilter(String? status, String? species, String? gender) {
    setState(() {
      _selectedStatusFilter = status;
      _selectedSpeciesFilter = species;
      _selectedGenderFilter = gender;
    });
    _fetchCharacters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      backgroundColor: AppColors.backgroundColor,
      drawer: FilterDrawer(
        initialStatusFilter: _selectedStatusFilter,
        initialSpeciesFilter: _selectedSpeciesFilter,
        initialGenderFilter: _selectedGenderFilter,
        onFiltersApplied: _applyFilter,
      ),
      body: FutureBuilder(
        future: characters,
        builder: (context, AsyncSnapshot<PaginatedCharacters> snapshot) {
          if (snapshot.hasData) {
            final dataResults = snapshot.data!.results;
            return ListView.builder(
              itemBuilder: (context, index) {
                return CharacterCard(
                  character: dataResults[index],
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      DetailsPage.routeId,
                      arguments: dataResults[index].id,
                    );
                  },
                );
              },
              itemCount: dataResults.length,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Ocorreu um erro.",
                style: TextStyle(color: AppColors.white),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
