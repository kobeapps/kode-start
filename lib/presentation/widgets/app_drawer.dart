// lib/presentation/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const AppDrawer({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          color: const Color(0xFF121212),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 180,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/app_logo.svg',
                        height: 60,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Rick and Morty API',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14, 
                          fontWeight: FontWeight.bold, 
                          letterSpacing: 1.5,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildDrawerItem(
                context: context,
                icon: Icons.people_outline,
                title: 'Characters',
                index: 0,
              ),
              _buildDrawerItem(
                context: context,
                icon: Icons.public_outlined,
                title: 'Locations',
                index: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return Container(
      decoration: BoxDecoration(
        border: isSelected
            ? const Border(
                left: BorderSide(
                  color: Color(0xFF5C6BC0),
                  width: 4.0,
                ),
              )
            : null,
        color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        onTap: () {
          onItemSelected(index);
          Navigator.pop(context);
        },
      ),
    );
  }
}
