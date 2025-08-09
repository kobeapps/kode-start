import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/core/constants/ui_constants.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/theme/app_text_style.dart';
import 'package:rick_and_morty_app/features/character/data/controllers/character_controller.dart';
import 'package:rick_and_morty_app/features/character/presentation/pages/character_details_page.dart';

class CharacterCardWidget extends StatelessWidget {
  const CharacterCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CharacterController controller = Get.put(CharacterController());

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: UiConstants.cardPadding,
        vertical: UiConstants.defaultSpacing,
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.card),
          );
        } else {
          return ListView.builder(
            itemCount: controller.characters.length,
            itemBuilder: (context, index) {
              final character = controller.characters[index];
              return Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(UiConstants.defaulRadius),
                ),
                color: AppColors.card,
                child: InkWell(
                  onTap: () {
                    Get.to(() => CharacterDetailsPage(), arguments: character);
                  },
                  child: Stack(
                    children: [
                      Image.network(
                        character.image,
                        height: UiConstants.heightCardHomePage,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: AppColors.card,
                          padding: EdgeInsets.symmetric(
                            horizontal: UiConstants.defaultPadding,
                            vertical: 12,
                          ),
                          child: Text(
                            character.name.toUpperCase(),
                            style: AppTextStyle.characterName,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
