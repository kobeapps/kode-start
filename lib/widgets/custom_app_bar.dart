import 'package:flutter/material.dart';


AppBar buildCustomAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
  icon: const Icon(Icons.menu, color: Colors.white,), 
  onPressed: () {
    Navigator.popUntil(context, (route) => route.isFirst);
  },
),
    backgroundColor: const Color.fromRGBO(28, 27, 31, 1),
    elevation: 0,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'RICK AND',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'MORTY API',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
        Image.asset('assets/kodelogo.png', height: 35),
      ],
    ),
  );
}