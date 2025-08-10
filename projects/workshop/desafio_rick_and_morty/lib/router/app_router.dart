import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/characters/presentation/characters_page.dart';
import '../features/characters/presentation/character_detail_page.dart';
import '../features/episodes/presentation/episodes_page.dart';
import '../features/episodes/presentation/episode_detail_page.dart';
import '../features/locations/presentation/locations_page.dart';
import '../features/locations/presentation/location_detail_page.dart';

final appRouter = GoRouter(
  initialLocation: '/characters',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, nav) => Scaffold(
        body: nav,
        bottomNavigationBar: NavigationBar(
          selectedIndex: nav.currentIndex,
          onDestinationSelected: nav.goBranch,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.people_alt_outlined), label: 'Characters'),
            NavigationDestination(
                icon: Icon(Icons.place_outlined), label: 'Locations'),
            NavigationDestination(
                icon: Icon(Icons.tv_outlined), label: 'Episodes'),
          ],
        ),
      ),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/characters',
            builder: (_, __) => const CharactersPage(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'character-detail',
                builder: (_, s) =>
                    CharacterDetailPage(id: int.parse(s.pathParameters['id']!)),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/locations',
            builder: (_, __) => const LocationsPage(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'location-detail',
                builder: (_, s) =>
                    LocationDetailPage(id: int.parse(s.pathParameters['id']!)),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/episodes',
            builder: (_, __) => const EpisodesPage(),
            routes: [
              GoRoute(
                path: 'detail/:id',
                name: 'episode-detail',
                builder: (_, s) =>
                    EpisodeDetailPage(id: int.parse(s.pathParameters['id']!)),
              ),
            ],
          ),
        ]),
      ],
    ),
  ],
);
