import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kobeproj/api_service.dart';
import 'package:kobeproj/char_model.dart';
import 'package:kobeproj/char_page.dart';
import 'package:kobeproj/widgets/custom_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildCustomAppBar(context),
      body: FutureBuilder<List<CharModel>>(
        future: fetchCharacters(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final characters = snapshot.data!;

            return ListView.builder(
              itemCount: characters.length,

              itemBuilder: (context, index) {
                return CharCard(character: characters[index]);
              },
            );
          } else {
            return const Center(child: Text('No characters found'));
          }
        },
      ),
    );
  }
}

class CharCard extends StatefulWidget {
 final CharModel character;
final bool isInitiallyExpanded;

  const CharCard({
    super.key,
    required this.character,
    this.isInitiallyExpanded = false, 
  });

  @override
  State<CharCard> createState() => _CharCardState();
}

class _CharCardState extends State<CharCard> {
late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharPage(
              character: widget.character,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              widget.character.imageUrl,
              height: 180,
              fit: BoxFit.cover,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(16.0),
              color: const Color(0xFF6E729D),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.character.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  if (_isExpanded) ...[
                    const SizedBox(height: 12),
                    _buildStatus(),
                    const SizedBox(height: 16),
                    _buildDetails('Last know location:', widget.character.location),
                    const SizedBox(height: 12),
                    _buildDetails('First seen in:', widget.character.origin),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 8),
                  Center(
                    child: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: Colors.grey[350], fontSize: 14)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16)),
      ],
    );
  }

  Widget _buildStatus() {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: widget.character.status == 'Alive'
                ? Colors.lightGreenAccent
                : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${widget.character.status} - ${widget.character.species}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
