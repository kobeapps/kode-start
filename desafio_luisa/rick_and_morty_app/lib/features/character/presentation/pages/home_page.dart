import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/widgets/app_bar_widget.dart';
import 'package:rick_and_morty_app/features/character/data/controllers/character_controller.dart';
import 'package:rick_and_morty_app/features/character/presentation/widgets/character_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CharacterController controller = Get.put(CharacterController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(trailingIcon: Icons.menu, trailingFunction: () {}),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: controller.onSearchQueryChanged,
              decoration: InputDecoration(
                hintText: 'Buscar por nome...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: AppColors.card,
              ),
            ),
          ),
          Expanded(child: CharacterCardWidget()),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
