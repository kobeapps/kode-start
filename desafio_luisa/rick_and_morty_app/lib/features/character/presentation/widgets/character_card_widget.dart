import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/core/core.dart';
import 'package:rick_and_morty_app/features/character/data/data.dart';
import 'package:rick_and_morty_app/features/character/presentation/presentation.dart';

class CharacterCardWidget extends GetView<CharacterController> {
  const CharacterCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: UiConstants.cardPadding,
        vertical: UiConstants.defaultSpacing,
      ),
      child: Obx(() {
        if (controller.isLoading.value && controller.characters.isEmpty) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.card),
          );
        }
        return ListView.builder(
          controller: controller.scrollController,
          itemCount:
              controller.characters.length +
              (controller.isLoadingMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == controller.characters.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(color: AppColors.card),
                ),
              );
            }

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
      }),
    );
  }
}
