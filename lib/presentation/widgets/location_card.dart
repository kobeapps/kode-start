// lib/presentation/widgets/location_card.dart

import 'package:flutter/material.dart';
import '../../data/models/location_model.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: const Color(0xFF2E3D56),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.blueGrey.shade700, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF82E6EB),
                letterSpacing: 1.2,
              ),
            ),
            const Divider(color: Colors.white24, height: 24.0),
            // TRADUÇÃO AQUI
            Text(
              'Type: ${location.type}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 8.0),
            // E AQUI
            Text(
              'Dimension: ${location.dimension}',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
