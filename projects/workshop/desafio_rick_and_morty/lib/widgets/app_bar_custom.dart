import 'package:flutter/material.dart';

enum _Mode { home, homeLarge, detail }

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppBarCustom._({
    required this.mode,
    this.onBack,
    this.onMenu,
    this.onProfile,
    super.key,
  });

  const AppBarCustom.home({VoidCallback? onMenu, VoidCallback? onProfile})
      : this._(mode: _Mode.home, onMenu: onMenu, onProfile: onProfile);

  const AppBarCustom.homeLarge({VoidCallback? onMenu, VoidCallback? onProfile})
      : this._(mode: _Mode.homeLarge, onMenu: onMenu, onProfile: onProfile);

  const AppBarCustom.detail({VoidCallback? onBack, VoidCallback? onProfile})
      : this._(mode: _Mode.detail, onBack: onBack, onProfile: onProfile);

  final _Mode mode;
  final VoidCallback? onBack;
  final VoidCallback? onMenu;
  final VoidCallback? onProfile;

  @override
  Size get preferredSize {
    switch (mode) {
      case _Mode.homeLarge:
        return const Size.fromHeight(56 + 75 + 1);
      case _Mode.home:
      case _Mode.detail:
        return const Size.fromHeight(kToolbarHeight + 8);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (mode == _Mode.homeLarge) {
      const surface = Color(0xFF1C1B1F);
      const onSurface = Color(0xFFE6E1E5);
      const onSurfaceVariant = Color(0xFFCAC4D0);

      return Material(
        color: surface,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Menu',
                    icon: const Icon(Icons.menu),
                    color: onSurface,
                    onPressed: onMenu,
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Profile',
                    icon: const Icon(Icons.account_circle),
                    color: onSurfaceVariant,
                    onPressed: onProfile,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 75,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 84,
                    height: 36,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: 24,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'RICK AND MORTY API',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 14.5,
                          letterSpacing: 2.4,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white12),
          ],
        ),
      );
    }

    final isDetail = mode == _Mode.detail;

    return AppBar(
      elevation: 0,
      backgroundColor: cs.surface,
      centerTitle: true,
      leading: IconButton(
        tooltip: isDetail ? 'Back' : 'Menu',
        icon: Icon(isDetail ? Icons.arrow_back : Icons.menu),
        onPressed: () {
          if (isDetail) {
            if (onBack != null) return onBack!();
            if (Navigator.of(context).canPop()) Navigator.of(context).pop();
          } else {
            onMenu?.call();
          }
        },
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 28,
            height: 28,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported_outlined, size: 22),
          ),
          const SizedBox(width: 8),
          Text(
            'RICK AND MORTY API',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Profile',
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: onProfile,
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
