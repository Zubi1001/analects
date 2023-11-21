import 'package:analects/models/analect_model.dart';

import '../../widgets/widget_imports.dart';
class AnalectsListViewItem extends StatelessWidget {
  final AnalectModel? analectData;
  const AnalectsListViewItem({super.key, required this.analectData});

 
  AnalectModel get analectModel => analectData!;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.w),
      height: 100.h,
      width: 255.w,
      color: AppColors.kPrimaryColor,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 80.h,
                width: 90.w,
                decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.circular(23.r),
                    image: const DecorationImage(
                      image: AssetImage(AppAssets.analectsImage),
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(analectModel.analectName, style: AppTypography.kBold14),
                  SizedBox(height: 10.h),
                  Text(analectModel.category,
                      style: AppTypography.kExtraLight12.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(0.5))),
                  SizedBox(height: 10.h),
                  Text(analectModel.creatorName,
                      style: AppTypography.kExtraLight12
                          .copyWith(color: AppColors.kWhiteColor)),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 40.w,
                height: 40.h,
                child: PlayAndPauseButton(
                  height: 70.h,
                  width: 70.h,
                  onPressed: () {
                    Get.to(() =>  PlayAnalect(audioFileUrl: analectData!.audioUrl,));
                  },
                  isPlaying: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
