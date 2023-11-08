import 'package:analects/app/modules/home/components/catagories_scroll_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CatagoriesScrollView extends StatelessWidget {
  const CatagoriesScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CatagoriesScrollViewItem();
        },
      ),
    );
  }
}