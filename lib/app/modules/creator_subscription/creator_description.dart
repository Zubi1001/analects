import 'package:analects/app/modules/widgets/widget_imports.dart';

class CreatorDescriptionPage extends StatelessWidget {
  CreatorDescriptionPage({super.key});

  final user = Get.find<UserController>().currentUser;

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
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    hintStyle: AppTypography.kLight16.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(.3),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              CustomButton(
                text: "Save",
                onTap: () {
                  Get.offAll(() =>  LandingPage(), transition: Transition.fadeIn);
                },
                buttonColor: AppColors.kSecondaryColor,
                width: 315.w,
                height: 64.h,
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
