import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/widgets/app_bar_widget.dart';
import 'package:rick_and_morty_app/features/character/presentation/widgets/character_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(trailingIcon: Icons.menu),
      body: CharacterCardWidget(),
    );
  }
}
