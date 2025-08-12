import 'package:app_kobe_alex/models/character_model.dart';
import 'package:app_kobe_alex/widgets/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Aqui
class CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailPage({super.key, required this.character});

  Widget _buildStatusIndicator(String status) {
    Color color;
    if (status == 'Alive') {
      color = Colors.green;
    } else if (status == 'Dead') {
      color = Colors.red;
    } else {
      color = Colors.grey;
    }

    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
// Função para tornar a data da api para um formato legivel
  String _formatApiDate(String dateStrinng) {
    if (dateStrinng.isEmpty) {
      return 'Desconhecida';
      
    }
    try {
      // Tenta converter a string para um objeto DateTime
      final DateTime parsedDate = DateTime.parse(dateStrinng);
      // Formata a data para o formato dia/mês/ano
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      // Se ocorrer um erro durante a conversão ou formatação, retorna a string original
      return dateStrinng;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showBackButton: true,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  character.image,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20.0),
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xff87A1FA),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      _buildStatusIndicator(character.status),
                      const SizedBox(width: 8),
                      Text(
                        '${character.status} - ${character.species}',
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildDetailRow('Status', character.status),
                  _buildDetailRow('Espécie', character.species),
                  _buildDetailRow('Gênero', character.gender),
                  _buildDetailRow('Origem', character.origin),
                  _buildDetailRow('Ùltima Locação', character.location),
                  
                  //Aqui converte a data da api para um formato legivel.
                  _buildDetailRow('Primeira Aparição', _formatApiDate(character.created)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8.0),

          Text(
            value,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
