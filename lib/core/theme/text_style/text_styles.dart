import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_catalog_project/core/theme/colors/project_colors.dart';

class TextStyles {
  static TextStyle semiBoldHeader(BuildContext context) {
    return GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ProjectColors.darkPurpleText.withValues(alpha: 0.6));
  }

  static TextStyle semiBoldTextFieldLabel(BuildContext context) {
    return GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ProjectColors.darkPurpleText);
  }

  static TextStyle bold20Header(BuildContext context) {
    return GoogleFonts.manrope(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: ProjectColors.darkPurpleText);
  }

  static TextStyle bold12Header(BuildContext context) {
    return GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: ProjectColors.purpleTextButton);
  }

  static TextStyle regular16Hint40Opacity(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: ProjectColors.darkPurpleText.withValues(alpha: 0.4),
    );
  }

  static TextStyle textButton16SemiBold(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: ProjectColors.purpleTextButton,
    );
  }

  static TextStyle textButton12SemiBold(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: ProjectColors.orangeTextButton,
    );
  }

  static TextStyle textButton12Bold(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: ProjectColors.purpleTextButton,
    );
  }

  static TextStyle priceStyle(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: ProjectColors.priceText,
    );
  }

  static TextStyle authorStyle(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: ProjectColors.authorPurpleText.withValues(alpha: 0.6),
    );
  }

  static TextStyle bookTitle12SemiBold(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: ProjectColors.darkPurpleText,
    );
  }

  static TextStyle selectedFilterStyle(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: ProjectColors.darkPurpleText,
    );
  }

  static TextStyle filterStyle(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ProjectColors.darkPurpleText.withValues(alpha: 0.4),
    );
  }

  static TextStyle searchStyle(BuildContext context) {
    return GoogleFonts.manrope(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ProjectColors.darkPurpleText.withValues(alpha: 0.4),
    );
  }
}
