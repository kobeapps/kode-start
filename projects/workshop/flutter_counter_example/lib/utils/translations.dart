// lib/utils/translations.dart
class Tr {
  // ---- labels (rótulos da UI) ----
  static const labelGender = 'Gênero';
  static const labelOrigin = 'Origem';
  static const labelLastLocation = 'Última localização conhecida';
  static const labelFirstSeen = 'Primeira aparição';

  // ---- valores vindos da API ----
  static String status(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'alive': return 'Vivo';
      case 'dead': return 'Morto';
      case 'unknown': return 'Desconhecido';
      default: return s ?? '';
    }
  }

  static String gender(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'male': return 'Masculino';
      case 'female': return 'Feminino';
      case 'genderless': return 'Sem gênero';
      case 'unknown': return 'Desconhecido';
      default: return s ?? '';
    }
  }

  static String species(String? s) {
    switch ((s ?? '').toLowerCase()) {
      case 'human': return 'Humano';
      case 'alien': return 'Alienígena';
      case 'humanoid': return 'Humanoide';
      case 'robot': return 'Robô';
      case 'mythological creature': return 'Criatura mitológica';
      default: return s ?? '';
    }
  }

  /// Tradução "leve" de nomes próprios (origem/local/locais do app).
  /// Regras:
  /// - Substitui somente termos conhecidos (fallback mantém original).
  /// - Mantém códigos como "C-137".
  /// - Traduz frases comuns (multi-palavra) antes de palavras isoladas.
  static String proper(String? source) {
    var out = source ?? '';
    if (out.trim().isEmpty) return out;

    // Frases mais comuns primeiro (evita conflito com palavras soltas)
    const multi = <String, String>{
      'replacement dimension': 'Dimensão substituta',
      'citadel of ricks': 'Cidadela dos Ricks',
      'interdimensional cable': 'Cabo Interdimensional',
      'anatomy park': 'Parque de Anatomia',
      'purge planet': 'Planeta da Purga',
      'bird world': 'Mundo dos Pássaros',
    };

    // Palavras soltas
    const single = <String, String>{
      'earth': 'Terra',
      'dimension': 'Dimensão',
      'citadel': 'Cidadela',
      'planet': 'Planeta',
      'world': 'Mundo',
      'city': 'Cidade',
      'castle': 'Castelo',
      'hospital': 'Hospital',
      'school': 'Escola',
      'universe': 'Universo',
      'unknown': 'Desconhecido',
      // geralmente deixo 'rick', 'morty' como estão
    };

    // Aplica frases multi-palavra (case-insensitive, com bordas de palavra)
    multi.forEach((en, pt) {
      final re = RegExp(r'\b' + RegExp.escape(en) + r'\b', caseSensitive: false);
      out = out.replaceAll(re, pt);
    });

    // Aplica palavras isoladas
    single.forEach((en, pt) {
      final re = RegExp(r'\b' + RegExp.escape(en) + r'\b', caseSensitive: false);
      out = out.replaceAll(re, pt);
    });

    // Compacta espaços múltiplos (só por higiene)
    out = out.replaceAll(RegExp(r'\s{2,}'), ' ');
    return out;
  }
}
