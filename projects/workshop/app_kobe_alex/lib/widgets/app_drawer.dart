import 'package:app_kobe_alex/pages/about_page.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF24282F),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF171717)),
            child: Center(
              child: Image.asset('assets/images/logo.png', height: 80),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white70),
            title: const Text(
              'Inicio',
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.white70),
            title: const Text('Sobre', style: TextStyle(color: Colors.white70)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
