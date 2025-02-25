import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      textTheme: TextTheme(
        titleSmall: GoogleFonts.manrope(color: ProjectColors.darkPurpleText),
        titleMedium: GoogleFonts.manrope(color: ProjectColors.darkPurpleText),
        titleLarge: GoogleFonts.manrope(color: ProjectColors.darkPurpleText),
        bodySmall: GoogleFonts.manrope(color: ProjectColors.darkPurpleText),
        bodyMedium: GoogleFonts.manrope(color: ProjectColors.darkPurpleText),
        bodyLarge: GoogleFonts.manrope(color: ProjectColors.darkPurpleText),
        displaySmall:
            GoogleFonts.manrope(color: ProjectColors.purpleTextButton),
        displayMedium:
            GoogleFonts.manrope(color: ProjectColors.purpleTextButton),
        displayLarge:
            GoogleFonts.manrope(color: ProjectColors.purpleTextButton),
        headlineSmall:
            GoogleFonts.manrope(color: ProjectColors.orangeTextButton),
        headlineMedium:
            GoogleFonts.manrope(color: ProjectColors.orangeTextButton),
        headlineLarge:
            GoogleFonts.manrope(color: ProjectColors.orangeTextButton),
        labelSmall: GoogleFonts.manrope(color: ProjectColors.priceText),
        labelMedium: GoogleFonts.manrope(color: ProjectColors.priceText),
        labelLarge: GoogleFonts.manrope(color: ProjectColors.priceText),
      ),
    );
  }
}
