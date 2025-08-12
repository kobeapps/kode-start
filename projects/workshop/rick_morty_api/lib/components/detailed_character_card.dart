import 'package:flutter/material.dart';
import 'package:rick_morty_api/models/detailed_character.dart';
import 'package:rick_morty_api/theme/app_colors.dart';

class DetailedCharacterCard extends StatelessWidget {
  const DetailedCharacterCard({required this.detailedCharacter, super.key});

  final DetailedCharacter detailedCharacter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 500,
      child: Card(
        color: AppColors.primaryColorLight,
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SingleChildScrollView(  // evitar dar o erro de falta de espaço 
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  detailedCharacter.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 160,
                ),
              ),
              const SizedBox(height: 20),

              Text(
                detailedCharacter.name.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                  fontSize: 14.5,
                  height: 1.0,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 40),

              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: detailedCharacter.status == 'Alive'
                          ? AppColors.green
                          : AppColors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1),
                    ),
                  ),
                  const SizedBox(width: 6, height: 20),
                  Text(
                    '${detailedCharacter.status} - ${detailedCharacter.species}',
                    style: const TextStyle(
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.5,
                      height: 1.0,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Gender:\n',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        fontSize: 12.5,
                        height: 1.0,
                        color: AppColors.white,
                      ),
                    ),
                    TextSpan(
                      text: detailedCharacter.gender,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                        height: 2.0,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Origin:\n',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        fontSize: 12.5,
                        height: 1.0,
                        color: AppColors.white,
                      ),
                    ),
                    TextSpan(
                      text: detailedCharacter.origin.name,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                        height: 2.0,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Last known location:\n',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w100,
                        fontSize: 12.5,
                        height: 1.0,
                        color: AppColors.white,
                      ),
                    ),
                    TextSpan(
                      text: detailedCharacter.location.name,
                      style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                        height: 2.0,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15, width: 104),

              FutureBuilder<String>(
                future: detailedCharacter.getFirstSeenIn(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        fontSize: 12.5,
                        height: 1.0,
                        color: AppColors.white,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      'Error loading episode',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w300,
                        fontSize: 12.5,
                        height: 1.0,
                        color: AppColors.white,
                      ),
                    );
                  } else {
                    final firstSeenInName = snapshot.data ?? 'Unknown';
                    return Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'First seen in:\n',
                            style: TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w300,
                              fontSize: 12.5,
                              height: 1.0,
                              color: AppColors.white,
                            ),
                          ),
                          TextSpan(
                            text: firstSeenInName,
                            style: const TextStyle(
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.5,
                              height: 2.0,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
