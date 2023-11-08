import 'package:analects/app/data/contents/app_colors.dart';
import 'package:analects/app/data/contents/app_typography.dart';
import 'package:analects/app/modules/home/components/catagories_scroll_view.dart';
import 'package:analects/app/modules/home/components/newest_analects_scroll_view.dart';
import 'package:analects/app/modules/home/components/top_creators_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Hey John!', style: AppTypography.kExtraBold20),
                  Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30.sp,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Top Creators', style: AppTypography.kExtraBold20),
                  Text('See All', style: AppTypography.specialTextStyle),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: const TopCreatorsScrollView()),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Catagories', style: AppTypography.kExtraBold20)
              ]),
            ),
            SizedBox(height: 20.h),
            Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: const CatagoriesScrollView()),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Newest Analects', style: AppTypography.kExtraBold20)
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: const NewestAnalectsScrollView())
          ]),
        ),
      ),
    );
  }
}
