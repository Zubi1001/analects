import 'package:analects/app/data/contents/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidgetOfOnBoardingPage extends StatelessWidget {
  const HeaderWidgetOfOnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500.h,
        width: 300.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppAssets.onBoardingHeaderImages), fit: BoxFit.fitWidth),
        ),);
  }
}
