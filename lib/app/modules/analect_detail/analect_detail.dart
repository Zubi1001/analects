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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: const CustomAppBar(
        title: "Analect Detail",
        backgroundColor: AppColors.noColor,
        actions: [],
      ),
      bottomNavigationBar: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 30.w, vertical: 20),
        child: CustomButton(onTap: () {

        },text: "Confirm",
        height: 60.h,),
      ),
      body: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cover",
                style: AppTypography.kMedium16.copyWith(
                  color: AppColors.kWhiteColor.withOpacity(.3),
                ),
              ),
              Container(
                width: context.width,
                height: 180.h,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary1Color,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.addIcon,
                    width: 40.w,
                    height: 40.w,
                  ),
                ),
              ),
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
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
