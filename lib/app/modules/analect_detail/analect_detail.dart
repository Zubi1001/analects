import 'package:analects/app/modules/widgets/widget_imports.dart';

import '../widgets/dropdown/custom_dropdown.dart';

class AnalectDetail extends StatelessWidget {
  AnalectDetail({super.key});

  final TextEditingController _analectNameController = TextEditingController();
  final _analectNameFocusNode = FocusNode();
  final selectedCategory = Rxn<String>();
  final categoryList = [
    "Music",
    "Podcasting",
    "Voiceover",
    "Sound Design",
    "Religious and Spiritual",
    "Environmental and Nature Sounds",
    "Health and Wellness",
  ].obs;

  final confirmationCheck = false.obs;
  final audioPlayCheck = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
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
            onTap: () {
              confirmationCheck.value = true;
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
                    Container(
                      width: context.width,
                      height: 180.h,
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimary1Color,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: !confirmationCheck.value
                          ? Center(
                              child: SvgPicture.asset(
                                AppAssets.addIcon,
                                width: 40.w,
                                height: 40.w,
                              ),
                            )
                          : null,
                    ),
                    if (confirmationCheck.isTrue) ...[
                      Positioned(
                        bottom: 30.h,
                        right: 20.w,
                        child: InkWell(
                          onTap: () {
                           
                          },
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
                          left:80.w,
                          bottom: 60.h,
                          child: SizedBox(
                             width: 220.w,
                              height: 60.h,
                            child: Lottie.asset(
                              AppAssets.audioAnimation,
                              animate: audioPlayCheck.value,
                              repeat: audioPlayCheck.value ? true : false,
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
                                onTap: (){
                                  audioPlayCheck.value = !audioPlayCheck.value;
                                },
                                child: CircleAvatar(
                                  backgroundColor:  AppColors.kSecondaryColor,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      audioPlayCheck.value
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
                    return CustomDropdown<String>(
                      width: 330.w,
                      label: "Category",
                      // hasSearch: true,
                      selectedValue: selectedCategory.value,
                      items: categoryList.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: AppTypography.kMedium14.copyWith(
                                  color: AppColors.kWhiteColor,
                                ),
                              ));
                        },
                      ).toList(),
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
      );
    });
  }
}
