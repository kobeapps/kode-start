# Rick and Morty App

Aplicativo Flutter desenvolvido para o desafio técnico da **Kobe**, consumindo a **Rick and Morty API** para exibir uma lista de personagens e seus detalhes.

---

## 📱 Funcionalidades

- Lista de personagens com nome e imagem
- Navegação para tela de detalhes  
- Tela de detalhes com:  
  - Nome  
  - Imagem  
  - Espécie  
  - Gênero  
  - Status  
  - Origem  
  - Última localização  
  - Primeira aparição  
- Interface baseada no protótipo do **Figma** fornecido  
- AppBar personalizada com cor, ícones e logo  

---

## 🏗 Arquitetura

Foi utilizada a arquitetura **MVVM (Model-View-ViewModel)** para manter a separação de responsabilidades de forma clara:

- **Model** → Representa as entidades (`Character`, `Location`, etc.)  
- **View** → Widgets que compõem a interface do usuário (`CharacterListPage`, `CharacterDetailPage`)  
- **ViewModel / Controller** → Camada responsável por lógica de negócios, chamadas à API e gerenciamento de estado  
- **Services** → Serviços de acesso à API (`RickAndMortyService`)  

**Estrutura de pastas:**
lib/
├── core/ # Configurações e temas

│ ├── theme/

│ └── constants/

├── data/ # Camada de dados

│ ├── models/ # Modelos de dados

│ └── services/ # Consumo da API

├── ui/ # Camada de apresentação

│ ├── pages/ # Telas principais

│ ├── widgets/ # Componentes reutilizáveis

└── main.dart # Ponto de entrada


---

## 📐 Padrões adotados

- **State Management:** `ChangeNotifier` + `Provider`  
- **Consumo de API:** `http` package para requisições REST  
- **Null Safety:** Código 100% null-safe  
- **Responsividade:** Uso de `MediaQuery` e `Flexible`  
- **Commits:** Padrão [Conventional Commits](https://www.conventionalcommits.org/)  
- **Estilo de código:** Seguindo guidelines oficiais do Flutter/Dart com `dart format`  

---

## 🛠 Tecnologias e pacotes

- **Flutter** 3.x  
- **Dart** null safety  
- **http** — requisições HTTP  
- **provider** — gerenciamento de estado  
- **cached_network_image** — cache de imagens  

---

## 🚀 Como rodar o projeto

```bash
# Clonar repositório
git clone https://github.com/victorhpriv/App-rick-and-morty

# Entrar na pasta
cd rick-and-morty-app

# Instalar dependências
flutter pub get

# Rodar o app
flutter run
```

📌 Decisões de Design
- Seguir fielmente o protótipo do Figma como referência visual
- Utilizar AppBar personalizada com logo e cores definidas no protótipo
- Escolher MVVM para facilitar manutenção e testes
- Utilizar Provider pela leveza e simplicidade no gerenciamento de estado
