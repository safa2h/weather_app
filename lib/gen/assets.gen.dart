/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/icons8-clouds-80.png
  AssetGenImage get icons8Clouds80 =>
      const AssetGenImage('assets/images/icons8-clouds-80.png');

  /// File path: assets/images/icons8-heavy-rain-80.png
  AssetGenImage get icons8HeavyRain80 =>
      const AssetGenImage('assets/images/icons8-heavy-rain-80.png');

  /// File path: assets/images/icons8-partly-cloudy-day-80.png
  AssetGenImage get icons8PartlyCloudyDay80 =>
      const AssetGenImage('assets/images/icons8-partly-cloudy-day-80.png');

  /// File path: assets/images/icons8-rain-cloud-80.png
  AssetGenImage get icons8RainCloud80 =>
      const AssetGenImage('assets/images/icons8-rain-cloud-80.png');

  /// File path: assets/images/icons8-snow-80.png
  AssetGenImage get icons8Snow80 =>
      const AssetGenImage('assets/images/icons8-snow-80.png');

  /// File path: assets/images/icons8-storm-80.png
  AssetGenImage get icons8Storm80 =>
      const AssetGenImage('assets/images/icons8-storm-80.png');

  /// File path: assets/images/icons8-sun-96.png
  AssetGenImage get icons8Sun96 =>
      const AssetGenImage('assets/images/icons8-sun-96.png');

  /// File path: assets/images/icons8-windy-weather-80.png
  AssetGenImage get icons8WindyWeather80 =>
      const AssetGenImage('assets/images/icons8-windy-weather-80.png');

  /// File path: assets/images/nightpic.jpg
  AssetGenImage get nightpic =>
      const AssetGenImage('assets/images/nightpic.jpg');

  /// File path: assets/images/pic_bg.jpg
  AssetGenImage get picBg => const AssetGenImage('assets/images/pic_bg.jpg');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
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

  String get path => _assetName;

  String get keyName => _assetName;
}
