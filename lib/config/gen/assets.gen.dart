/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/flow_logo_background_demonstration.png
  AssetGenImage get flowLogoBackgroundDemonstration => const AssetGenImage(
      'assets/icons/flow_logo_background_demonstration.png');

  /// File path: assets/icons/flow_logo_background_development.png
  AssetGenImage get flowLogoBackgroundDevelopment =>
      const AssetGenImage('assets/icons/flow_logo_background_development.png');

  /// File path: assets/icons/flow_logo_background_production.png
  AssetGenImage get flowLogoBackgroundProduction =>
      const AssetGenImage('assets/icons/flow_logo_background_production.png');

  /// File path: assets/icons/flow_logo_demonstration.png
  AssetGenImage get flowLogoDemonstration =>
      const AssetGenImage('assets/icons/flow_logo_demonstration.png');

  /// File path: assets/icons/flow_logo_development.png
  AssetGenImage get flowLogoDevelopment =>
      const AssetGenImage('assets/icons/flow_logo_development.png');

  /// File path: assets/icons/flow_logo_foreground.png
  AssetGenImage get flowLogoForeground =>
      const AssetGenImage('assets/icons/flow_logo_foreground.png');

  /// File path: assets/icons/flow_logo_production.png
  AssetGenImage get flowLogoProduction =>
      const AssetGenImage('assets/icons/flow_logo_production.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        flowLogoBackgroundDemonstration,
        flowLogoBackgroundDevelopment,
        flowLogoBackgroundProduction,
        flowLogoDemonstration,
        flowLogoDevelopment,
        flowLogoForeground,
        flowLogoProduction
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/banner.png
  AssetGenImage get banner => const AssetGenImage('assets/images/banner.png');

  /// File path: assets/images/green_eco_store.webp
  AssetGenImage get greenEcoStore =>
      const AssetGenImage('assets/images/green_eco_store.webp');

  /// File path: assets/images/offer_image_1.webp
  AssetGenImage get offerImage1 =>
      const AssetGenImage('assets/images/offer_image_1.webp');

  /// File path: assets/images/offer_image_2.webp
  AssetGenImage get offerImage2 =>
      const AssetGenImage('assets/images/offer_image_2.webp');

  /// File path: assets/images/offer_image_3.webp
  AssetGenImage get offerImage3 =>
      const AssetGenImage('assets/images/offer_image_3.webp');

  /// File path: assets/images/offer_image_4.webp
  AssetGenImage get offerImage4 =>
      const AssetGenImage('assets/images/offer_image_4.webp');

  /// File path: assets/images/product_on_palette.webp
  AssetGenImage get productOnPalette =>
      const AssetGenImage('assets/images/product_on_palette.webp');

  /// File path: assets/images/zero_waste_fruits_and_vegetables.webp
  AssetGenImage get zeroWasteFruitsAndVegetables => const AssetGenImage(
      'assets/images/zero_waste_fruits_and_vegetables.webp');

  /// List of all assets
  List<AssetGenImage> get values => [
        banner,
        greenEcoStore,
        offerImage1,
        offerImage2,
        offerImage3,
        offerImage4,
        productOnPalette,
        zeroWasteFruitsAndVegetables
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
