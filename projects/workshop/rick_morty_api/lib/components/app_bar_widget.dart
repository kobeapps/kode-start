import 'package:flutter/material.dart';
import 'package:rick_morty_api/data/repository.dart'; 
import 'package:rick_morty_api/models/character_list.dart';
import 'package:rick_morty_api/pages/home_page.dart';
import 'package:rick_morty_api/theme/app_images.dart';
import '../theme/app_colors.dart';

class AppBarWidgets extends StatefulWidget implements PreferredSizeWidget {
  final bool isSecondPage;
  final Function(List<Result>)? onResultsChanged; 

  const AppBarWidgets({
    super.key,
    this.isSecondPage = false,
    this.onResultsChanged,
  });

  @override
  State<AppBarWidgets> createState() => _AppBarWidgetsState();

  @override
  Size get preferredSize => const Size.fromHeight(250);
}

class _AppBarWidgetsState extends State<AppBarWidgets> {
  String? selectedGender;
  String searchName = '';
  bool isLoading = false;

  Future<void> _searchCharacters() async {
    setState(() {
      isLoading = true;
    });

    try {
      final results = await Repository.searchCharacters(
        name: searchName,
        gender: selectedGender, 
        page: 1,
      );

      if (widget.onResultsChanged != null) {
        widget.onResultsChanged!(results.results);
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      color: AppColors.appBarColor,
      child: SafeArea(
        child: SizedBox(
          height: 250,
          child: Stack(
            children: [
              Positioned(
                top: 17,
                left: 14,
                right: 14,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          final currentRoute = ModalRoute.of(
                            context,
                          )?.settings.name;
                          if (currentRoute == HomePage.routeId) return;
                          Navigator.pop(context);
                        },
                        child: Icon(
                          widget.isSecondPage ? Icons.arrow_back : Icons.menu,
                          color: AppColors.white,
                        ),
                      ),
                      Icon(Icons.person, color: AppColors.white),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    AppImages.logo,
                    width: 115,
                    height: 77,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                top: 0,
                right: 0,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "RICK AND MORTY API",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: 14.5,
                        letterSpacing: 14.5 * 0.165,
                        height: 1.0,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (!widget.isSecondPage)
                Positioned(
                  top: 130,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Search by name',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                        ),
                        style: TextStyle(fontSize: 16),
                        onChanged: (value) {
                          searchName = value;
                          _searchCharacters();
                        },
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Filter by gender',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 16,
                          ),
                        ),
                        value: selectedGender,
                        items: ['Male', 'Female', 'Genderless', 'unknown']
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                          _searchCharacters();
                        },
                      ),
                      if (isLoading)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
