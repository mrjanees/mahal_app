import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class CustomPngImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomPngImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.png',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpgImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpg',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpegImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpegImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpeg',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;
  final String? placeholderSvgName;
  final String? errorSvgName;
  final BoxFit? boxFitPlaceholder;

  const CustomImageNetwork(
      {super.key,
      this.imageUrl,
      this.height,
      this.width,
      this.boxFit,
      this.color,
      this.placeholderSvgName,
      this.boxFitPlaceholder,
      this.errorSvgName});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      placeholder: (context, url) => CustomSvgImage(
          imageName: placeholderSvgName ?? 'placeholder',
          boxFit: boxFitPlaceholder ?? BoxFit.cover),
      errorWidget: (context, url, error) => CustomSvgImage(
          imageName: errorSvgName ?? 'placeholder',
          boxFit: BoxFit.cover,
          color: color),
    );
  }
}

class CustomCachedNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomCachedNetworkImage(
      {super.key,
      this.imageUrl,
      this.height,
      this.width,
      this.boxFit,
      this.color});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      color: color,
      height: height ?? 30,
      width: width ?? 30,
      fit: boxFit ?? BoxFit.contain,
      cacheKey: getAWSS3BaseImageUrl(imageUrl ?? ''),
    );
  }

  String getAWSS3BaseImageUrl(String fullUrl) {
    RegExp regExp = RegExp(r'(^[^?]+)');
    Match? match = regExp.firstMatch(fullUrl);
    return match?.group(1) ?? '';
  }
}

class CustomSvgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? boxFit;
  bool transform;

  CustomSvgImage(
      {super.key,
      this.imageName,
      this.height,
      this.width,
      this.color,
      this.boxFit,
      this.transform = true});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: (Directionality.of(context) == TextDirection.ltr)
          ? Matrix4.rotationY(0)
          : Matrix4.rotationY(transform ? math.pi : 0),
      child: SvgPicture.asset(
        'assets/vectors/$imageName.svg',
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.fitWidth,
        // allowDrawingOutsideViewBox: true,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
