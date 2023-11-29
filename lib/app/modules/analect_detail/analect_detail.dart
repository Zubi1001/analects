import 'package:analects/app/data/contents/app_analect_categories.dart';
import 'package:analects/app/modules/widgets/dialogs/custom_toast.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/repo/analect_repo.dart';

// ignore: must_be_immutable
class AnalectDetail extends StatelessWidget {
  AnalectDetail({super.key});

  final TextEditingController _analectNameController = TextEditingController();
  final _analectNameFocusNode = FocusNode();
  final selectedCategory = Rxn<AnalectCategories>();
  final pickedFile = Rxn<File?>();

  final confirmationCheck = false.obs;
  final db = DatabaseService();
  final ac = Get.find<AuthController>();
  final controller = Get.find<CreateAnalectsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: AppColors.kPrimaryColor,
            appBar: CustomAppBar(
              title: confirmationCheck.value
                  ? _analectNameController.text
                  : "Analect Detail",
              backgroundColor: AppColors.noColor,
              actions: const [],
              onBack: () {
                if (confirmationCheck.value) {
                  confirmationCheck.value = false;
                } else {
                  Get.back();
                }
              },
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20),
              child: CustomButton(
                onTap: () async {
                  if (!confirmationCheck.value) {
                    if (pickedFile.value == null) {
                      showToast('Image Required');
                      log("image required");
                    } else if (_analectNameController.text == "") {
                      showToast('Name Required');

                      log("Name Required");
                    } else if (selectedCategory.value == null) {
                      showToast('Category Required');

                      log("select Category");
                    } else {
                      confirmationCheck.value = true;
                    }
                  } else {
                    await AnalectsRepo().postAnalects(
                      audioFilePath: controller.recordingPath!,
                      analectImage: pickedFile.value!,
                      category: selectedCategory.value!.name,
                      analectName: _analectNameController.text,
                    );
                    Get.close(2);
                    // Get.offAll(() => LandingPage(),
                    //     transition: Transition.fadeIn);
                  }
                },
                text: confirmationCheck.value ? "Post " : "Confirm",
                height: 60.h,
              ),
            ),
            body: SafeArea(
              child: Container(
                width: context.width,
                height: context.height,
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (confirmationCheck.isFalse)
                      Text(
                        "Cover",
                        style: AppTypography.kMedium16.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(.3),
                        ),
                      ),
                    Stack(
                      children: [
                        InkWell(
                          onTap: () async {
                            pickedFile.value =
                                await ImagePickerService.getImageFromGallery();
                          },
                          child: Container(
                            width: context.width,
                            height: 180.h,
                            margin: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.kPrimary1Color,
                              borderRadius: BorderRadius.circular(30.r),
                              image: DecorationImage(
                                  image:
                                      FileImage(pickedFile.value ?? File(""))),
                            ),
                            child: pickedFile.value == null
                                ? Center(
                                    child: SvgPicture.asset(
                                      AppAssets.addIcon,
                                      width: 40.w,
                                      height: 40.w,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        if (pickedFile.value != null) ...[
                          Positioned(
                            bottom: 30.h,
                            right: 20.w,
                            child: InkWell(
                              onTap: () {},
                              child: SvgPicture.asset(
                                AppAssets.cameraIcon,
                                width: 30.w,
                                height: 30.w,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (confirmationCheck.isTrue) ...[
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        width: 343.w,
                        height: 64.h,
                        decoration: BoxDecoration(
                          color: AppColors.kPrimary1Color,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 80.w,
                              bottom: 60.h,
                              child: SizedBox(
                                width: 220.w,
                                height: 60.h,
                                child: Lottie.asset(
                                  AppAssets.audioAnimation,
                                  animate: controller.isPlaying.value,
                                  repeat:
                                      controller.isPlaying.value ? true : false,
                                  fit: BoxFit.fitWidth,
                                  frameRate: FrameRate.max,
                                ),
                              ),
                            ),
                            Center(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // controller.isPlaying.value =
                                      //     !controller.isPlaying.value;
                                      if (!controller.isPlaying.value) {
                                        controller.playPlayer();
                                      } else {
                                        controller.stopPlayer();
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          AppColors.kSecondaryColor,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          controller.isPlaying.value
                                              ? AppAssets.playingIcon
                                              : AppAssets.pauseButton,
                                          width: 16.w,
                                          height: 16.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                    Text(
                      "Title",
                      style: AppTypography.kMedium16.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.3),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      controller: _analectNameController,
                      focusNode: _analectNameFocusNode,
                      hintText: 'New Ananlect',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your analect name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Category",
                      style: AppTypography.kMedium16.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.3),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(
                      () {
                        return CustomDropdown<AnalectCategories>(
                          width: 330.w,
                          label: "Category",
                          hasSearch: true,
                          selectedValue: selectedCategory.value,
                          items: AnalectCategories.values
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      replaceUnderScoreWithSpace(
                                          e.name.capitalize.toString()),
                                      style: AppTypography.kMedium14.copyWith(
                                        color: AppColors.kWhiteColor,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedCategory.value = value!;
                            return null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
