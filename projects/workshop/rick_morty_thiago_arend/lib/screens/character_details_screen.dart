import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/components/app_bar_component.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';
import 'package:rick_morty_thiago_arend/theme/app_images.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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
                  image: AssetImage('assets/img.jpg'),
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
                    'BABY WIZARD',
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
                      Image.asset(AppImages.aliveEllipsis, width: 8),
                      SizedBox(width: 6),
                      Text(
                        'Dead - Alien',
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
                    'Last know location:',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Earth (Replacement Dimension)',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'First seen in:',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'Total Rickall',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                    ),
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
