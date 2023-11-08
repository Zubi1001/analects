import 'package:analects/app/data/contents/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSignInCustomButton extends StatelessWidget {
  const LoginSignInCustomButton(
      {super.key, required this.text, required this.onTap,  this.width});
  final String text;
  final VoidCallback onTap;
  final double? width ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 50.h,
        width:width ?? 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.kButtonColor,
        ),
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
