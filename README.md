## Arquitetura e Padrões Adotados

### Organização dos Arquivos
- **Separação das telas**: As telas foram divididas em arquivos diferentes para manter o código limpo e evitar arquivos muito grandes.
- **main.dart**: Responsável por iniciar o aplicativo, configurar o tema (cores e fontes) e mostrar a tela inicial.
- **detalhe.dart**: Contém o código da tela de detalhes do personagem.

### Padrões Seguidos
- **Separação de Lógica e Interface**: A função que busca os dados da API foi isolada do código que desenha as telas, mantendo responsabilidades claras.
- **Gerenciamento de Estado Simples**: Uso de `StatefulWidget` e `setState()` para atualizar a lista de personagens e os resultados da busca.
- **Widgets Reutilizáveis**: Criação de componentes reaproveitáveis para reduzir repetição de código.
- **Passagem de Dados Entre Telas**: Os dados do personagem selecionado são enviados diretamente para a tela de detalhes, evitando novas requisições à API e melhorando o tempo de resposta.
