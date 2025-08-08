import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1C1B1F),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.6, top: 19),
              child: Icon(Icons.menu, size: 20.97, color: Colors.white),
            ),
            Column(
              children: [
                Image.asset('assets/images/Group 119.png'),
                Text(
                  'RICK AND MORTY API',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.6, top: 14.85),
              child: Icon(
                Icons.account_circle_rounded,
                size: 26.21,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(130.92);
}
