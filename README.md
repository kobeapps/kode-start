Desafio Flutter - Rick & Morty App (Kobe)
Este é um aplicativo Flutter desenvolvido como parte do desafio da Kobe. O app consome a API do Rick and Morty para exibir uma lista de personagens e seus detalhes.

Funcionalidades Implementadas
[x] Listagem infinita de personagens na tela principal.

[x] Card de personagem com imagem e nome.

[x] Navegação para uma tela de detalhes ao tocar em um personagem.

[x] Tela de detalhes exibindo informações completas: status, espécie, gênero, origem, etc.

[x] Interface baseada no protótipo de alta fidelidade fornecido.

Arquitetura e Padrões
Para este projeto, adotei uma arquitetura limpa e organizada, focada na separação de responsabilidades para garantir um código escalável e de fácil manutenção.

A estrutura de pastas principal dentro de lib/ é a seguinte:

lib/
├── data/
│   ├── models/       # Contém as classes de modelo (ex: Character) que representam os dados da API.
│   └── services/     # Responsável pela comunicação com a API (ex: CharacterService).
│
├── presentation/
│   ├── screens/      # As telas do aplicativo (ex: HomeScreen, DetailScreen).
│   └── widgets/      # Widgets reutilizáveis (ex: CharacterCard).
│
├── utils/
│   └── constants.dart  # Armazena constantes como URLs e chaves de API.
│
└── main.dart         # Ponto de entrada do aplicativo.

Principais Decisões e Padrões:
Separação de Camadas: A estrutura separa claramente a camada de Dados (data) da camada de Apresentação (presentation). A camada de apresentação não sabe como os dados são obtidos, ela apenas solicita ao serviço e exibe o resultado.

Modelagem de Dados: Criei a classe Character para transformar o JSON da API em um objeto Dart fortemente tipado. Isso evita erros de digitação e torna o código mais seguro e legível.

Services para Lógica de Negócio: Toda a lógica de chamada da API (usando o pacote http) e o tratamento de erros de rede estão encapsulados na classe CharacterService.

State Management com StatefulWidget e FutureBuilder: Para o gerenciamento de estado assíncrono, utilizei a combinação de StatefulWidget com FutureBuilder. Esta é uma abordagem nativa do Flutter, ideal para lidar com dados que vêm de uma chamada de API, tratando automaticamente os estados de carregamento, erro e sucesso.

Widgets Reutilizáveis: Componentes como o CharacterCard foram extraídos para seus próprios arquivos na pasta widgets, permitindo que sejam facilmente reutilizados e mantidos.

Como Rodar o Projeto
Certifique-se de ter o Flutter instalado.

Clone o repositório: git clone https://github.com/silvaaszx/kobe-rick-morty-challenge.git

Navegue até a pasta do projeto: cd kobe-rick-morty-challenge

Instale as dependências: flutter pub get

Rode o aplicativo: flutter run

Finalizado! 🚀