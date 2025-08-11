# Rick and Morty API

Conheça mais sobre os personagens do seriado Rick and Morty.
Pesquise pernagens pelo nome ou veja todos os personages disponíveis.

## Sobre o projeto

Construído em Flutter, o App foi desenvolvido seguindo uma arquitetura em camadas simples (Layered Structure).  
Cada pasta contida na raiz lib representa uma camada do projeto.
- screens: telas da aplicação;
- theme: strings, cores e imagens
- components: componentes reutilizáveis
- data: camada que realiza a conexão com a API
- models: classes representantes dos modelos de dados da aplicação

Além disso, o projeto procura adotar boas práticas, como:
- variáveis e métodos semânticos
- modularização
- alta coesão e baixo acoplamento

## Como rodar em sua máquina

### 1. Instale o Flutter
Baixe o SDK do Flutter:
- https://flutter.dev/docs/get-started/install
- Extraia o conteúdo para a pasta C:\src\flutter (no Windows)
- Adicione o caminho C:\src\flutter\bin à variável de ambiente PATH

### 2. Clone este repositório
git clone https://github.com/thiago-arend/desafio-kode-start-2025.git  
cd desafio-kode-start-2025

### 3. Instale as dependências
flutter pub get

### 4. Instale o Android Studio
Baixe e instale: https://developer.android.com/studio  
Durante a instalação, marque para instalar o Android SDK e Android Virtual Device (AVD)

### 5. Inicie um simulador Android
No Android Studio, vá em: Tools > Device Manager  
Crie e inicie um dispositivo virtual

### 6. Execute o projeto
flutter run
