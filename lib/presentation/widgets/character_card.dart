
import 'package:cached_network_image/cached_network_image.dart';
import '../screens/detail_screen.dart';
import 'package:flutter/material.dart';
import '../../data/models/character_model.dart';


class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    // Eu envolvo meu Card com um InkWell pra ele ser clicável e ter o efeito de splash.
    return InkWell(
      onTap: () {
  // Eu uso o Navigator para empurrar uma nova rota (tela) na pilha.
  Navigator.push(
    context,
    MaterialPageRoute(
      // A nova tela a ser construída é a DetailScreen.
      // Eu passo o objeto 'character' completo para o construtor dela.
      builder: (context) => DetailScreen(character: character),
    ),
  );
},
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        // O Stack me deixa colocar o texto em cima da imagem.
        child: Stack(
          children: [
            // A imagem do personagem, que cobre todo o card.
            CachedNetworkImage(
  imageUrl: character.imageUrl,
  height: 200,
  width: double.infinity,
  fit: BoxFit.cover,
  // O que mostrar enquanto a imagem está sendo baixada pela primeira vez.
  placeholder: (context, url) => const SizedBox(
    height: 200,
    child: Center(child: CircularProgressIndicator()),
  ),
  // O que mostrar se der erro ao baixar a imagem.
  errorWidget: (context, url, error) => const SizedBox(
    height: 200,
    child: Center(child: Icon(Icons.error)),
  ),
),

            // Eu posiciono o nome na parte de baixo.
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                color: const Color(0xFF5C6BC0), // Um azul/índigo parecido com o do design
                child: Text(
                  // Deixo o texto em maiúsculas, como no design.
                  character.name.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
    fontSize: 16.0, // Ajusto o tamanho da fonte
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2, // Adiciono um espaçamento para ficar mais elegante
  ),
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
              ),
            ),
          ],
        ),
      ),
    );
  }
}