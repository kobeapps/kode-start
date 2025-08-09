import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

PreferredSizeWidget appBarComponent(
  BuildContext context, {
  bool isSecondPage = false,
}) {
  final topPadding = MediaQuery.of(context).padding.top;

  return PreferredSize(
    preferredSize: Size.fromHeight(130.92 + topPadding),
    child: Container(
      color: AppColors.appBarColor,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 75.0,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: const Padding(
                padding: EdgeInsets.only(bottom: 17.0),
                child: Text(
                  "RICK AND MORTY API",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.5,
                    letterSpacing: 2.39,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 10.0 + topPadding,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                width: 115.0,
                height: 76.99,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            top: 17.48 + topPadding,
            left: 13.98,
            child: Builder(
              builder: (BuildContext innerContext) {
                return GestureDetector(
                  onTap: () {
                    if (isSecondPage) {
                      Navigator.pop(innerContext);
                    } else {
                      Scaffold.of(innerContext).openDrawer();
                    }
                  },
                  child: Image.asset(
                    isSecondPage
                        ? 'assets/images/back.png'
                        : 'assets/images/leading-icon.png',
                    width: 20.97,
                    height: 20.97,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: 12.23 + topPadding,
            right: 13.98,
            child: Image.asset(
              'assets/images/trailing-icon.png',
              width: 31.46,
              height: 31.46,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ),
  );
}
