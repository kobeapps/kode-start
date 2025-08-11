import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';
import 'package:rick_morty_thiago_arend/data/repository.dart';
import 'package:rick_morty_thiago_arend/models/character.dart';
import 'package:rick_morty_thiago_arend/models/episode.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';
import 'package:rick_morty_thiago_arend/theme/app_images.dart';
import 'package:rick_morty_thiago_arend/theme/app_strings.dart';

class CharacterDetailsScreen extends StatefulWidget {
  const CharacterDetailsScreen({super.key});

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  String resolveStatusText(CharacterStatus status) {
    return status.name[0].toUpperCase() + status.name.substring(1);
  }

  String resolveStatusIconName(CharacterStatus status) {
    switch (status) {
      case CharacterStatus.alive:
        return AppImages.aliveEllipsis;
      case CharacterStatus.dead:
        return AppImages.deadEllipsis;
      case CharacterStatus.unknown:
        return AppImages.unknownEllipsis;
    }
  }

  Future<Episode> resolveEpisodeName(Character character) async {
    return await Repository.getEpisodeByUrl(character.episode.first);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final character = ModalRoute.of(context)?.settings.arguments as Character;

    return Scaffold(
      appBar: appBarComponent(context),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20, 15, 20, 0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.primaryColorLight,
              ),
              width: screenWidth,
              height: 383,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: NetworkImage(character.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              width: screenWidth,
              height: 160,
            ),
            Positioned(
              top: 172,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name ?? '',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 38),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        resolveStatusIconName(character.status),
                        width: 8,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '${resolveStatusText(character.status)} - ${character.species}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppStrings.lastKnownLocation,
                    style: TextStyle(color: AppColors.white, fontSize: 12),
                  ),
                  Text(
                    character.location?.name ?? '',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppStrings.firstSeenIn,
                    style: TextStyle(color: AppColors.white, fontSize: 12),
                  ),
                  FutureBuilder(
                    future: resolveEpisodeName(character),
                    builder: (context, AsyncSnapshot<Episode> snapshot) {
                      if (snapshot.hasData) {
                        final episodeName = snapshot.data!.name;
                        return Text(
                          episodeName ?? '',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            AppStrings.apiFetchErrorMessage,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
    );
  }
}
