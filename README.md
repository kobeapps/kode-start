# Rick and Morty Flutter App

Este é um aplicativo Flutter que utiliza a API do Rick and Morty para exibir informações sobre os personagens da série.

## Estrutura do Projeto

- `lib/main.dart`: Ponto de entrada do aplicativo.
- `lib/models/character.dart`: Modelo que representa um personagem.
- `lib/screens/character_list_screen.dart`: Tela que exibe a lista de personagens.
- `lib/screens/character_detail_screen.dart`: Tela que exibe os detalhes de um personagem específico.
- `lib/widgets/character_card.dart`: Widget que exibe informações resumidas de um personagem.
- `lib/widgets/search_bar.dart`: Widget que permite buscar personagens por nome.
- `lib/services/api_service.dart`: Serviço responsável por fazer requisições à API.
- `lib/utils/constants.dart`: Definição de constantes utilizadas no aplicativo.

## Instalação

1. Clone o repositório:
   ```
   git clone https://github.com/seu_usuario/rick_and_morty_flutter_app.git
   ```
2. Navegue até o diretório do projeto:
   ```
   cd rick_and_morty_flutter_app
   ```
3. Instale as dependências:
   ```
   flutter pub get
   ```

## Uso

Para executar o aplicativo, utilize o seguinte comando:
```
flutter run
```

O aplicativo exibirá uma lista de personagens da série Rick and Morty, permitindo que você visualize detalhes de cada um deles e busque por nome.