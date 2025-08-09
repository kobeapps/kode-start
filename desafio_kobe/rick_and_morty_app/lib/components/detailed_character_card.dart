import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/models/character_details.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';
import 'package:rick_and_morty_app/data/repository.dart';

class DetailedCharacterCard extends StatelessWidget {
  DetailedCharacterCard({required this.characterDetails, Key? key})
    : super(key: key);

  final CharacterDetails characterDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.cardColor,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            characterDetails.image,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  characterDetails.name.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 38),
                _buildDetailWithBullet(
                  '${_capitalize(characterDetails.status)} - ${characterDetails.species}',
                  _getStatusColor(characterDetails.status),
                ),
                const SizedBox(height: 15),
                _buildTwoLineDetail(
                  'Last know location:',
                  characterDetails.location.name,
                ),
                const SizedBox(height: 15),

                FutureBuilder<String>(
                  future: characterDetails.episode.isNotEmpty
                      ? Repository.getEpisodeNameFromUrl(
                          characterDetails.episode.first,
                        )
                      : Future.value("N/A"),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _buildTwoLineDetail(
                        'First seen in:',
                        'Carregando...',
                      );
                    } else if (snapshot.hasError) {
                      return _buildTwoLineDetail(
                        'First seen in:',
                        'Erro ao carregar',
                      );
                    } else {
                      return _buildTwoLineDetail(
                        'First seen in:',
                        snapshot.data ?? 'N/A',
                      );
                    }
                  },
                ),
                const SizedBox(height: 15),
                _buildTwoLineDetail('Gender:', characterDetails.gender),
                const SizedBox(height: 15),

                _buildTwoLineDetail('Origin:', characterDetails.origin.name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status.toLowerCase() == 'alive') {
      return Colors.green;
    } else if (status.toLowerCase() == 'dead') {
      return const Color(0xFFD53C2E);
    } else {
      return Colors.grey;
    }
  }

  String _capitalize(String text) {
    if (text.isEmpty) return text;
    return '${text[0].toUpperCase()}${text.substring(1).toLowerCase()}';
  }

  Widget _buildDetailWithBullet(String value, Color bulletColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (bulletColor != Colors.transparent)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: bulletColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12.5,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoLineDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 0.7),
            fontWeight: FontWeight.w300,
            fontSize: 12.5,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
            fontSize: 12.5,
          ),
        ),
      ],
    );
  }
}
