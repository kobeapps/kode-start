import 'package:flutter/material.dart';
import 'package:rick_morty_thiago_arend/theme/app_colors.dart';
import 'package:rick_morty_thiago_arend/theme/app_images.dart';
import 'package:rick_morty_thiago_arend/theme/app_strings.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight * 2.4,
    backgroundColor: AppColors.appBarColor,
    leading: Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {},
        child: Icon(
          isSecondPage ? Icons.arrow_back : Icons.menu,
          color: AppColors.white,
        ),
      ),
    ),
    actions: [
      Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(right: 16),
        child: Icon(Icons.person, color: AppColors.white),
      ),
    ],
    flexibleSpace: SafeArea(
      child: Column(
        children: [
          Image.asset(AppImages.logo),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              AppStrings.appBarTitle,
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
