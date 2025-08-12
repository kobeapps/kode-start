import 'package:flutter/material.dart';
import '../data/result.dart';
import 'app_bar_widget.dart';
import '../repositories/rick_and_morty_repository.dart';
import '../utils/translations.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterDetailPage extends StatelessWidget {
  final Result character;
  const CharacterDetailPage({super.key, required this.character});
  static final _repo = RickAndMortyRepository();

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    const dark = Color(0xFF1D1F23);
    const primary = Color(0xFF5C75F6);

    return Scaffold(
      backgroundColor: dark,
      appBar: const AppBarWidget(mode: AppBarMode.detail),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 420,
                width: 320,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: primary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: Image.network(
                              character.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: DefaultTextStyle(
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 13, 
                              height: 1.25, 
                              fontWeight: FontWeight.w400,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.name.toUpperCase(),
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize:
                                        14.5,
                                    fontWeight: FontWeight.w900,
                                    height: 1.0,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 10,
                                        color: _statusColor(character.status)),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${Tr.status(character.status)} - ${Tr.species(character.species)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500,
                                        height: 2,
                                        letterSpacing: 0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                _Line(
                                    label: Tr.labelGender,
                                    value: Tr.gender(character.gender)),
                                _Line(
                                    label: Tr.labelOrigin,
                                    value: Tr.proper(character.origin.name)),
                                _Line(
                                    label: Tr.labelLastLocation,
                                    value: Tr.proper(character.location.name)),
                                if (character.episode.isNotEmpty)
                                  FutureBuilder<String?>(
                                    future: _repo.getEpisodeNameByUrl(
                                        character.episode.first),
                                    builder: (context, snap) {
                                      if (snap.connectionState !=
                                          ConnectionState.done) {
                                        return const Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: SizedBox(
                                            height: 16,
                                            width: 16,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2),
                                          ),
                                        );
                                      }
                                      final episodeName =
                                          snap.data ?? 'Desconhecido';
                                      return _Line(
                                          label: Tr.labelFirstSeen,
                                          value: episodeName);
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final String label;
  final String value;
  const _Line({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label\n',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                height: 1.5,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                height: 1.5,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
