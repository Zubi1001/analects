import 'package:analects/app/modules/home/components/newest_analects_scroll_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewestAnalectsScrollView extends StatelessWidget {
  const NewestAnalectsScrollView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 260.h,
        //create a vertical list view
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const NewestAnalectsScrollViewItem();
          },
        ));
  }
}
