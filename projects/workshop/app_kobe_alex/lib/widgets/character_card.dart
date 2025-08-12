import 'package:flutter/material.dart';


// aqui ok
class CharacterCard extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CharacterCard({super.key, required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Garante que a imagem respeite os cantos
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Image.network(
            imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,

            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
                child: child,
              );
            },

            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 180,
                color: const Color.fromARGB(255, 48, 183, 201),
                child: const Center(child: CircularProgressIndicator()),
              );
            },
          ),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            color: const Color(0xFF87A1FA),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.5,
                fontFamily: 'Lato-Bold',
                fontWeight: FontWeight.w900,
              ),
            ),
          )

          
        ],
      ),
    );
  }
}
