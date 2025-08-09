import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/app_routes.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';

class PreviewCardComponent extends StatelessWidget {
  const PreviewCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed(AppRoutes.characterDetailsScreen),
      child: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(20, 15, 20, 0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.primaryColorLight,
              ),
              width: screenWidth,
              height: 160,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/img.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              width: screenWidth,
              height: 120,
            ),
            Positioned(
              bottom: 10,
              left: 16,
              child: Text(
                'BABY WIZARD',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
