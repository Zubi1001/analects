import 'package:analects/app/modules/widgets/dialogs/confirmation_dialog.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:flutter/cupertino.dart';

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
                        CupertinoContextMenu(
                          actions: [
                            CupertinoContextMenuAction(
                              child: const Text('Save'),
                              onPressed: () {
                                if (controller.elapsedTime.value > 0) {
                                  Get.dialog(ConfirmationDialog(
                                      onConfirm: () {
                                        controller.stopRecording();
                                        Get.back();
                                        Get.to(() => AnalectDetail());
                                      },
                                      confirmationText:
                                          'Are you sure you want to save this audio?'));
                                } else {
                                  showErrorDialog(
                                      'Please record something first');
                                }
                              },
                            ),
                            CupertinoContextMenuAction(
                              child: const Text('Discard'),
                              onPressed: () {
                                controller.reset();
                                Get.back();
                              },
                            ),
                          ],
                          child: Lottie.asset(
                            AppAssets.audioAnimation,
                            animate: controller.isRecording.value,
                            repeat: controller.isRecording.value ? true : false,
                            frameRate: FrameRate.max,
                          ),
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
                        onTap: () {
                          Get.dialog(ConfirmationDialog(
                              onConfirm: () {
                                controller.reset();
                                Get.back();
                              },
                              confirmationText:
                                  'Are you sure you want to discard this audio?'));
                        },
                        child: SvgPicture.asset(
                          AppAssets.audioDiscardIcon,
                          height: 30.h,
                          width: 30.w,
                        ),
                      ),
                      SizedBox(width: 35.w),
                      GestureDetector(
                        onTap: () {
                          controller.isRecordingPaused.value
                              ? controller.resume()
                              : controller.isRecording.value
                                  ? controller.pause()
                                  : controller.start();
                        },
                        child: CircleAvatar(
                          backgroundColor: controller.isRecording.value
                              ? AppColors.kWhiteColor.withOpacity(.3)
                              : AppColors.kSecondaryColor,
                          radius: 35.h,
                          child: Center(
                            child: SvgPicture.asset(
                              controller.isRecording.value
                                  ? AppAssets.stopAudioIcon
                                  : AppAssets.micIcon,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 35.w),
                      GestureDetector(
                        onTap: () {
                          if(controller.elapsedTime.value > 0){
                            Get.dialog(ConfirmationDialog(
                              onConfirm: () {
                                if (controller.isRecording.value ||
                                    controller.isRecordingPaused.value) {
                                  controller.stopRecording();
                                  Get.back();
                                  Get.to(() => AnalectDetail());
                                } else {
                                  Get.back();
                                  Get.to(() => AnalectDetail());
                                }
                              },
                              confirmationText:
                                  'Are you sure you want to save this audio?'));
                          }else {
                            showErrorDialog('Please record something first');
                          }
                         
                        },
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
