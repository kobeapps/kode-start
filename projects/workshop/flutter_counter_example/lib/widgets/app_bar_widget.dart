import 'package:flutter/material.dart';

enum AppBarMode { list, detail }

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.mode = AppBarMode.list,
    this.backgroundColor = const Color(0xFF1C1B1F),
  });

  final AppBarMode mode;
  final Color backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(131);

  @override
  Widget build(BuildContext context) {
    Widget leadingIcon = const Icon(Icons.menu, color: Colors.white);
    VoidCallback? onLeadingTap;

    if (mode == AppBarMode.detail) {
      leadingIcon = const Icon(Icons.arrow_back, color: Colors.white);
      onLeadingTap = () => Navigator.of(context).maybePop();
    }

    return Container(
      height: 130.92,
      color: backgroundColor,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: SizedBox(
                width: 24,
                height: 24,
                child: InkWell(
                  onTap: onLeadingTap,
                  borderRadius: BorderRadius.circular(4),
                  child: Center(child: leadingIcon),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/images/main_logo.png')),
                  Text(
                    'RICK AND MORTY API',
                    style: TextStyle(color: Color(0xFFFFFFFF)),
                  ),
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.only(right: 16, top: 16),
              child: SizedBox(
                width: 24,
                height: 24,
                child: Center(
                  child: Icon(Icons.account_circle_outlined, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
