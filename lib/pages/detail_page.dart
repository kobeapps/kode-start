import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/character.dart';

class DetailPage extends StatefulWidget {
  final Character character;
  const DetailPage({super.key, required this.character});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String? firstEpisodeTitle;
  bool loadingEpisode = true;

  @override
  void initState() {
    super.initState();
    fetchFirstEpisode();
  }

  Future<void> fetchFirstEpisode() async {
    try {
      if (widget.character.episodes.isNotEmpty) {
        final url = widget.character.episodes.first;
        final res = await http.get(Uri.parse(url));
        if (res.statusCode == 200) {
          final data = json.decode(res.body);
          setState(() {
            firstEpisodeTitle = data['name'] ?? url;
            loadingEpisode = false;
          });
          return;
        }
      }
    } catch (e) {
      // pode logar erro aqui se quiser
    }
    setState(() {
      firstEpisodeTitle = 'Unknown';
      loadingEpisode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.character;
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F10),
      appBar: AppBar(
        toolbarHeight: 120, // aumentei a altura aqui
        backgroundColor: const Color(0xFF151515),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 55,
            ),
            const SizedBox(height: 6),
            const Text(
              'RICK AND MORTY API',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.account_circle_outlined, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              color: const Color(0xFF151515),
              child: Column(
                children: const [
                  SizedBox(height: 6),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  c.image,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF87A1FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.name.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: c.status.toLowerCase() == 'alive'
                              ? Colors.greenAccent
                              : c.status.toLowerCase() == 'dead'
                                  ? Colors.redAccent
                                  : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${c.status} - ${c.species}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Last known location:',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      c.originName,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'First seen in:',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    loadingEpisode
                        ? const Text('Loading...',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12))
                        : Text(
                            firstEpisodeTitle ?? 'Unknown',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
