import 'package:analects/app/modules/home/components/top_creators_scroll_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopCreatorsScrollView extends StatelessWidget {
  const TopCreatorsScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return  const TopCreatorsScrollViewItem();
        },
      ),
    );
  }
}
