import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../widgets/widget_imports.dart';

class PlayAnalect extends StatelessWidget {
  final String audioFileUrl;
  PlayAnalect({super.key, required this.audioFileUrl});

  final playerController = Get.put(CreateAnalectsController());
  final volume = 70.obs;
  final isPlaying = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          appBar: CustomAppBar(
            title: "",
            backgroundColor: AppColors.noColor,
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SvgPicture.asset(AppAssets.moreIcon),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 260.h,
                  width: 260.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 100.w,
                          backgroundColor: AppColors.kSecondaryColor,
                          backgroundImage: const AssetImage(
                            AppAssets.creatorImage,
                          ),
                        ),
                      ),
                      Transform.scale(
                        scaleX: -1.0,
                        child: SleekCircularSlider(
                          appearance: CircularSliderAppearance(
                            customColors: CustomSliderColors(
                              trackColor: AppColors.kPrimary1Color,
                              progressBarColor: AppColors.kSecondaryColor,
                            ),
                            size: 245.w,
                            startAngle:
                                360,
                            angleRange: 180,
                            customWidths: CustomSliderWidths(
                              progressBarWidth: 10.w,
                              trackWidth: 10.w,
                            ),
                            infoProperties: InfoProperties(
                              mainLabelStyle: AppTypography.kBold16.copyWith(
                                color: AppColors.noColor,
                              ),
                              // modifier: (value) {
                              //   final displayValue =
                              //       Duration(seconds: value.toInt()).toString();
                              //   return displayValue;
                              // },
                            ),
                          ),
                          min: 0,
                          max: 100,
                          initialValue: volume.value.toDouble(),
                          onChange: (value) {
                            volume.value = value.toInt();
                          },
                        ),
                      ),
                      Positioned(
                        top: 80.h,
                        left: 0,
                        child: InkWell(
                          onTap: () {
                            if (volume.value > 0) {
                              volume.value -= 10;
                            }
                          },
                          child: SvgPicture.asset(
                            AppAssets.mutedIcon,
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80.h,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            if (volume.value < 100) {
                              volume.value += 10;
                            }
                          },
                          child: SvgPicture.asset(
                            AppAssets.volumeLoudIcon,
                            width: 30.w,
                            height: 30.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Lottie.asset(
                      AppAssets.audioAnimation,
                      animate: playerController.isPlaying.value,
                      repeat: playerController.isPlaying.value ? true : false,
                      frameRate: FrameRate.max,
                    ),
                    Positioned(
                      top: 40.h,
                      child: Column(
                        children: [
                          Text(
                            "Porta tempus turpis",
                            style: AppTypography.kBold16
                                .copyWith(color: AppColors.kWhiteColor),
                          ),
                          Text(
                            "At pharetra at",
                            style: AppTypography.kLight14.copyWith(
                                fontSize: 13,
                                color: AppColors.kWhiteColor.withOpacity(.3)),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 60.h,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: "00:00",
                            style: AppTypography.kBold16
                                .copyWith(color: AppColors.kWhiteColor),
                          ),
                          TextSpan(
                            text: " /00:00",
                            style: AppTypography.kBold14.copyWith(
                                fontSize: 13,
                                color: AppColors.kWhiteColor.withOpacity(.3)),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppAssets.tenSecondBackIcon),
                    SizedBox(
                      width: 20.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        playerController.isPlaying.value = !playerController.isPlaying.value;
                        playerController.play(audioUrl: audioFileUrl);
                      },
                      child: CircleAvatar(
                        backgroundColor: playerController.isPlaying.value
                            ? AppColors.kWhiteColor.withOpacity(.3)
                            : AppColors.kSecondaryColor,
                        radius: 40.h,
                        child: Center(
                          child: SvgPicture.asset(
                            playerController. isPlaying.value
                                ? AppAssets.stopAudioIcon
                                : AppAssets.pauseButton,
                            width: 24.w,
                            height: 32.h,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    SvgPicture.asset(AppAssets.tenSecondForwardIcon),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                Column(
                  children: [
                    Text(
                      "Comments",
                      style: AppTypography.kLight14.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.3),
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    SvgPicture.asset(AppAssets.doubleArrowUpIcon),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
