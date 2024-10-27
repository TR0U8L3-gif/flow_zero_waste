// ignore_for_file: public_member_api_docs

import 'dart:ui';

import 'package:flow_zero_waste/core/enums/contrast_enum.dart';
import 'package:flow_zero_waste/core/extensions/theme_extension.dart';

/// Class to define the colors of the app
class AppColors {
  AppColors._();
  
  
  static Color primary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? primaryStandardLight : primaryStandardDark;
      case Contrast.medium:
        return brightness.isLight ? primaryMediumLight : primaryMediumDark;
      case Contrast.high:
        return brightness.isLight ? primaryHighLight : primaryHighDark;
    }
  }

  static Color surfaceTint(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceTintStandardLight
            : surfaceTintStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceTintMediumLight
            : surfaceTintMediumDark;
      case Contrast.high:
        return brightness.isLight ? surfaceTintHighLight : surfaceTintHighDark;
    }
  }

  static Color onPrimary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onPrimaryStandardLight
            : onPrimaryStandardDark;
      case Contrast.medium:
        return brightness.isLight ? onPrimaryMediumLight : onPrimaryMediumDark;
      case Contrast.high:
        return brightness.isLight ? onPrimaryHighLight : onPrimaryHighDark;
    }
  }

  static Color primaryContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? primaryContainerStandardLight
            : primaryContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? primaryContainerMediumLight
            : primaryContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? primaryContainerHighLight
            : primaryContainerHighDark;
    }
  }

  static Color onPrimaryContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onPrimaryContainerStandardLight
            : onPrimaryContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onPrimaryContainerMediumLight
            : onPrimaryContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onPrimaryContainerHighLight
            : onPrimaryContainerHighDark;
    }
  }

  static Color secondary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? secondaryStandardLight
            : secondaryStandardDark;
      case Contrast.medium:
        return brightness.isLight ? secondaryMediumLight : secondaryMediumDark;
      case Contrast.high:
        return brightness.isLight ? secondaryHighLight : secondaryHighDark;
    }
  }

  static Color onSecondary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onSecondaryStandardLight
            : onSecondaryStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onSecondaryMediumLight
            : onSecondaryMediumDark;
      case Contrast.high:
        return brightness.isLight ? onSecondaryHighLight : onSecondaryHighDark;
    }
  }

  static Color secondaryContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? secondaryContainerStandardLight
            : secondaryContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? secondaryContainerMediumLight
            : secondaryContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? secondaryContainerHighLight
            : secondaryContainerHighDark;
    }
  }

  static Color onSecondaryContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onSecondaryContainerStandardLight
            : onSecondaryContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onSecondaryContainerMediumLight
            : onSecondaryContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onSecondaryContainerHighLight
            : onSecondaryContainerHighDark;
    }
  }

  static Color tertiary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? tertiaryStandardLight
            : tertiaryStandardDark;
      case Contrast.medium:
        return brightness.isLight ? tertiaryMediumLight : tertiaryMediumDark;
      case Contrast.high:
        return brightness.isLight ? tertiaryHighLight : tertiaryHighDark;
    }
  }

  static Color onTertiary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onTertiaryStandardLight
            : onTertiaryStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onTertiaryMediumLight
            : onTertiaryMediumDark;
      case Contrast.high:
        return brightness.isLight ? onTertiaryHighLight : onTertiaryHighDark;
    }
  }

  static Color tertiaryContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? tertiaryContainerStandardLight
            : tertiaryContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? tertiaryContainerMediumLight
            : tertiaryContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? tertiaryContainerHighLight
            : tertiaryContainerHighDark;
    }
  }

  static Color onTertiaryContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onTertiaryContainerStandardLight
            : onTertiaryContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onTertiaryContainerMediumLight
            : onTertiaryContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onTertiaryContainerHighLight
            : onTertiaryContainerHighDark;
    }
  }

  static Color error(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? errorStandardLight : errorStandardDark;
      case Contrast.medium:
        return brightness.isLight ? errorMediumLight : errorMediumDark;
      case Contrast.high:
        return brightness.isLight ? errorHighLight : errorHighDark;
    }
  }

  static Color onError(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? onErrorStandardLight : onErrorStandardDark;
      case Contrast.medium:
        return brightness.isLight ? onErrorMediumLight : onErrorMediumDark;
      case Contrast.high:
        return brightness.isLight ? onErrorHighLight : onErrorHighDark;
    }
  }

  static Color errorContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? errorContainerStandardLight
            : errorContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? errorContainerMediumLight
            : errorContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? errorContainerHighLight
            : errorContainerHighDark;
    }
  }

  static Color onErrorContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onErrorContainerStandardLight
            : onErrorContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onErrorContainerMediumLight
            : onErrorContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onErrorContainerHighLight
            : onErrorContainerHighDark;
    }
  }

  static Color surface(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? surfaceStandardLight : surfaceStandardDark;
      case Contrast.medium:
        return brightness.isLight ? surfaceMediumLight : surfaceMediumDark;
      case Contrast.high:
        return brightness.isLight ? surfaceHighLight : surfaceHighDark;
    }
  }

  static Color onSurface(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onSurfaceStandardLight
            : onSurfaceStandardDark;
      case Contrast.medium:
        return brightness.isLight ? onSurfaceMediumLight : onSurfaceMediumDark;
      case Contrast.high:
        return brightness.isLight ? onSurfaceHighLight : onSurfaceHighDark;
    }
  }

  static Color onSurfaceVariant(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onSurfaceVariantStandardLight
            : onSurfaceVariantStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onSurfaceVariantMediumLight
            : onSurfaceVariantMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onSurfaceVariantHighLight
            : onSurfaceVariantHighDark;
    }
  }

  static Color outline(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? outlineStandardLight : outlineStandardDark;
      case Contrast.medium:
        return brightness.isLight ? outlineMediumLight : outlineMediumDark;
      case Contrast.high:
        return brightness.isLight ? outlineHighLight : outlineHighDark;
    }
  }

  static Color outlineVariant(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? outlineVariantStandardLight
            : outlineVariantStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? outlineVariantMediumLight
            : outlineVariantMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? outlineVariantHighLight
            : outlineVariantHighDark;
    }
  }

  static Color shadow(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? shadowStandardLight : shadowStandardDark;
      case Contrast.medium:
        return brightness.isLight ? shadowMediumLight : shadowMediumDark;
      case Contrast.high:
        return brightness.isLight ? shadowHighLight : shadowHighDark;
    }
  }

  static Color scrim(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight ? scrimStandardLight : scrimStandardDark;
      case Contrast.medium:
        return brightness.isLight ? scrimMediumLight : scrimMediumDark;
      case Contrast.high:
        return brightness.isLight ? scrimHighLight : scrimHighDark;
    }
  }

  static Color inverseSurface(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? inverseSurfaceStandardLight
            : inverseSurfaceStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? inverseSurfaceMediumLight
            : inverseSurfaceMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? inverseSurfaceHighLight
            : inverseSurfaceHighDark;
    }
  }

  static Color inversePrimary(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? inversePrimaryStandardLight
            : inversePrimaryStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? inversePrimaryMediumLight
            : inversePrimaryMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? inversePrimaryHighLight
            : inversePrimaryHighDark;
    }
  }

  static Color primaryFixed(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? primaryFixedStandardLight
            : primaryFixedStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? primaryFixedMediumLight
            : primaryFixedMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? primaryFixedHighLight
            : primaryFixedHighDark;
    }
  }

  static Color onPrimaryFixed(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onPrimaryFixedStandardLight
            : onPrimaryFixedStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onPrimaryFixedMediumLight
            : onPrimaryFixedMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onPrimaryFixedHighLight
            : onPrimaryFixedHighDark;
    }
  }

  static Color primaryFixedDim(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? primaryFixedDimStandardLight
            : primaryFixedDimStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? primaryFixedDimMediumLight
            : primaryFixedDimMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? primaryFixedDimHighLight
            : primaryFixedDimHighDark;
    }
  }

  static Color onPrimaryFixedVariant(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onPrimaryFixedVariantStandardLight
            : onPrimaryFixedVariantStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onPrimaryFixedVariantMediumLight
            : onPrimaryFixedVariantMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onPrimaryFixedVariantHighLight
            : onPrimaryFixedVariantHighDark;
    }
  }

  static Color secondaryFixed(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? secondaryFixedStandardLight
            : secondaryFixedStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? secondaryFixedMediumLight
            : secondaryFixedMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? secondaryFixedHighLight
            : secondaryFixedHighDark;
    }
  }

  static Color onSecondaryFixed(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onSecondaryFixedStandardLight
            : onSecondaryFixedStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onSecondaryFixedMediumLight
            : onSecondaryFixedMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onSecondaryFixedHighLight
            : onSecondaryFixedHighDark;
    }
  }

  static Color secondaryFixedDim(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? secondaryFixedDimStandardLight
            : secondaryFixedDimStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? secondaryFixedDimMediumLight
            : secondaryFixedDimMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? secondaryFixedDimHighLight
            : secondaryFixedDimHighDark;
    }
  }

  static Color onSecondaryFixedVariant(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onSecondaryFixedVariantStandardLight
            : onSecondaryFixedVariantStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onSecondaryFixedVariantMediumLight
            : onSecondaryFixedVariantMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onSecondaryFixedVariantHighLight
            : onSecondaryFixedVariantHighDark;
    }
  }

  static Color tertiaryFixed(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? tertiaryFixedStandardLight
            : tertiaryFixedStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? tertiaryFixedMediumLight
            : tertiaryFixedMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? tertiaryFixedHighLight
            : tertiaryFixedHighDark;
    }
  }

  static Color onTertiaryFixed(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onTertiaryFixedStandardLight
            : onTertiaryFixedStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onTertiaryFixedMediumLight
            : onTertiaryFixedMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onTertiaryFixedHighLight
            : onTertiaryFixedHighDark;
    }
  }

  static Color tertiaryFixedDim(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? tertiaryFixedDimStandardLight
            : tertiaryFixedDimStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? tertiaryFixedDimMediumLight
            : tertiaryFixedDimMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? tertiaryFixedDimHighLight
            : tertiaryFixedDimHighDark;
    }
  }

  static Color onTertiaryFixedVariant(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? onTertiaryFixedVariantStandardLight
            : onTertiaryFixedVariantStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? onTertiaryFixedVariantMediumLight
            : onTertiaryFixedVariantMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? onTertiaryFixedVariantHighLight
            : onTertiaryFixedVariantHighDark;
    }
  }

  static Color surfaceDim(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceDimStandardLight
            : surfaceDimStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceDimMediumLight
            : surfaceDimMediumDark;
      case Contrast.high:
        return brightness.isLight ? surfaceDimHighLight : surfaceDimHighDark;
    }
  }

  static Color surfaceBright(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceBrightStandardLight
            : surfaceBrightStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceBrightMediumLight
            : surfaceBrightMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? surfaceBrightHighLight
            : surfaceBrightHighDark;
    }
  }

  static Color surfaceContainerLowest(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceContainerLowestStandardLight
            : surfaceContainerLowestStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceContainerLowestMediumLight
            : surfaceContainerLowestMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? surfaceContainerLowestHighLight
            : surfaceContainerLowestHighDark;
    }
  }

  static Color surfaceContainerLow(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceContainerLowStandardLight
            : surfaceContainerLowStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceContainerLowMediumLight
            : surfaceContainerLowMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? surfaceContainerLowHighLight
            : surfaceContainerLowHighDark;
    }
  }

  static Color surfaceContainer(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceContainerStandardLight
            : surfaceContainerStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceContainerMediumLight
            : surfaceContainerMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? surfaceContainerHighLight
            : surfaceContainerHighDark;
    }
  }

  static Color surfaceContainerHigh(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceContainerHighStandardLight
            : surfaceContainerHighStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceContainerHighMediumLight
            : surfaceContainerHighMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? surfaceContainerHighHighLight
            : surfaceContainerHighHighDark;
    }
  }

  static Color surfaceContainerHighest(Contrast mode, Brightness brightness) {
    switch (mode) {
      case Contrast.standard:
        return brightness.isLight
            ? surfaceContainerHighestStandardLight
            : surfaceContainerHighestStandardDark;
      case Contrast.medium:
        return brightness.isLight
            ? surfaceContainerHighestMediumLight
            : surfaceContainerHighestMediumDark;
      case Contrast.high:
        return brightness.isLight
            ? surfaceContainerHighestHighLight
            : surfaceContainerHighestHighDark;
    }
  }

  // contrast mode: standard, brightness: light
  static const primaryStandardLight = greenForest;
  static const surfaceTintStandardLight = greenForest;
  static const onPrimaryStandardLight = grayWhite;
  static const primaryContainerStandardLight = greenMint;
  static const onPrimaryContainerStandardLight = greenDeepForest;
  static const secondaryStandardLight = greenAccent;
  static const onSecondaryStandardLight = grayWhite;
  static const secondaryContainerStandardLight = greenLight;
  static const onSecondaryContainerStandardLight = greenBlack;
  static const tertiaryStandardLight = blueCadet;
  static const onTertiaryStandardLight = grayWhite;
  static const tertiaryContainerStandardLight = bluePastel;
  static const onTertiaryContainerStandardLight = blueDeepDark;
  static const errorStandardLight = redDeep;
  static const onErrorStandardLight = grayWhite;
  static const errorContainerStandardLight = redVeryLight;
  static const onErrorContainerStandardLight = redBurgundy;
  static const surfaceStandardLight = grayLightPale;
  static const onSurfaceStandardLight = grayDarker;
  static const onSurfaceVariantStandardLight = grayDarkDusty;
  static const outlineStandardLight = grayDarkSoft;
  static const outlineVariantStandardLight = greenAccentVeryLight;
  static const shadowStandardLight = grayBlack;
  static const scrimStandardLight = grayBlack;
  static const inverseSurfaceStandardLight = grayDeep;
  static const inversePrimaryStandardLight = greenSea;
  static const primaryFixedStandardLight = greenMint;
  static const onPrimaryFixedStandardLight = greenDeepForest;
  static const primaryFixedDimStandardLight = greenSea;
  static const onPrimaryFixedVariantStandardLight = greenDeepDark;
  static const secondaryFixedStandardLight = greenLight;
  static const onSecondaryFixedStandardLight = greenBlack;
  static const secondaryFixedDimStandardLight = greenAccentGray;
  static const onSecondaryFixedVariantStandardLight = greenAccentDeepForest;
  static const tertiaryFixedStandardLight = bluePastel;
  static const onTertiaryFixedStandardLight = blueDeepDark;
  static const tertiaryFixedDimStandardLight = blueSoft;
  static const onTertiaryFixedVariantStandardLight = blueSteel;
  static const surfaceDimStandardLight = graySoft;
  static const surfaceBrightStandardLight = grayLightPale;
  static const surfaceContainerLowestStandardLight = grayWhite;
  static const surfaceContainerLowStandardLight = graySoftMuted;
  static const surfaceContainerStandardLight = graySoftDusty;
  static const surfaceContainerHighStandardLight = grayBright;
  static const surfaceContainerHighestStandardLight = grayPale;

  // contrast mode: medium, brightness: light
  static const primaryMediumLight = greenDarkForest;
  static const surfaceTintMediumLight = greenForest;
  static const onPrimaryMediumLight = grayWhite;
  static const primaryContainerMediumLight = greenSlate;
  static const onPrimaryContainerMediumLight = grayWhite;
  static const secondaryMediumLight = greenAccentTeal;
  static const onSecondaryMediumLight = grayWhite;
  static const secondaryContainerMediumLight = greenAccentMisty;
  static const onSecondaryContainerMediumLight = grayWhite;
  static const tertiaryMediumLight = blueSteelDark;
  static const onTertiaryMediumLight = grayWhite;
  static const tertiaryContainerMediumLight = blueSlate;
  static const onTertiaryContainerMediumLight = grayWhite;
  static const errorMediumLight = redDarkCrimson;
  static const onErrorMediumLight = grayWhite;
  static const errorContainerMediumLight = redBright;
  static const onErrorContainerMediumLight = grayWhite;
  static const surfaceMediumLight = grayLightPale;
  static const onSurfaceMediumLight = grayDarker;
  static const onSurfaceVariantMediumLight = grayDarkShade;
  static const outlineMediumLight = grayDarkMuted;
  static const outlineVariantMediumLight = grayMisty;
  static const shadowMediumLight = grayBlack;
  static const scrimMediumLight = grayBlack;
  static const inverseSurfaceMediumLight = grayDeep;
  static const inversePrimaryMediumLight = greenSea;
  static const primaryFixedMediumLight = greenSlate;
  static const onPrimaryFixedMediumLight = grayWhite;
  static const primaryFixedDimMediumLight = greenDeep;
  static const onPrimaryFixedVariantMediumLight = grayWhite;
  static const secondaryFixedMediumLight = greenAccentMisty;
  static const onSecondaryFixedMediumLight = grayWhite;
  static const secondaryFixedDimMediumLight = greenAccentForest;
  static const onSecondaryFixedVariantMediumLight = grayWhite;
  static const tertiaryFixedMediumLight = blueSlate;
  static const onTertiaryFixedMediumLight = grayWhite;
  static const tertiaryFixedDimMediumLight = blueSkyDark;
  static const onTertiaryFixedVariantMediumLight = grayWhite;
  static const surfaceDimMediumLight = graySoft;
  static const surfaceBrightMediumLight = grayLightPale;
  static const surfaceContainerLowestMediumLight = grayWhite;
  static const surfaceContainerLowMediumLight = graySoftMuted;
  static const surfaceContainerMediumLight = graySoftDusty;
  static const surfaceContainerHighMediumLight = grayBright;
  static const surfaceContainerHighestMediumLight = grayPale;

  // contrast mode: high, brightness: light
  static const primaryHighLight = greenMidnight;
  static const surfaceTintHighLight = greenForest;
  static const onPrimaryHighLight = grayWhite;
  static const primaryContainerHighLight = greenDarkForest;
  static const onPrimaryContainerHighLight = grayWhite;
  static const secondaryHighLight = greenDeepCadet;
  static const onSecondaryHighLight = grayWhite;
  static const secondaryContainerHighLight = greenAccentTeal;
  static const onSecondaryContainerHighLight = grayWhite;
  static const tertiaryHighLight = blueDeep;
  static const onTertiaryHighLight = grayWhite;
  static const tertiaryContainerHighLight = blueSteelDark;
  static const onTertiaryContainerHighLight = grayWhite;
  static const errorHighLight = redMaroon;
  static const onErrorHighLight = grayWhite;
  static const errorContainerHighLight = redDarkCrimson;
  static const onErrorContainerHighLight = grayWhite;
  static const surfaceHighLight = grayLightPale;
  static const onSurfaceHighLight = grayBlack;
  static const onSurfaceVariantHighLight = grayDeepMuted;
  static const outlineHighLight = grayDarkShade;
  static const outlineVariantHighLight = grayDarkShade;
  static const shadowHighLight = grayBlack;
  static const scrimHighLight = grayBlack;
  static const inverseSurfaceHighLight = grayDeep;
  static const inversePrimaryHighLight = greenLightMint;
  static const primaryFixedHighLight = greenDarkForest;
  static const onPrimaryFixedHighLight = grayWhite;
  static const primaryFixedDimHighLight = greenCadet;
  static const onPrimaryFixedVariantHighLight = grayWhite;
  static const secondaryFixedHighLight = greenAccentTeal;
  static const onSecondaryFixedHighLight = grayWhite;
  static const secondaryFixedDimHighLight = greenAccentDeepDark;
  static const onSecondaryFixedVariantHighLight = grayWhite;
  static const tertiaryFixedHighLight = blueSteelDark;
  static const onTertiaryFixedHighLight = grayWhite;
  static const tertiaryFixedDimHighLight = blueMidnight;
  static const onTertiaryFixedVariantHighLight = grayWhite;
  static const surfaceDimHighLight = graySoft;
  static const surfaceBrightHighLight = grayLightPale;
  static const surfaceContainerLowestHighLight = grayWhite;
  static const surfaceContainerLowHighLight = graySoftMuted;
  static const surfaceContainerHighLight = graySoftDusty;
  static const surfaceContainerHighHighLight = grayBright;
  static const surfaceContainerHighestHighLight = grayPale;

  // contrast mode: standard, brightness: dark
  static const primaryStandardDark = greenSea;
  static const surfaceTintStandardDark = greenSea;
  static const onPrimaryStandardDark = greenDarkTeal;
  static const primaryContainerStandardDark = greenDeepDark;
  static const onPrimaryContainerStandardDark = greenMint;
  static const secondaryStandardDark = greenAccentGray;
  static const onSecondaryStandardDark = greenAccentDark;
  static const secondaryContainerStandardDark = greenAccentDeepForest;
  static const onSecondaryContainerStandardDark = greenLight;
  static const tertiaryStandardDark = blueSoft;
  static const onTertiaryStandardDark = blueMidnightLight;
  static const tertiaryContainerStandardDark = blueSteel;
  static const onTertiaryContainerStandardDark = bluePastel;
  static const errorStandardDark = redLight;
  static const onErrorStandardDark = redWine;
  static const errorContainerStandardDark = redDark;
  static const onErrorContainerStandardDark = redVeryLight;
  static const surfaceStandardDark = grayDarkest;
  static const onSurfaceStandardDark = grayPale;
  static const onSurfaceVariantStandardDark = greenAccentVeryLight;
  static const outlineStandardDark = graySlateLight;
  static const outlineVariantStandardDark = grayDarkDusty;
  static const shadowStandardDark = grayBlack;
  static const scrimStandardDark = grayBlack;
  static const inverseSurfaceStandardDark = grayPale;
  static const inversePrimaryStandardDark = greenForest;
  static const primaryFixedStandardDark = greenMint;
  static const onPrimaryFixedStandardDark = greenDeepForest;
  static const primaryFixedDimStandardDark = greenSea;
  static const onPrimaryFixedVariantStandardDark = greenDeepDark;
  static const secondaryFixedStandardDark = greenLight;
  static const onSecondaryFixedStandardDark = greenBlack;
  static const secondaryFixedDimStandardDark = greenAccentGray;
  static const onSecondaryFixedVariantStandardDark = greenAccentDeepForest;
  static const tertiaryFixedStandardDark = bluePastel;
  static const onTertiaryFixedStandardDark = blueDeepDark;
  static const tertiaryFixedDimStandardDark = blueSoft;
  static const onTertiaryFixedVariantStandardDark = blueSteel;
  static const surfaceDimStandardDark = grayDarkest;
  static const surfaceBrightStandardDark = grayDark;
  static const surfaceContainerLowestStandardDark = grayMoss;
  static const surfaceContainerLowStandardDark = grayDarker;
  static const surfaceContainerStandardDark = grayDeepShadow;
  static const surfaceContainerHighStandardDark = grayDeepShade;
  static const surfaceContainerHighestStandardDark = grayShadow;

  // contrast mode: medium, brightness: dark
  static const primaryMediumDark = greenTeal;
  static const surfaceTintMediumDark = greenSea;
  static const onPrimaryMediumDark = greenDeepMidnight;
  static const primaryContainerMediumDark = greenEmerald;
  static const onPrimaryContainerMediumDark = grayBlack;
  static const secondaryMediumDark = greenAccentLight;
  static const onSecondaryMediumDark = greenDark;
  static const secondaryContainerMediumDark = grayAccentPale;
  static const onSecondaryContainerMediumDark = grayBlack;
  static const tertiaryMediumDark = blueLightSteel;
  static const onTertiaryMediumDark = blueTwilight;
  static const tertiaryContainerMediumDark = blueMisty;
  static const onTertiaryContainerMediumDark = grayBlack;
  static const errorMediumDark = redPastel;
  static const onErrorMediumDark = redAuburn;
  static const errorContainerMediumDark = redSoft;
  static const onErrorContainerMediumDark = grayBlack;
  static const surfaceMediumDark = grayDarkest;
  static const onSurfaceMediumDark = grayLightSoft;
  static const onSurfaceVariantMediumDark = grayMuted;
  static const outlineMediumDark = graySlate;
  static const outlineVariantMediumDark = graySlateDark;
  static const shadowMediumDark = grayBlack;
  static const scrimMediumDark = grayBlack;
  static const inverseSurfaceMediumDark = grayPale;
  static const inversePrimaryMediumDark = greenSoftDark;
  static const primaryFixedMediumDark = greenMint;
  static const onPrimaryFixedMediumDark = grayDeepDark;
  static const primaryFixedDimMediumDark = greenSea;
  static const onPrimaryFixedVariantMediumDark = greenDarkEmerald;
  static const secondaryFixedMediumDark = greenLight;
  static const onSecondaryFixedMediumDark = grayDeepDark;
  static const secondaryFixedDimMediumDark = greenAccentGray;
  static const onSecondaryFixedVariantMediumDark = grayAccentMidnight;
  static const tertiaryFixedMediumDark = bluePastel;
  static const onTertiaryFixedMediumDark = blueAbyss;
  static const tertiaryFixedDimMediumDark = blueSoft;
  static const onTertiaryFixedVariantMediumDark = blueNavyLight;
  static const surfaceDimMediumDark = grayDarkest;
  static const surfaceBrightMediumDark = grayDark;
  static const surfaceContainerLowestMediumDark = grayMoss;
  static const surfaceContainerLowMediumDark = grayDarker;
  static const surfaceContainerMediumDark = grayDeepShadow;
  static const surfaceContainerHighMediumDark = grayDeepShade;
  static const surfaceContainerHighestMediumDark = grayShadow;

  // contrast mode: high, brightness: dark
  static const primaryHighDark = graySoftBright;
  static const surfaceTintHighDark = greenSea;
  static const onPrimaryHighDark = grayBlack;
  static const primaryContainerHighDark = greenTeal;
  static const onPrimaryContainerHighDark = grayBlack;
  static const secondaryHighDark = graySoftBright;
  static const onSecondaryHighDark = grayBlack;
  static const secondaryContainerHighDark = greenAccentLight;
  static const onSecondaryContainerHighDark = grayBlack;
  static const tertiaryHighDark = blueVeryLight;
  static const onTertiaryHighDark = grayBlack;
  static const tertiaryContainerHighDark = blueLightSteel;
  static const onTertiaryContainerHighDark = grayBlack;
  static const errorHighDark = grayLight;
  static const onErrorHighDark = grayBlack;
  static const errorContainerHighDark = redPastel;
  static const onErrorContainerHighDark = grayBlack;
  static const surfaceHighDark = grayDarkest;
  static const onSurfaceHighDark = grayWhite;
  static const onSurfaceVariantHighDark = graySoftPale;
  static const outlineHighDark = grayMuted;
  static const outlineVariantHighDark = grayMuted;
  static const shadowHighDark = grayBlack;
  static const scrimHighDark = grayBlack;
  static const inverseSurfaceHighDark = grayPale;
  static const inversePrimaryHighDark = greenDarkCadet;
  static const primaryFixedHighDark = greenLightPale;
  static const onPrimaryFixedHighDark = grayBlack;
  static const primaryFixedDimHighDark = greenTeal;
  static const onPrimaryFixedVariantHighDark = greenDeepMidnight;
  static const secondaryFixedHighDark = greenVeryLight;
  static const onSecondaryFixedHighDark = grayBlack;
  static const secondaryFixedDimHighDark = greenAccentLight;
  static const onSecondaryFixedVariantHighDark = greenDark;
  static const tertiaryFixedHighDark = blueSky;
  static const onTertiaryFixedHighDark = grayBlack;
  static const tertiaryFixedDimHighDark = blueLightSteel;
  static const onTertiaryFixedVariantHighDark = blueTwilight;
  static const surfaceDimHighDark = grayDarkest;
  static const surfaceBrightHighDark = grayDark;
  static const surfaceContainerLowestHighDark = grayMoss;
  static const surfaceContainerLowHighDark = grayDarker;
  static const surfaceContainerHighDark = grayDeepShadow;
  static const surfaceContainerHighHighDark = grayDeepShade;
  static const surfaceContainerHighestHighDark = grayShadow;

  //blue
  static const blueVeryLight = Color(0xfff8fbff);
  static const blueSky = Color(0xffd1eaff);
  static const bluePastel = Color(0xffc8e6ff);
  static const blueLightSteel = Color(0xffaecfe8);
  static const blueSoft = Color(0xffaacbe4);
  static const blueMisty = Color(0xff7595ac);
  static const blueSlate = Color(0xff59788f);
  static const blueCadet = Color(0xff436278);
  static const blueSkyDark = Color(0xff406075);
  static const blueSteel = Color(0xff2a4a5f);
  static const blueSteelDark = Color(0xff26465b);
  static const blueNavyLight = Color(0xff18394e);
  static const blueMidnightLight = Color(0xff113447);
  static const blueMidnight = Color(0xff0c3044);
  static const blueDeep = Color(0xff002538);
  static const blueDeepDark = Color(0xff001e2e);
  static const blueTwilight = Color(0xff001827);
  static const blueAbyss = Color(0xff00131f);
  
//red
  static const redVeryLight = Color(0xffffdad6);
  static const redLight = Color(0xffffb4ab);
  static const redPastel = Color(0xffffbab1);
  static const redSoft = Color(0xffff5449);
  static const redBright = Color(0xffda342e);
  static const redDeep = Color(0xffba1a1a);
  static const redDark = Color(0xff93000a);
  static const redDarkCrimson = Color(0xff8c0009);
  static const redWine = Color(0xff690005);
  static const redMaroon = Color(0xff4e0002);
  static const redBurgundy = Color(0xff410002);
  static const redAuburn = Color(0xff370001);

//green
  static const greenVeryLight = Color(0xffd1ede4);
  static const greenLight = Color(0xffcde8df);
  static const greenLightMint = Color(0xffaafce7);
  static const greenLightPale = Color(0xffa5f7e2);
  static const greenMint = Color(0xffa0f2dd);
  static const greenTeal = Color(0xff89dac6);
  static const greenSea = Color(0xff84d6c2);
  static const greenEmerald = Color(0xff4d9f8c);
  static const greenSlate = Color(0xff2d8271);
  static const greenForest = Color(0xff076b5b);
  static const greenDeep = Color(0xff016858);
  static const greenSoftDark = Color(0xff005245);
  static const greenDeepDark = Color(0xff005144);
  static const greenDarkForest = Color(0xff004c40);
  static const greenDarkEmerald = Color(0xff003e34);
  static const greenDarkTeal = Color(0xff00382e);
  static const greenCadet = Color(0xff00332b);
  static const greenDarkCadet = Color(0xff003028);
  static const greenMidnight = Color(0xff002820);
  static const greenDeepCadet = Color(0xff0e2621);
  static const greenDeepForest = Color(0xff00201a);
  static const greenBlack = Color(0xff06201a);
  static const greenDark = Color(0xff021a15);
  static const greenDeepMidnight = Color(0xff001a15);
  static const grayDeepDark = Color(0xff001510);

//green accent
  static const greenAccentVeryLight = Color(0xffbfc9c4);
  static const greenAccentLight = Color(0xffb5d1c8);
  static const greenAccentGray = Color(0xffb1ccc4);
  static const grayAccentPale = Color(0xff7c968e);
  static const greenAccentMisty = Color(0xff607a72);
  static const greenAccent = Color(0xff4b635c);
  static const greenAccentForest = Color(0xff48615a);
  static const greenAccentDeepForest = Color(0xff334b45);
  static const greenAccentTeal = Color(0xff2f4841);
  static const grayAccentMidnight = Color(0xff233b35); 
  static const greenAccentDark = Color(0xff1d352f);
  static const greenAccentDeepDark = Color(0xff19312b);

//gray
  static const grayWhite = Color(0xffffffff);
  static const grayLight = Color(0xfffff9f9);
  static const grayLightSoft = Color(0xfff6fcf8);
  static const grayLightPale = Color(0xfff5fbf7);
  static const graySoftPale = Color(0xfff3fdf8);
  static const graySoftMuted = Color(0xffeff5f1);
  static const graySoftBright = Color(0xffecfff8);
  static const graySoftDusty = Color(0xffe9efec);
  static const grayBright = Color(0xffe3eae6);
  static const grayPale = Color(0xffdee4e0);
  static const graySoft = Color(0xffd5dbd8);
  static const grayMuted = Color(0xffc3cdc9);
  static const graySlate = Color(0xff9ba5a1);
  static const graySlateLight = Color(0xff89938f);
  static const graySlateDark = Color(0xff7b8581);
  static const grayMisty = Color(0xff737d79);
  static const grayDarkSoft = Color(0xff6f7976);
  static const grayDarkMuted = Color(0xff57615e);
  static const grayDarkDusty = Color(0xff3f4946);
  static const grayDarkShade = Color(0xff3b4542);
  static const grayDark = Color(0xff343b38);
  static const grayShadow = Color(0xff303634);
  static const grayDeep = Color(0xff2b3230);
  static const grayDeepShade = Color(0xff252b29);
  static const grayDeepMuted = Color(0xff1d2623);
  static const grayDeepShadow = Color(0xff1b211f);
  static const grayDarker = Color(0xff171d1b);
  static const grayDarkest = Color(0xff0e1513);
  static const grayMoss = Color(0xff090f0e);
  static const grayAsh = Color(0xff090c0b);
  static const grayBlack = Color(0xff000000);
}
