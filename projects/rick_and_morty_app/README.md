# Rick and Morty App (Flutter)

App Flutter consumindo a Rick and Morty API. Lista de personagens com card expandível e tela de detalhes.

## Arquitetura
- `lib/models/` – modelos (`Character`)
- `lib/services/` – API (`ApiService`)
- `lib/widgets/` – componentes (`CharacterExpandableCard`)
- `lib/pages/` – telas (`HomePage`, `CharacterDetailPage`)
- `main.dart` – tema  cores e bootstrap

## Padrões
- `http` + `FutureBuilder` para consumo de API
- Animação com `AnimatedContainer`
- Responsivo (largura = tela - 40)
- Tema escuro; cabeçalho seguindo Figma

## Como rodar
```bash
flutter pub get
flutter run -d chrome  

## Como rodar 
demostracao docs/demo.gif