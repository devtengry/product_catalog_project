import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_catalog_project/core/theme/project_colors.dart';

class AppTheme {
  // InputDecoration Theme
  static InputDecoration textFieldDecoration(
      BuildContext context, String hintTextString) {
    return InputDecoration(
      filled: true,
      fillColor: kTextFieldBackground,
      hintText: hintTextString,
      hintStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontSize: min(16.sp, 16),
            fontWeight: FontWeight.w700,
            color: kDarkPurpleText.withValues(alpha: 0.4),
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
          backgroundColor: kWhiteBackground,
          surfaceTintColor: kWhiteBackground,
        ),

        // Text Theme
        textTheme: TextTheme(
          titleSmall: GoogleFonts.manrope(color: kDarkPurpleText),
          titleMedium: GoogleFonts.manrope(color: kDarkPurpleText),
          titleLarge: GoogleFonts.manrope(color: kDarkPurpleText),
          bodySmall: GoogleFonts.manrope(color: kDarkPurpleText),
          bodyMedium: GoogleFonts.manrope(color: kDarkPurpleText),
          bodyLarge: GoogleFonts.manrope(color: kDarkPurpleText),
          displaySmall: GoogleFonts.manrope(color: kPurpleTextButton),
          displayMedium: GoogleFonts.manrope(color: kPurpleTextButton),
          displayLarge: GoogleFonts.manrope(color: kPurpleTextButton),
          headlineSmall: GoogleFonts.manrope(color: kOrangeTextButton),
          headlineMedium: GoogleFonts.manrope(color: kOrangeTextButton),
          headlineLarge: GoogleFonts.manrope(color: kOrangeTextButton),
          labelSmall: GoogleFonts.manrope(color: kPriceText),
          labelMedium: GoogleFonts.manrope(color: kPriceText),
          labelLarge: GoogleFonts.manrope(color: kPriceText),
        ),

        // Card Theme
        cardTheme: CardTheme(
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          color: kCardBackground,
        ),

        // Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(kElevatedButton),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme());
  }
}
