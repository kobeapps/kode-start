import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rick_and_morty_app/core/core.dart';
import 'package:rick_and_morty_app/features/character/data/data.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Alive':
        return AppColors.circleAlive;
      case 'Dead':
        return AppColors.circleDead;
      default:
        return AppColors.circleUnknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    final CharacterModel character = Get.arguments;
    final EpisodeController controller = Get.put(
      EpisodeController(character: character),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(
        trailingIcon: Icons.arrow_back,
        trailingFunction: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 380,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(UiConstants.defaulRadius),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    character.image,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: UiConstants.defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name.toUpperCase(),
                        style: AppTextStyle.characterName,
                      ),
                      SizedBox(height: 38),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: _getStatusColor(character.status),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            width: 8,
                            height: 8,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${character.status[0].toUpperCase()}${character.status.substring(1)} - ${character.species} - ${character.gender}',
                            style: AppTextStyle.characterInfo,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text('Last know location:', style: AppTextStyle.textCard),
                      Text(
                        character.location.name,
                        style: AppTextStyle.characterInfo,
                      ),
                      SizedBox(height: 15),
                      Text('First seen in:', style: AppTextStyle.textCard),
                      Obx(() {
                        final episode = controller.episode.value;
                        if (controller.isLoading.value) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.card,
                            ),
                          );
                        }
                        if (episode != null) {
                          return Text(
                            episode.name,
                            style: AppTextStyle.characterInfo,
                          );
                        }
                        return Text(
                          'Dados do episódio indisponíveis.',
                          style: AppTextStyle.characterInfo,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
