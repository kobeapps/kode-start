import 'package:flutter/material.dart';
import 'package:kobeproj/char_model.dart';
import 'package:kobeproj/home.dart';
import 'package:kobeproj/widgets/custom_app_bar.dart';

class CharPage extends StatelessWidget {
 final CharModel character;

  const CharPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildCustomAppBar(context),
      body: Center(
        child: CharCard(
          character: character,
          isInitiallyExpanded: true,
        ),
      ),
    );
  }
}
