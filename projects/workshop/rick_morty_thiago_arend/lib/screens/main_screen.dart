import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';
import 'package:rick_morty_thiago_arend/components/preview_card_component.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final List<PreviewCardComponent> cards = [
      PreviewCardComponent(),
      PreviewCardComponent(),
      PreviewCardComponent(),
      PreviewCardComponent(),
      PreviewCardComponent(),
      PreviewCardComponent(),
      PreviewCardComponent(),
      PreviewCardComponent(),
    ];

    return Scaffold(
      appBar: appBarComponent(context),
      body: ListView.builder(
        itemCount: cards.length,
        itemBuilder: (ctx, index) => cards[index],
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
