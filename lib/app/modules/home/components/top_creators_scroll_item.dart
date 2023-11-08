import 'package:analects/app/data/contents/app_assets.dart';
import 'package:analects/app/data/contents/app_colors.dart';
import 'package:analects/app/data/contents/app_typography.dart';
import 'package:analects/app/modules/home/components/play_and_pause_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TopCreatorsScrollViewItem extends StatelessWidget {
  const TopCreatorsScrollViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.h,
      margin: EdgeInsets.all(6.h),
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(AppAssets.creatorImage), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
              color: AppColors.kWhiteColor.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r))),
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Joy and Jill',
                    style: AppTypography.kBold16
                        .copyWith(color: AppColors.kWhiteColor)),
                SizedBox(
                  width: 5.w,
                ),
                Text('| 240 Analects',
                    style: AppTypography.kLight14.copyWith(
                      color: AppColors.kWhiteColor,
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 165.h,
          left: 200.w,
          child: Container(
              alignment: Alignment.center,
              height: 40.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: AppColors.kWhiteColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(30.r)),
              child: Text('Design',
                  style: TextStyle(
                      color: AppColors.kWhiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold))),
        ),
        Positioned(
            bottom: 20.h,
            left: 210.w,
            child: PlayAndPauseButton(
              onPressed: () {},
              isPlaying: false,
            )),
      ]),
    );
  }
}
