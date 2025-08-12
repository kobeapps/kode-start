// lib/presentation/screens/locations_screen.dart

import 'package:flutter/material.dart';
import '../../data/models/location_model.dart';
import '../../data/services/location_service.dart';
import '../widgets/location_card.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final LocationService _locationService = LocationService();
  final ScrollController _scrollController = ScrollController();
  List<Location> _locations = [];
  int _currentPage = 1;
  bool _isInitialLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchInitialLocations();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_isLoadingMore &&
        _hasMore) {
      _fetchMoreLocations();
    }
  }

  Future<void> _fetchInitialLocations() async {
    setState(() => _isInitialLoading = true);
    try {
      final newLocations = await _locationService.getLocations(page: 1);
      setState(() {
        _locations = newLocations;
        _currentPage = 1;
        _hasMore = newLocations.isNotEmpty;
      });
    } finally {
      setState(() => _isInitialLoading = false);
    }
  }

  Future<void> _fetchMoreLocations() async {
    setState(() => _isLoadingMore = true);
    try {
      _currentPage++;
      final newLocations = await _locationService.getLocations(page: _currentPage);
      if (newLocations.isEmpty) {
        setState(() => _hasMore = false);
      } else {
        setState(() => _locations.addAll(newLocations));
      }
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // O método build agora retorna apenas a lista, sem Scaffold.
  @override
  Widget build(BuildContext context) {
    if (_isInitialLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_locations.isEmpty) {
      return const Center(child: Text('Nenhum lugar encontrado.'));
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: _locations.length + (_isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _locations.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
        return LocationCard(location: _locations[index]);
      },
    );
  }
}
