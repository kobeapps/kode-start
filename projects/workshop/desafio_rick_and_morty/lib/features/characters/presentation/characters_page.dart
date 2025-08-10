import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/error_retry.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/app_bar_custom.dart';
import 'character_card.dart';
import 'characters_controller.dart';

class CharactersPage extends ConsumerStatefulWidget {
  const CharactersPage({super.key});
  @override
  ConsumerState<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends ConsumerState<CharactersPage> {
  final _innerScroll = ScrollController();
  final _nameCtrl = TextEditingController();
  String _status = '';
  String _gender = '';

  @override
  void initState() {
    super.initState();
    _innerScroll.addListener(() {
      if (_innerScroll.position.pixels >
          _innerScroll.position.maxScrollExtent - 200) {
        ref.read(charactersControllerProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _innerScroll.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  void _apply() {
    ref.read(charactersControllerProvider.notifier).applyFilters(
          CharacterQuery(
            name: _nameCtrl.text.trim(),
            status: _status,
            gender: _gender,
          ),
        );
  }

  void _setStatus(String value) {
    setState(() => _status = value.toLowerCase());
    _apply();
  }

  void _setGender(String value) {
    setState(() => _gender = value.toLowerCase());
    _apply();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(charactersControllerProvider);

    return Scaffold(
      appBar: AppBarCustom.homeLarge(
        onMenu: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Menu tapped')),
          );
        },
        onProfile: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile tapped')),
          );
        },
      ),
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: Loading()),
          error: (e, _) => ErrorRetry(
            message: e.toString(),
            onRetry: () {
              ref.read(charactersControllerProvider.notifier).refresh();
            },
          ),
          data: (items) => NestedScrollView(
            controller: _innerScroll,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchFiltersHeaderDelegate(
                  nameController: _nameCtrl,
                  status: _status,
                  gender: _gender,
                  onSubmit: _apply,
                  onSelectStatus: _setStatus,
                  onSelectGender: _setGender,
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  showElevation: innerBoxIsScrolled,
                ),
              ),
            ],
            body: RefreshIndicator(
              onRefresh: () =>
                  ref.read(charactersControllerProvider.notifier).refresh(),
              child: ListView.separated(
                primary: false,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                itemBuilder: (_, i) => CharacterCard(
                  character: items[i],
                  onTap: () =>
                      context.push('/characters/detail/${items[i].id}'),
                ),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: items.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text(label),
          selected: selected,
          onSelected: (_) => onTap(),
        ),
      );
}

class _SearchFiltersHeaderDelegate extends SliverPersistentHeaderDelegate {
  _SearchFiltersHeaderDelegate({
    required this.nameController,
    required this.status,
    required this.gender,
    required this.onSubmit,
    required this.onSelectStatus,
    required this.onSelectGender,
    required this.backgroundColor,
    required this.showElevation,
  });

  final TextEditingController nameController;
  final String status;
  final String gender;
  final VoidCallback onSubmit;
  final ValueChanged<String> onSelectStatus;
  final ValueChanged<String> onSelectGender;
  final Color backgroundColor;
  final bool showElevation;

  static const double _height = 126;

  @override
  double get minExtent => _height;
  @override
  double get maxExtent => _height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: backgroundColor,
      elevation: showElevation ? 2 : 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              controller: nameController,
              onSubmitted: (_) => onSubmit(),
              decoration: InputDecoration(
                hintText: 'Search by name',
                prefixIcon: null,
                suffixIcon: IconButton(
                  onPressed: onSubmit,
                  icon: const Icon(Icons.search, color: Colors.white70),
                  tooltip: 'Search',
                ),
                border: const UnderlineInputBorder(),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                _Choice(
                  label: 'Any status',
                  selected: status.isEmpty,
                  onTap: () => onSelectStatus(''),
                ),
                _Choice(
                  label: 'Alive',
                  selected: status == 'alive',
                  onTap: () => onSelectStatus('alive'),
                ),
                _Choice(
                  label: 'Dead',
                  selected: status == 'dead',
                  onTap: () => onSelectStatus('dead'),
                ),
                _Choice(
                  label: 'Unknown',
                  selected: status == 'unknown',
                  onTap: () => onSelectStatus('unknown'),
                ),
                const SizedBox(width: 12),
                _Choice(
                  label: 'Any gender',
                  selected: gender.isEmpty,
                  onTap: () => onSelectGender(''),
                ),
                _Choice(
                  label: 'Male',
                  selected: gender == 'male',
                  onTap: () => onSelectGender('male'),
                ),
                _Choice(
                  label: 'Female',
                  selected: gender == 'female',
                  onTap: () => onSelectGender('female'),
                ),
                _Choice(
                  label: 'Genderless',
                  selected: gender == 'genderless',
                  onTap: () => onSelectGender('genderless'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SearchFiltersHeaderDelegate oldDelegate) {
    return oldDelegate.nameController != nameController ||
        oldDelegate.status != status ||
        oldDelegate.gender != gender ||
        oldDelegate.showElevation != showElevation ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
