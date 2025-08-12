
# 📱 Rick & Morty App - Desafio Técnico

![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.3.0-blue?logo=dart)
![GetX](https://img.shields.io/badge/State--Management-GetX-orange)
![License](https://img.shields.io/badge/License-MIT-green)

Um aplicativo Flutter que consome a [The Rick and Morty API](https://rickandmortyapi.com/) para listar, buscar e exibir detalhes sobre os personagens da série. Projeto desenvolvido como parte de um desafio técnico.

---

## 🎥 Demonstração

![Demonstração do Rick and Morty App](.desafio_luisa/rick_and_morty_app/assets/rick_and_morty_demo.gif)

---

## ✨ Funcionalidades

- [x] **Lista de Personagens:** Exibição da lista de personagens consumida da API.
- [x] **Paginação / Scroll Infinito:** Carregamento de novas páginas de personagens conforme o usuário rola a tela.
- [x] **Busca Dinâmica:** Campo de busca por nome com "debounce" para uma experiência fluida e sem sobrecarregar a API.
- [x] **Tela de Detalhes:** Visualização de informações detalhadas de cada personagem.
- [x] **Busca de Dados Adicionais:** A tela de detalhes busca e exibe informações do primeiro episódio em que o personagem apareceu.
- [x] **Ícone Customizado:** O app possui um ícone personalizado.
- [x] **UI Responsiva e Agradável:** Interface construída com foco na experiência do usuário.

---

## 🛠️ Arquitetura e Tecnologias Utilizadas

Este projeto foi construído com uma **arquitetura simplificada em camadas**, priorizando a clareza e a rapidez no desenvolvimento, sem abrir mão da separação de responsabilidades.

A estrutura é organizada da seguinte forma:

* **Camada de Dados (Data):** É o coração da lógica do aplicativo. Ela contém:
    * **`DataSources`**: O ponto de contato direto com a API. São responsáveis por executar as requisições HTTP e entregar os dados brutos para os Repositórios.
    * **`Repositories`**: A única fonte de verdade para os `Controllers`. Servem como uma camada de abstração que centraliza e gerencia o acesso aos `DataSources`.
    * **`Models`**: Classes que fazem o parsing do JSON da API para objetos Dart.
    * **`Controllers (GetX)`**: Classes que gerenciam o estado da UI, a lógica de interação e a orquestração das chamadas aos repositórios.

* **Camada de Apresentação (Presentation):** Responsável exclusivamente pela parte visual do aplicativo.
    * **`Pages`**: As telas completas do app (`HomePage`, `CharacterDetailsPage`, etc.).
    * **`Widgets`**: Componentes de UI reutilizáveis, como os cards de personagem.

* **Core:** Pasta que contém arquivos transversais a todo o projeto, como constantes de UI, temas, cores e widgets genéricos.

### Principais Pacotes:

* **`get`**: Para gerenciamento de estado (reatividade com `Obx`) e navegação.
* **`dio`**: Cliente HTTP para realizar as chamadas à API.
* **`google_fonts`**: Para estilização de fontes.
* **`flutter_launcher_icons`**: Para geração automática do ícone do aplicativo.

---

## 🚀 Como Executar o Projeto

```bash
# 1. Clone o repositório
git clone [https://github.com/luisabritod/kode-start.git](https://github.com/luisabritod/kode-start.git)

# 2. Entre na pasta do projeto
cd desafio_luisa/rick_and_morty_app

# 3. Instale as dependências
flutter pub get

# 4. Rode o aplicativo
flutter run
