import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_morty_api/pages/home_page.dart';
import 'package:rick_morty_api/theme/app_images.dart';

import '../theme/app_colors.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  return AppBar(
    toolbarHeight: kToolbarHeight * 2.2,
    backgroundColor: AppColors.appBarColor,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    leading: Align(
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          if (currentRoute == HomePage.routeId) return;
          Navigator.pop(context);
        },
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
              'RICK AND MORTY API',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    ),
  );
}
