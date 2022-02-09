import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pro_chat/utils/constants.dart';
import 'package:skeletons/skeletons.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({
    Key? key,
    required this.svgName,
    this.color,
  }) : super(key: key);

  final String svgName;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Constants.iconAsset('$svgName.svg'),
      color: color,
    );
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: width,
            height: height,
          ),
        );
      },
    );
  }
}

class CircularNetworkImage extends StatelessWidget {
  const CircularNetworkImage({
    Key? key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: width,
              height: height,
            ),
          );
        },
      ),
    );
  }
}
