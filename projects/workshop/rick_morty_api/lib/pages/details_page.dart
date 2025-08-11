import 'package:flutter/material.dart';
import 'package:rick_morty_api/components/app_bar_component.dart';
import 'package:rick_morty_api/components/detailed_character_card.dart';
import 'package:rick_morty_api/data/repository.dart';
import 'package:rick_morty_api/models/detailed_character.dart';
import 'package:rick_morty_api/theme/app_colors.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({required this.movieId, super.key});

  final int movieId;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<DetailedCharacter>? detaliedCharacter;

  @override
  initState() {
    detaliedCharacter = Repository.getCharacterDetails(widget.movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: detaliedCharacter,
        builder: (context, AsyncSnapshot<DetailedCharacter> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(children: [DetailedCharacterCard(detailedCharacter: data)]);
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
