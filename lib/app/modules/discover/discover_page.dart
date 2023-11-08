import 'package:analects/app/data/contents/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
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
        ]),
      ),
    );
  }
}
