import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/models/character.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';

class PreviewCardComponent extends StatelessWidget {
  const PreviewCardComponent({
    required this.character,
    required this.onTap,
    super.key,
  });

  final Character character;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 15),
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
                  image: NetworkImage(character.image ?? ''),
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
                character.id.toString(),
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
