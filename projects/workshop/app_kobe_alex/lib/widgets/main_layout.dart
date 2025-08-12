import 'package:app_kobe_alex/data/services/auth_service.dart';
import 'package:app_kobe_alex/pages/login_page.dart';
import 'package:app_kobe_alex/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final bool showBackButton;
  final PreferredSizeWidget? appBarBottom;
  // aqui ok

  const MainLayout({
    super.key,
    required this.body,
    this.showBackButton = false,
    this.appBarBottom,
  });

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Sair'),
          content: const Text('Deseja realmente sair?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),

            TextButton(
              child: const Text('Sair'),
              onPressed: () async {
                await AuthService().logout();
                if (dialogContext.mounted) {
                  Navigator.pushAndRemoveUntil(
                    dialogContext,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (Route<dynamic> route) => false,
                  );
                }
                // Navega para o login e remove todas as telas anteriores
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      drawer: const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 130.92,
        backgroundColor: const Color(0xFF171717),
        elevation: 0,

        leadingWidth: 56,

        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.grey, size: 28),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Colors.grey,
              size: 28,
            ),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],

        flexibleSpace: SafeArea(
          child: Column(
            children: [
              // --- Logo --- //
              Image.asset('assets/images/logo.png', width: 115, height: 76.99),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text('RICK AND MORTY API'),
              ),
            ],
          ),
        ),

        bottom: appBarBottom,
      ),

      body: body,
    );
  }
}
