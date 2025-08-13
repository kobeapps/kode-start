import 'package:flutter/material.dart';
import '../models/character_model.dart';
import '../main.dart'; // AppColors

class CharacterExpandableCard extends StatefulWidget {
  final Character character;
  final VoidCallback onOpenDetails;

  const CharacterExpandableCard({
    super.key,
    required this.character,
    required this.onOpenDetails,
  });

  @override
  State<CharacterExpandableCard> createState() => _CharacterExpandableCardState();
}

class _CharacterExpandableCardState extends State<CharacterExpandableCard> {
  bool isExpanded = false;

  // Medidas do Figma 
  static const double _closedH = 160;
  static const double _openH   = 360; 
  static const double _radius  = 10;
  static const double _bandTopWhenOpen = 160;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width - 40; 

    return Center(
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(_radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            width: w,
            height: isExpanded ? _openH : _closedH,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(_radius),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                // Imagem
                Positioned.fill(
                  child: Image.network(
                    widget.character.image,
                    fit: BoxFit.cover,
                  ),
                ),

                // Faixa azul com nome
                Positioned(
                  left: 0, right: 0,
                  bottom: isExpanded ? null : 0,
                  top: isExpanded ? _bandTopWhenOpen : null,
                  child: Container(
                    color: AppColors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Text(
                      widget.character.name.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                // Painel azul opaco 
                if (isExpanded)
                  Positioned(
                    top: _bandTopWhenOpen, left: 0, right: 0, bottom: 0,
                    child: Container(
                      color: AppColors.blue,
                      child: SafeArea( // protege de recortes/barras
                        top: false,
                        left: false,
                        right: false,
                        bottom: true,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // região rolável
                              Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: DefaultTextStyle(
                                    style: const TextStyle(color: Colors.white, height: 1.25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _dotLine('${widget.character.status} - ${widget.character.species}'),
                                        const SizedBox(height: 6),
                                        Text('Last known location:',
                                            style: TextStyle(color: Colors.white.withOpacity(.9))),
                                        Text(widget.character.location,
                                            maxLines: 2, overflow: TextOverflow.ellipsis),
                                        const SizedBox(height: 6),
                                        Text('First seen in:',
                                            style: TextStyle(color: Colors.white.withOpacity(.9))),
                                        const Text('Toque em detalhar →'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // botão fixo embaixo
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FilledButton(
                                  onPressed: widget.onOpenDetails,
                                  child: const Text('Detalhar'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _dotLine(String text) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 8, color: Colors.white),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}