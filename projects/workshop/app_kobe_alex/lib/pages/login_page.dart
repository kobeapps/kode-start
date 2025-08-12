import 'package:app_kobe_alex/pages/character_list_page.dart';
import 'package:app_kobe_alex/data/services/auth_service.dart';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final sucess = await _authService.login(
        _userNameController.text,
        _passwordController.text,
      );
      if (!mounted) return;

      if (sucess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CharacterListPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Usuario ou senha invalidos.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF171717),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 150),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(labelText: 'Usuário'),
                  validator: (value) =>
                      value!.isEmpty ? 'Informe o usuário.' : null,
                ),

                const SizedBox(height: 40),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (value) =>
                      value!.isEmpty ? 'Informe a senha.' : null,
                ),
                const SizedBox(height: 40),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
