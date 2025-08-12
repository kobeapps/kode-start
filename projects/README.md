Rick & Morty Flutter App
App em Flutter que lista personagens da API Rick and Morty e exibe detalhes referentes ao seriado. Este projeto foi desenvolvido para o desafio Kode Start 2025. O foco aqui era desenvolver um app com o mais alto grau possivel de fidelidade ao Mok fornecido pela Kobe através do Figma e atendendo aos seguintes requisitos: 

- Scroll na lista de personagens
- Exibir nos cards: Nome, imagem
- Tela de detalhes com: Nome, imagem, espécie, gênero, status, origem, última       localização, primeira aparição
- Navegar da tela de listagem até a tela de detalhe de personagem

* Funcionalidade opcional ( Busca por Nome, parcial ou completo com design à critério do desenvolvedor) Desenvolvida ✅

*Todas as funcionalidades acima foram desenvolvidas com sucesso, por tanto, todos os critérios foram atendidos !

* De bonus: 
  - Criei um filtro de favoritos, onde o usuário pode favoritar um personagem clicando em um ícone de coração posicionado na parte superior direita de cada imagem , depois, pode filtrar no topo do app buscando apenas os personagens favoritados. 

  - Adicionei Estados e feedbacks
    Loading (CircularProgressIndicator) e mensagens de erro/sem resultados adequadas.

  - Usei o chat-gpt para criar um arquivo (lib > utils > translations.dart) para traduzir as informações de detalhes retornadas pela API. 

    * Como testar essas funcionalidades bônus:
    Busca: digite “rick” e clique na lupa → lista filtra via API.

    Favoritos: toque no coração no card para favoritar um personagem.

    Somente favoritos: ative o filtro no bloco abaixo da busca.

    Detalhes: toque em um card → ver status/especie/gênero/origem/última loc/primeira aparição (com nome do episódio).

    Voltar: ícone de voltar no topo do header na página de detalhes


* Demonstração


* Stack
Flutter/Dart

dio (HTTP)

google_fonts (Lato)

shared_preferences (persistência simples)

* Estrutura do projeto

lib/
 ├─ data/                # models (Result, Origin, Location…)
 ├─ repositories/        # RickAndMortyRepository (chamadas Dio, mappers)
 ├─ services/            # FavoritesService (persistência de favoritos)
 ├─ utils/               # translations (rótulos/strings)
 ├─ widgets/
 │   ├─ app_bar_widget.dart         # AppBar unificada (list/detail)
 │   ├─ characters_list_view.dart   # Lista + busca + favoritos
 │   └─ character_detail_page.dart  # Detalhes + episódio inicial
 └─ main.dart

* Como rodar
No terminal do Vs code, rodar o comando → flutter run -d chrome


API base: https://rickandmortyapi.com
