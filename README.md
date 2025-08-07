🚀 Rick and Morty App - Desafio KOBE
Este repositório contém a solução desenvolvida para o desafio de construção de um aplicativo móvel em Flutter para fãs de Rick and Morty, consumindo a The Rick and Morty API (REST). O foco principal foi a fidelidade ao design de alta qualidade do Figma e a aplicação de boas práticas de desenvolvimento.

🎯 O Desafio
O objetivo era criar um aplicativo Flutter que permitisse aos usuários:

Exibir uma lista de personagens da série.

Visualizar detalhes completos de cada personagem.

Seguir um protótipo de alta fidelidade fornecido, replicando cada detalhe visual.

✨ Funcionalidades Implementadas
Funcionalidades Obrigatórias (Fidelidade ao Figma)
Listagem de Personagens:

Exibe uma lista paginada de personagens.

Cada card de personagem apresenta a imagem e o nome em um layout sobreposto, replicando o design do Figma.

A lista é vertical e permite rolagem suave.

![Listagem de Personagens](docs\assets\images\rolagem-ezgif.com-video-to-gif-converter.gif)

Tela de Detalhes do Personagem:

Ao clicar em um personagem, o usuário é direcionado a uma tela com informações detalhadas.

Exibe Nome, Imagem, Status, Espécie, Gênero, Origem, Última Localização e Primeira Aparição.

O Status é visualmente indicado por uma bolinha colorida (verde para "Alive", vermelho para "Dead", cinza para "Unknown"), com borda branca, conforme o Figma.

Detalhes como "Gênero", "Origem", "Última Localização" e "Primeira Aparição" são apresentados em um formato de "rótulo em cima, valor embaixo", com tipografia e opacidade fiéis ao design.

A Primeira Aparição (nome do episódio) é buscada dinamicamente através de uma chamada secundária à API de episódios, garantindo dados precisos.

![Tela de Detalhes](docs\assets\images\page_detalhes-ezgif.com-video-to-gif-converter.gif)

Navegação Intuitiva:

Transições suaves entre a tela de listagem e a tela de detalhes.

A AppBar se adapta dinamicamente, mostrando o ícone de menu na tela inicial e o ícone de voltar na tela de detalhes.

![Navegação de Tela](docs\assets\images\movimentao-ezgif.com-video-to-gif-converter.gif)

Funcionalidades Adicionais (Além do Escopo Mínimo)
Filtros Avançados por Categoria:

Implementação de um sistema de filtros acessível através do ícone de menu na AppBar.

Categorias de filtro incluem Status, Espécie e Gênero.

Cada categoria é um ExpansionTile (seção expansível) para melhor organização.

Seleção única por categoria de filtro (RadioListTile), alinhada com as capacidades da API.

Botões "Limpar Filtros" e "Aplicar Filtros" com feedback visual de clique.

![Filtro](docs\assets\images\filtro-ezgif.com-video-to-gif-converter.gif)

🛠️ Aspectos Técnicos e Decisões de Arquitetura
Este projeto foi construído com as seguintes decisões e boas práticas:

Flutter & Dart: Utilização do SDK Flutter para desenvolvimento de aplicativos móveis multiplataforma, aproveitando sua flexibilidade e performance.

Consumo de API REST (Dio):

Integração com a The Rick and Morty API utilizando a biblioteca Dio para requisições HTTP, conhecida por sua robustez e interceptors.

A camada de Repository encapsula a lógica de chamada da API, separando-a da UI.

Lidando com dados assíncronos (FutureBuilder) para buscar o nome do episódio de "Primeira Aparição", demonstrando o tratamento de múltiplas requisições.

Arquitetura Modular:

O código é organizado em camadas claras: data (com models e repository), components (widgets reutilizáveis), pages (telas da aplicação) e theme (cores e estilos). Isso promove a separação de responsabilidades (Single Responsibility Principle) e facilita a manutenção.

Fidelidade ao Design (Figma - Pixel Perfect):

A AppBar foi construída com Stack e Positioned para replicar a complexidade do design de sobreposição de elementos (logo, ícones, texto) e respeitar a Safe Area do dispositivo.

Os cards de personagem (CharacterCard e DetailedCharacterCard) utilizam Stack para a sobreposição de elementos (imagem e barra de nome/detalhes), com bordas arredondadas e cores exatas do Figma.

Tipografia (GoogleFonts - Lato), tamanhos de fonte, pesos (Light, Regular, Medium, Bold) e espaçamentos (padding, margin, letter spacing) foram ajustados pixel a pixel para corresponder ao protótipo.

Cores definidas em app_colors.dart para centralizar a paleta de cores.

Gerenciamento de Estado: Utilização de StatefulWidgets e setState para gerenciar o estado da UI de forma eficiente, especialmente na HomePage e no FilterDrawer.

🚀 Como Rodar o Projeto
Para executar este projeto em sua máquina local, siga os passos abaixo:

Pré-requisitos
Certifique-se de ter as seguintes ferramentas instaladas e configuradas:

Flutter SDK (versão estável): Guia de Instalação

Android Studio: Necessário para o SDK Android e para criar/gerenciar emuladores.

VS Code: Com as extensões Flutter e Dart instaladas.

Git: Para clonar o repositório.

Executando o Aplicativo
Navegue até a pasta do projeto:
Abra seu terminal (ou o terminal integrado do VS Code) e navegue até a pasta raiz do projeto Flutter (rick_and_morty_app). Se você seguiu a estrutura recomendada, o caminho será algo como:

cd kode-start/desafio_kobe/rick_and_morty_app


Obtenha as Dependências:
Execute o comando para baixar todas as dependências do projeto:

flutter pub get

Verifique o Ambiente (Opcional, mas recomendado):
Para garantir que tudo está pronto, execute:

flutter doctor

Resolva quaisquer avisos ou erros relacionados ao Android SDK ou licenças, se aparecerem.

Inicie um Emulador ou Conecte um Dispositivo:
Abra o Android Studio, vá em More Actions > Device Manager e inicie um emulador Android. Alternativamente, conecte um dispositivo Android físico ao seu computador.

Execute o Aplicativo:
Com o emulador (ou dispositivo) rodando e o terminal na pasta do projeto, execute:

flutter run

O aplicativo será compilado e iniciado no dispositivo selecionado.