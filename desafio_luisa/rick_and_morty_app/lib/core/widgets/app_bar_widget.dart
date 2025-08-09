import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/core/constants/ui_constants.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';
import 'package:rick_and_morty_app/core/theme/app_images.dart';
import 'package:rick_and_morty_app/core/theme/app_text_style.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.trailingIcon,
    required this.trailingFunction,
  });

  final IconData trailingIcon;
  final VoidCallback trailingFunction;

  @override
  Size get preferredSize => Size.fromHeight(131);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(UiConstants.defaultPadding),
      color: AppColors.appBar,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: trailingFunction,
              child: Icon(
                trailingIcon,
                color: AppColors.icon,
                size: UiConstants.iconSize,
              ),
            ),
            Column(
              children: [
                Image.asset(AppImages.icon, width: 115, height: 77),
                // SizedBox(height: 6),
                Text('RICK AND MORTY API', style: AppTextStyle.appBarTitle),
              ],
            ),
            Icon(
              Icons.account_circle,
              color: AppColors.icon,
              size: UiConstants.iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
