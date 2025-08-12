

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _loginStatusKey = 'isLoggedIn';

  Future<bool> login(String username, String password) async {
    //Simula uma chamada de rede
    await Future.delayed(const Duration(seconds: 2));
    
    // Simulação de login
    if (username == 'kobe' && password == '1234') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_loginStatusKey, true);
      return true;
    } else {
      return false;
    }
  }

  // Faz o Logout e limpa o status de login
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loginStatusKey);
    
  }

  //Verifica se o usuário está logado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginStatusKey) ?? false;
  }


      
    }

  