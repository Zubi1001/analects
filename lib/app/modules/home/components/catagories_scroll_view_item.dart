import 'package:analects/app/data/contents/app_colors.dart';
import 'package:analects/app/data/contents/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatagoriesScrollViewItem extends StatelessWidget {
  const CatagoriesScrollViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(6.h),
      width: 120.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: AppColors.kWhiteColor.withOpacity(0.1),
      ),
      height: 80.h,
      child:  Text('Marketing', style: AppTypography.kBold14),
    );
  }
}
