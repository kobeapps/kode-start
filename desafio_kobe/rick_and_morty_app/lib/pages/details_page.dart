import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/components/detailed_character_card.dart';
import 'package:rick_and_morty_app/models/character_details.dart';
import 'package:rick_and_morty_app/data/repository.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/components/app_bar_component.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';
  const DetailsPage({required this.characterId, Key? key}) : super(key: key);

  final int characterId;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Future<CharacterDetails>? characterDetails;

  @override
  initState() {
    characterDetails = Repository.getCharacterDetails(widget.characterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context, isSecondPage: true),
      backgroundColor: AppColors.backgroundColor,
      body: FutureBuilder(
        future: characterDetails,
        builder: (context, AsyncSnapshot<CharacterDetails> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView(
              children: [DetailedCharacterCard(characterDetails: data)],
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
