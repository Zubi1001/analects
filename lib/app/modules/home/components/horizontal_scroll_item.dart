

import '../../widgets/widget_imports.dart';

// ignore: must_be_immutable
class HorizontalScrollViewItem extends StatelessWidget {
  bool labelButtonCheck;

  HorizontalScrollViewItem({super.key, this.labelButtonCheck = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() =>  CreatorProfilePage()),
      child: Container(
        width: 320.h,
        margin: EdgeInsets.all(6.h),
        decoration: BoxDecoration(
          image: const DecorationImage(image: AssetImage(AppAssets.creatorImage), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                  color: AppColors.kWhiteColor.withOpacity(0.5),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(15.r), bottomRight: Radius.circular(15.r))),
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Joy and Jill', style: AppTypography.kBold16.copyWith(color: AppColors.kWhiteColor)),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '| 240 Analects',
                      style: AppTypography.kLight14.copyWith(
                        color: AppColors.kWhiteColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (labelButtonCheck)
              Positioned(
                top: 20.h,
                right: 20.w,
                child: Container(
                    alignment: Alignment.center,
                    height: 40.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                        color: AppColors.kPrimary1Color.withOpacity(0.5), borderRadius: BorderRadius.circular(30.r)),
                    child: Text('Design',
                        style: TextStyle(color: AppColors.kWhiteColor, fontSize: 16.sp, fontWeight: FontWeight.bold))),
              ),
            Positioned(
              bottom: 20.h,
              right: 20.w,
              child: PlayAndPauseButton(
                onPressed: () {
                  Get.to(() =>  PlayAnalect(audioFileUrl: '',));
                },
                isPlaying: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
