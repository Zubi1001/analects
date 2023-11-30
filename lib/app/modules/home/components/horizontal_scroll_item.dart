import '../../widgets/widget_imports.dart';

class HorizontalScrollViewItem extends StatelessWidget {
  final bool labelButtonCheck;
  final UserModel? creatorData;

  const HorizontalScrollViewItem(
      {super.key, this.labelButtonCheck = true, required this.creatorData});

  UserModel get creator => creatorData!;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => CreatorProfilePage(creatorId: creator.id)),
      child: Container(
        width: 320.h,
        margin: EdgeInsets.all(6.h),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(creator.profileImage),
              fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
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
                    Text(creator.name,
                        style: AppTypography.kBold16
                            .copyWith(color: AppColors.kWhiteColor)),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      '| ${creator.analects} Analects',
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                        color: AppColors.kPrimary1Color.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30.r)),
                    child: Text(creator.category.capitalizeFirst!,
                        style: TextStyle(
                            color: AppColors.kWhiteColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold))),
              ),
            Positioned(
              bottom: 20.h,
              right: 20.w,
              child: PlayAndPauseButton(
                onPressed: () {},
                isPlaying: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
