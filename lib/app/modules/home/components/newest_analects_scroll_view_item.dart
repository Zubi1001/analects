import 'package:analects/models/analect_model.dart';
import '../../widgets/widget_imports.dart';

class AnalectsListViewItem extends StatelessWidget {
  final AnalectModel? analectData;
  final UserModel? creatorData;
  const AnalectsListViewItem({super.key, this.analectData, this.creatorData});

  // ignore: unnecessary_null_in_if_null_operators
  AnalectModel? get _analectModel => analectData;
  UserModel? get _creatorData => creatorData;

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
                    color: AppColors.kPrimary1Color,
                    borderRadius: BorderRadius.circular(23.r),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          _analectModel?.image ?? _creatorData!.profileImage),
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_analectModel?.analectName ?? _creatorData!.name,
                      style: AppTypography.kBold14),
                  SizedBox(height: 10.h),
                  Text(
                      _analectModel?.category ??
                          "${_creatorData!.analects.toString()} Analects",
                      style: AppTypography.kExtraLight12.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(0.5))),
                  if (_analectModel != null) ...[
                    SizedBox(height: 10.h),
                    Text(_analectModel?.creatorName ?? "",
                        style: AppTypography.kExtraLight12
                            .copyWith(color: AppColors.kWhiteColor)),
                  ],
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
                    if (_analectModel != null) {
                      Get.to(() => PlayAnalect(
                            analectData: analectData!,
                          ));
                    }
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
