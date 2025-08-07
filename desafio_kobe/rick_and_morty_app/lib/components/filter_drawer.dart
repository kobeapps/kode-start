import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/theme/app_colors.dart';

class FilterDrawer extends StatefulWidget {
  final String? initialStatusFilter;
  final String? initialSpeciesFilter;
  final String? initialGenderFilter;
  final Function(String? status, String? species, String? gender)
  onFiltersApplied;

  const FilterDrawer({
    Key? key,
    this.initialStatusFilter,
    this.initialSpeciesFilter,
    this.initialGenderFilter,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  String? _selectedStatus;
  String? _selectedSpecies;
  String? _selectedGender;

  final List<String> _speciesOptions = [
    'Human',
    'Alien',
    'Mythological Creature',
    'Animal',
    'Robot',
    'Cronenberg',
    'Disease',
    'Poopybutthole',
    'Unknown',
  ];

  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Genderless',
    'Unknown',
  ];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.initialStatusFilter;
    _selectedSpecies = widget.initialSpeciesFilter;
    _selectedGender = widget.initialGenderFilter;
  }

  Widget _buildRadioListTile(
    String title,
    String? value,
    String? groupValue,
    ValueChanged<String?> onChanged,
  ) {
    return RadioListTile<String?>(
      title: Text(title, style: TextStyle(color: AppColors.white)),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: AppColors.white,
      tileColor: AppColors.appBarColor,
      selectedTileColor: AppColors.white.withOpacity(0.3),
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            color: AppColors.appBarColor,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 16, top: 40),
            child: Text(
              'Filtros',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ExpansionTile(
                  title: Text(
                    'Status',
                    style: TextStyle(color: AppColors.white),
                  ),
                  collapsedIconColor: AppColors.white,
                  iconColor: AppColors.white,
                  children: <Widget>[
                    _buildRadioListTile('All', null, _selectedStatus, (value) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }),
                    _buildRadioListTile('Alive', 'alive', _selectedStatus, (
                      value,
                    ) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }),
                    _buildRadioListTile('Dead', 'dead', _selectedStatus, (
                      value,
                    ) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }),
                    _buildRadioListTile('Unknown', 'unknown', _selectedStatus, (
                      value,
                    ) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }),
                  ],
                ),
                Divider(color: AppColors.white.withOpacity(0.2)),

                ExpansionTile(
                  title: Text(
                    'Espécie',
                    style: TextStyle(color: AppColors.white),
                  ),
                  collapsedIconColor: AppColors.white,
                  iconColor: AppColors.white,
                  children: <Widget>[
                    _buildRadioListTile('All', null, _selectedSpecies, (value) {
                      setState(() {
                        _selectedSpecies = value;
                      });
                    }),
                    ..._speciesOptions
                        .map(
                          (species) => _buildRadioListTile(
                            species,
                            species.toLowerCase(),
                            _selectedSpecies,
                            (value) {
                              setState(() {
                                _selectedSpecies = value;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ],
                ),
                Divider(color: AppColors.white.withOpacity(0.2)),

                ExpansionTile(
                  title: Text(
                    'Gênero',
                    style: TextStyle(color: AppColors.white),
                  ),
                  collapsedIconColor: AppColors.white,
                  iconColor: AppColors.white,
                  children: <Widget>[
                    _buildRadioListTile('All', null, _selectedGender, (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    }),
                    ..._genderOptions
                        .map(
                          (gender) => _buildRadioListTile(
                            gender,
                            gender.toLowerCase(),
                            _selectedGender,
                            (value) {
                              setState(() {
                                _selectedGender = value;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ],
                ),
                Divider(color: AppColors.white.withOpacity(0.2)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedStatus = null;
                      _selectedSpecies = null;
                      _selectedGender = null;
                    });
                    widget.onFiltersApplied(null, null, null);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.appBarColor,
                    foregroundColor: AppColors.white,
                    overlayColor: AppColors.white.withOpacity(0.1),
                    elevation: 5,
                    shadowColor: AppColors.black,
                  ),
                  child: Text('Limpar Filtros'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onFiltersApplied(
                      _selectedStatus,
                      _selectedSpecies,
                      _selectedGender,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    overlayColor: AppColors.white.withOpacity(0.1),
                    elevation: 5,
                    shadowColor: AppColors.black,
                  ),
                  child: Text('Aplicar Filtros'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
