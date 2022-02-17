import 'package:flutter/material.dart';
import 'package:pro_chat/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_loader.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.height = 60,
    this.width = double.infinity,
    this.isLoading = false,
    this.fontColor = kblack,
  }) : super(key: key);

  final Function() onTap;
  final String text;
  final double height;
  final double width;
  final bool isLoading;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isLoading ? primaryColor.withOpacity(.3) : primaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: isLoading
              ? const CustomLoader()
              : Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: fontColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
