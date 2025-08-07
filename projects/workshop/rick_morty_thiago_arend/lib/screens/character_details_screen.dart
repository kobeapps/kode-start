import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(context),
      body: Center(
        child: Text('Teste', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
