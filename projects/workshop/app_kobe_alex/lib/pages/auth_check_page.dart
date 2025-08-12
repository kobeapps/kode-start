import 'package:app_kobe_alex/data/services/auth_service.dart';
import 'package:app_kobe_alex/pages/character_list_page.dart';
import 'package:app_kobe_alex/pages/login_page.dart';
import 'package:flutter/material.dart';

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await AuthService().isLoggedIn();
    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CharacterListPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
   // Mostra uma tela de carregamento enquanto o estado do usuário é verificado
    return const Scaffold(
      backgroundColor: Color(0xFF171717),
      body: Center(child: CircularProgressIndicator(),
      ),
    );
  }
}
