import 'package:analects/app/modules/widgets/widget_imports.dart';

class CreateAnalects extends StatelessWidget {
  const CreateAnalects({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateAnalectsController>(
      init: CreateAnalectsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.kPrimary1Color,
          appBar: const CustomAppBar(
            title: "Create Analects",
            backgroundColor: AppColors.noColor,
            actions: [],
          ),
          body: SafeArea(
            child: SizedBox(
              width: context.width,
              height: context.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  Container(
                    color: AppColors.noColor,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Lottie.asset(
                          AppAssets.audioAnimation,
                          animate: controller.isRunning.value,
                          repeat: controller.isRunning.value ? true : false,
                          frameRate: FrameRate.max,
                        ),
                        Text(
                          controller.displayTime,
                          style: AppTypography.kExtraBold32
                              .copyWith(color: AppColors.kWhiteColor),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => controller.reset(),
                        child: SvgPicture.asset(
                          AppAssets.audioDiscardIcon,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                      SizedBox(width: 35.w),
                      GestureDetector(
                        onTap: () {
                          controller.isRunning.value
                              ? controller.stop()
                              : controller.start();
                        },
                        child: CircleAvatar(
                          backgroundColor: controller.isRunning.value
                              ? AppColors.kWhiteColor.withOpacity(.3)
                              : AppColors.kSecondaryColor,
                          radius: 35.h,
                          child: Center(
                            child: SvgPicture.asset(
                              controller.isRunning.value
                                  ? AppAssets.stopAudioIcon
                                  : AppAssets.micIcon,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 35.w),
                      GestureDetector(
                        onTap: () => Get.to(() => AnalectDetail()),
                        child: SvgPicture.asset(
                          AppAssets.audioSaveIcon,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
