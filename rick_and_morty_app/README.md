# Rick & Morty App

Aplicativo Flutter para explorar personagens da série Rick and Morty, com **busca por nome**, **paginação**, **cards que expandem ao passar o mouse (hover)**, e tela especial de **Ranking & Curiosidades**.

## Funcionalidades

- **Busca por nome** (com debounce para evitar requisições desnecessárias)
- **Paginação infinita** (carrega mais ao chegar no fim da lista)
- **Expansão de card no hover** (web/desktop) e via toque longo no mobile
- **Detalhes do personagem** (status, espécie, origem, localização, primeira aparição)
- **Ranking de aparições** (Top 10 personagens que mais aparecem)
- **Curiosidades** (estatísticas sobre espécies, status e origens)
- **Tema escuro** estilizado com design tokens

## Tecnologias

- [Flutter](https://flutter.dev) (>= 3.3)
- [Riverpod](https://riverpod.dev) — Gerência de estado
- [HTTP](https://pub.dev/packages/http) — Requisições HTTP
- API pública: [Rick and Morty API](https://rickandmortyapi.com/)

## Estrutura do Projeto

lib/
├── design/ # Tokens de design (cores, espaçamentos, radius)
├── models/ # Modelos (Character, Episode)
├── pages/ # Telas (Home, Detalhes, Insights)
├── providers/ # Riverpod Notifiers e Providers
├── repositories/ # Repositórios (abstraem ApiService)
├── services/ # Consumo da API (HTTP)
└── widgets/ # Widgets customizados (Card do personagem)

## Instalação e Execução

```bash
# Clonar repositório
git clone https://github.com/seu-usuario/rick-morty-browser.git
cd rick_and_morty_app

# Instalar dependências
flutter pub get

# Rodar no dispositivo/emulador
flutter run