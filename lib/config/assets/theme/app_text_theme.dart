import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Class to define the text theme of the app
class AppTextTheme {
  AppTextTheme._();

  /// Text theme
  static TextTheme getTextTheme(Contrast mode, Brightness brightness) {
    const baseTextTheme = TextTheme(
      /// Display styles are reserved for short, important text or numerals. 
      /// They work best on large screens.
      displayLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 57,
        letterSpacing: 0.2,
        height: 2,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 45,
        letterSpacing: 0.1,
        height: 2,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 36,
        letterSpacing: 0,
        height: 2,
      ),

      /// Headlines are best-suited for short, 
      /// high-emphasis text on smaller screens.
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 32,
        letterSpacing: 1,
        height: 2,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 28,
        letterSpacing: 0.8,
        height: 2,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 24,
        letterSpacing: 0.6,
        height: 2,
      ),

      /// Titles are smaller than headline styles, and should be used for 
      /// medium-emphasis text that remains relatively short.
      titleLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 22,
        letterSpacing: -0.2,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: -0.1,
        height: 1.4,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        letterSpacing: 0,
        height: 1.3,
      ),

      /// Body styles are used for longer passages of text in your app.
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.25,
        height: 1.4,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.4,
        height: 1.3,
      ),

      // Label styles are smaller, utilitarian styles, used for 
      //things like the text inside components.
      labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.1,
        height: 1.25,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.2,
        height: 1.25,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 11,
        letterSpacing: 0.2,
        height: 1.25,
      ),
    );

    final primaryTheme = GoogleFonts.getTextTheme('Roboto', baseTextTheme);
    final secondaryTheme =
        GoogleFonts.getTextTheme('Roboto Condensed', baseTextTheme);
    final tertiaryTheme = GoogleFonts.getTextTheme('Pacifico', baseTextTheme);

    final textTheme = baseTextTheme.copyWith(
      // Large text
      displayLarge: tertiaryTheme.displayLarge,
      displayMedium: tertiaryTheme.displayMedium,
      displaySmall: tertiaryTheme.displaySmall,
      // Headers
      headlineLarge: tertiaryTheme.headlineLarge,
      headlineMedium: tertiaryTheme.headlineMedium,
      headlineSmall: tertiaryTheme.headlineSmall,
      // title or labels
      titleLarge: secondaryTheme.titleLarge,
      titleMedium: secondaryTheme.titleMedium,
      titleSmall: secondaryTheme.titleSmall,
      // Paragraphs
      bodyLarge: primaryTheme.bodyLarge,
      bodyMedium: primaryTheme.bodyMedium,
      bodySmall: primaryTheme.bodySmall,
      // Tags, Buttons, hints
      labelLarge: primaryTheme.labelLarge,
      labelMedium: primaryTheme.labelMedium,
      labelSmall: primaryTheme.labelSmall,
    );

    return textTheme;
  }
}
