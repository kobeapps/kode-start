import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size(360, 131);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      height: 131,
      color: const Color(0xFF1C1B1F),
      child: Stack(
        children: [
          Positioned(
            top: 12.23,
            left: 16,
            child: SizedBox(
              width: 31.46,
              height: 31.46,
              child: Icon(
                Icons.menu,
                color: Color(0xFFBDBDBD),
                size: 31.46,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 123,
            child: Image.asset(
              'assets/images/logo.png',
              width: 115,
              height: 76.99,
            ),
          ),
          Positioned(
            top: 12.23,
            left: 314.56,
            child: SizedBox(
              width: 31.46,
              height: 31.46,
              child: Icon(
                Icons.account_circle,
                color: Color(0xFFBDBDBD),
                size: 31.46,
              ),
            ),
          ),
          Positioned(
            top: 93,
            left: 83,
            child: SizedBox(
              width: 194,
              height: 17,
              child: Center(
                child: Text(
                  'RICK AND MORTY API',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.5,
                    letterSpacing: 2.4,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
