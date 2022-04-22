import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_colors.dart';

PreferredSizeWidget appBarComponent(BuildContext context, {bool isSecondPage = false}) {
  return AppBar(
    toolbarHeight: 135,
    backgroundColor: AppColors.appBarColor,
    brightness: Brightness.dark,
    //After
    leading: Container(),
    //After 2 Page
    flexibleSpace: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          right: 15,
          left: 15,
          top: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                isSecondPage ? Icons.arrow_back : Icons.person,
                color: AppColors.white,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Image.asset("assets/logo.png"),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "TMDB MOVIES API",
                      style: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.menu,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    ),
  );
}
