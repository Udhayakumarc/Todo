import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

///[ImageWidgetProvider] is provide widget to display images and icons,
///   check is availability of imageUrl and local AEM
///   and return widget to display both asset and network images
/// [imageId] image id of image from [AssetCatlog] class
///
class CacheImageBuilder extends StatelessWidget {
  final CacheImageUrl imagePath;
  final Size? imageSize;
  final BoxFit? boxFit;
  final Color? color;
  final double? width;
  final double? height;
  final int frameRate;
  final bool loop;
  final Alignment alignment;
  final bool excludeFromSemantics;
  const CacheImageBuilder(
      {Key? key,
      required this.imagePath,
      this.frameRate = 15,
      this.height,
      this.width,
      this.loop = true,
      this.imageSize,
      this.boxFit,
      this.color,
      this.excludeFromSemantics = false,
      this.alignment = Alignment.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// get image path from aem, check if image is network image
    if (imagePath.networkImageUrl != null) {
      if (imagePath.networkImageUrl!.contains('https://')) {
        return NetworkImageBuilder(
          imagePath: imagePath,
          size: imageSize,
          boxFit: boxFit,
          height: height,
          width: width,
          excludeFromSemantics: excludeFromSemantics,
          color: color,
          alignment: alignment,
        );
      }
    }

    return AssetImageBuilder(
      imagePath: imagePath.assetImageUrl!,
      size: imageSize,
      boxFit: boxFit,
      color: color,
      alignment: alignment,
      height: height,
      width: width,
      excludeFromSemantics: excludeFromSemantics,
    );
  }
}

/// network asset builder
class NetworkImageBuilder extends StatelessWidget {
  final CacheImageUrl imagePath;
  final Size? size;
  final BoxFit? boxFit;
  final Color? color;
  final double? height;
  final double? width;
  final Alignment alignment;
  final bool excludeFromSemantics;
  const NetworkImageBuilder({
    Key? key,
    required this.imagePath,
    this.size,
    this.boxFit,
    this.color,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.excludeFromSemantics = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath.networkImageUrl!,
      fit: boxFit ?? BoxFit.contain,
      color: color,
      width: size?.width ?? width,
      height: size?.height ?? height,
      alignment: alignment,

      /// while image is loading show existing image from asset
      placeholder: (_, url) => AssetImageBuilder(
        imagePath: imagePath.assetImageUrl!,
        size: size,
        boxFit: boxFit,
        alignment: alignment,
        height: height,
        width: width,
        excludeFromSemantics: excludeFromSemantics,
      ),

      /// on error show image from asset folder
      errorWidget: (context, url, error) => AssetImageBuilder(
        imagePath: imagePath.assetImageUrl!,
        size: size,
        boxFit: boxFit,
        alignment: alignment,
        height: height,
        width: width,
        excludeFromSemantics: excludeFromSemantics,
        color: color,
      ),
    );
  }
}

DecorationImage netWorkOrCacheImageProvider({
  required CacheImageUrl imagePath,
  Size? size,
  BoxFit? boxFit,
  double? height,
  double? width,
}) {
  if (imagePath.networkImageUrl != null) {
    if (imagePath.networkImageUrl!.contains('https://')) {
      try {
        return DecorationImage(
            image: networkImageProvider(
              imagePath: imagePath.networkImageUrl!,
              size: size,
            ),
            fit: boxFit);
      } on Exception catch (_) {
        return DecorationImage(
            image: assetImageProvider(
                imagePath: imagePath.assetImageUrl!, size: size),
            fit: boxFit);
      }
    }
  }
  return DecorationImage(
      image:
          assetImageProvider(imagePath: imagePath.assetImageUrl!, size: size),
      fit: boxFit);
}

ImageProvider networkImageProvider({
  required String imagePath,
  Size? size,
}) {
  return CachedNetworkImageProvider(
    imagePath,
    maxHeight: size?.height.toInt(),
    maxWidth: size?.width.toInt(),
  );
}

ImageProvider assetImageProvider({required String imagePath, Size? size}) {
  return AssetImage(
    imagePath,
  );
}

/// image asset builder
class AssetImageBuilder extends StatelessWidget {
  final String imagePath;
  final Size? size;
  final BoxFit? boxFit;
  final Color? color;
  final double? height;
  final double? width;
  final bool excludeFromSemantics;
  final Alignment alignment;
  const AssetImageBuilder({
    Key? key,
    required this.imagePath,
    this.size,
    this.boxFit,
    this.color,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.excludeFromSemantics = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: size?.width ?? width,
      height: size?.height ?? height,
      fit: boxFit ?? BoxFit.contain,
      color: color,
      alignment: alignment,
      excludeFromSemantics: excludeFromSemantics,
    );
  }
}

class GifBuilder extends StatelessWidget {
  final String imagePath;
  final Size? size;
  final BoxFit? boxFit;
  final Color? color;
  final double? width;
  final double? height;
  final int frameRate;
  final bool loop;
  final Function()? onFinish;
  const GifBuilder(
      {Key? key,
      required this.imagePath,
      this.frameRate = 15,
      this.width,
      this.height,
      this.loop = true,
      this.size,
      this.boxFit,
      this.color,
      required this.onFinish})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath.contains('https://')) {
      return GifView.network(
        imagePath,
        key: key,
        width: width,
        height: height,
        fit: boxFit ?? BoxFit.contain,
        frameRate: frameRate,
        loop: loop,
        color: color,
        onFinish: onFinish,
      );
    }
    return GifView.asset(
      imagePath,
      key: key,
      width: width,
      height: height,
      fit: boxFit ?? BoxFit.contain,
      frameRate: frameRate,
      loop: loop,
      color: color,
      onFinish: onFinish,
    );
  }
}

class CacheImageUrl {
  String? networkImageUrl;
  String? assetImageUrl;

  CacheImageUrl({this.networkImageUrl, this.assetImageUrl});
}
