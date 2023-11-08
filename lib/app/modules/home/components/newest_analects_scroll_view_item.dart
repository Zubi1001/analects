import 'package:analects/app/data/contents/app_colors.dart';
import 'package:analects/app/data/contents/app_typography.dart';
import 'package:analects/app/modules/home/components/play_and_pause_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewestAnalectsScrollViewItem extends StatelessWidget {
  const NewestAnalectsScrollViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      height: 100.h,
      width: 255.w,
      color: AppColors.kPrimaryColor,
      child: Column(children: [
        Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              height: 100.h,
              width: 120.w,
              decoration: BoxDecoration(
                  color: AppColors.kWhiteColor,
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Song name', style: AppTypography.kBold14),
                SizedBox(height: 10.h),
                Text('Title',
                    style: AppTypography.kExtraLight12.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(0.5))),
                SizedBox(height: 10.h),
                Text('Singer name',
                    style: AppTypography.kExtraLight12
                        .copyWith(color: AppColors.kWhiteColor)),
              ],
            ),
            SizedBox(width: 90.w,),
            SizedBox(
              width: 40.w,
              height: 40.h,
              child: PlayAndPauseButton(
                height: 70.h,
                width: 70.h,
                onPressed: () {
                  
                },
                isPlaying: false,
              ))
          ],
        )
      ]),
    );
  }
}
