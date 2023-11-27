import 'package:analects/app/data/contents/app_analect_categories.dart';
import 'package:analects/app/modules/widgets/dialogs/custom_toast.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/repo/user_repo.dart';

class CreatorDescriptionPage extends StatelessWidget {
  final String subscriptionName;
  CreatorDescriptionPage({super.key, required this.subscriptionName});

  final user = Get.find<UserController>().currentUser;
  final selectedCategory = Rxn<AnalectCategories>();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: const CustomAppBar(
        title: "",
        backgroundColor: AppColors.noColor,
        actions: [],
      ),
      body: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: CircleAvatar(
                  radius: 50.w,
                  backgroundImage:
                      CachedNetworkImageProvider(user!.profileImage),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                user!.name,
                style: AppTypography.kBold24.copyWith(
                  color: AppColors.kWhiteColor,
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tell about your contents",
                  style: AppTypography.kLight16.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(.3),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Container(
                width: context.width,
                height: 150.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary1Color,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  style: AppTypography.kLight16.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    hintStyle: AppTypography.kLight16.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(.3),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: AppTypography.kMedium16.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(.3),
                  ),
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
                    // hasSearch: true,
                    selectedValue: selectedCategory.value,
                    items: AnalectCategories.values
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name.toString(),
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
              SizedBox(
                height: 170.h,
              ),
              CustomButton(
                text: "Save",
                onTap: () async {
                  if (descriptionController.text.isEmpty) {
                    showToast("Please enter description");

                    return;
                  } else if (selectedCategory.value == null) {
                    showToast("Please select category");

                    return;
                  } else {
                    await UserRepo().addBioAndCategorytoBecomeCreator(
                        bio: descriptionController.text,
                        category: selectedCategory.value!.name.toString(),
                        creatorSubs: subscriptionName == ""
                            ? "Free Plan"
                            : subscriptionName);
                    Get.find<UserController>().update();
                    Get.close(2);
                    showToast("Your become creator successfully");
                  }
                },
                buttonColor: AppColors.kSecondaryColor,
                width: 315.w,
                height: 64.h,
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
