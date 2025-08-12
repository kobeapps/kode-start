// Constantes utilizadas no aplicativo Rick and Morty

class ApiConstants {
  // URL base da API do Rick and Morty
  static const String baseUrl = 'https://rickandmortyapi.com/api';
  
  // Endpoints específicos
  static const String charactersEndpoint = '/character';
  static const String locationsEndpoint = '/location';
  static const String episodesEndpoint = '/episode';
}

class AppConstants {
  // Nome do aplicativo
  static const String appName = 'Rick & Morty';
  
  // Valores padrão
  static const int defaultPageSize = 20;
  static const int maxRetries = 3;
}

class AppStrings {
  // Mensagens de erro
  static const String networkError = 'Erro de conexão. Verifique sua internet.';
  static const String genericError = 'Algo deu errado. Tente novamente.';
  static const String noDataFound = 'Nenhum dado encontrado.';
  
  // Labels da interface
  static const String loading = 'Carregando...';
  static const String retry = 'Tentar novamente';
}
