import 'package:analects/app/data/contents/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.textColor = AppColors.kWhiteColor,
    this.buttonColor = AppColors.kSecondaryColor,
    this.buttonBorderRadius,
  });

  final String text;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final double? buttonBorderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 50.h,
        width: width ?? 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(buttonBorderRadius ?? 20.r),
          color: buttonColor,
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
