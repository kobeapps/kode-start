import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty_app/core/theme/app_colors.dart';

class AppTextStyle {
  static TextStyle appBarTitle = GoogleFonts.lato(
    fontWeight: FontWeight.w400,
    fontSize: 14.5,
    letterSpacing: 0.165 * 14.5,
    color: AppColors.text,
  );

  static TextStyle characterName = GoogleFonts.lato(
    fontWeight: FontWeight.w900,
    fontSize: 14.5,
    color: AppColors.text,
  );

  static TextStyle characterInfo = GoogleFonts.lato(
    fontWeight: FontWeight.w500,
    fontSize: 12.5,
    color: AppColors.text,
  );

  static TextStyle textCard = GoogleFonts.lato(
    fontWeight: FontWeight.w300,
    fontSize: 12.5,
    color: AppColors.text,
  );
}
