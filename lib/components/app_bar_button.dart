import 'package:flutter/material.dart';
import 'package:pro_chat/utils/app_colors.dart';
import 'custom_images.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    Key? key,
    this.iconName = 'back-arrow',
    required this.ontap,
  }) : super(key: key);

  final String iconName;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 48,
        width: 48,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(15),
        ),
        child: CustomSvg(svgName: iconName),
      ),
    );
  }
}
