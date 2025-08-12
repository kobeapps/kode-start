import 'package:flutter/material.dart';

class CharacterDetailScreen extends StatelessWidget {
  final dynamic character;

  const CharacterDetailScreen({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1B1F),
        toolbarHeight: 130.82,
        centerTitle: true,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 76.99,
                    width: 115,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'RICK AND MORTY API',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            color: const Color(0xff87A1FA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    character['image'] ?? '',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.grey[800],
                        child: const Icon(Icons.broken_image,
                            color: Colors.white, size: 80),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character['name']?.toUpperCase() ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildStatusRow(
                        status: character['status'] ?? 'N/A',
                        species: character['species'] ?? 'N/A',
                      ),
                      const SizedBox(height: 20),
                      _buildDetailColumn(
                        label: 'Nome:',
                        value: character['name'] ?? 'N/A',
                      ),
                      const SizedBox(height: 20),
                      _buildDetailColumn(
                        label: 'Espécie:',
                        value: character['species'] ?? 'N/A',
                      ),
                      const SizedBox(height: 20),
                      _buildDetailColumn(
                        label: 'Gênero:',
                        value: character['gender'] ?? 'N/A',
                      ),
                      const SizedBox(height: 20),
                      _buildDetailColumn(
                        label: 'Origem:',
                        value: character['origin']['name'] ?? 'N/A',
                      ),
                      const SizedBox(height: 20),
                      _buildDetailColumn(
                        label: 'Última localização:',
                        value: character['location']['name'] ?? 'N/A',
                      ),

                      const SizedBox(height: 20),
                      _buildDetailColumn(
                        label: 'Primeira Aparição:',
                        value: (character['episode'] as List).isNotEmpty
                            ? 'Episódio ${(character['episode'][0] as String).split('/').last}'
                            : 'N/A',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow({required String status, required String species}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: _getStatusColor(status),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$status - $species',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
      ],
    );
  }

  Widget _buildDetailColumn({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Lato',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'dead':
        return Colors.red;
      case 'alive':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}