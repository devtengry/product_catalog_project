import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class AppTheme {
  // InputDecotation Theme
  static InputDecoration textFieldDecoration(
      BuildContext context, String hintTextString) {
    return InputDecoration(
      filled: true,
      fillColor: ProjectColors.textFieldBackground,
      hintText: hintTextString,
      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(16.sp, 16),
            fontWeight: FontWeight.w700,
            color: ProjectColors.darkPurpleText.withValues(alpha: 0.4),
          ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: ProjectColors.whiteBackground,
          surfaceTintColor: ProjectColors.whiteBackground,
        ),

        // Text Theme
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

        // Card Theme
        cardTheme: CardTheme(
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: ProjectColors.cardBackground,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(
              ProjectColors.elevatedButton,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme());
  }
}
