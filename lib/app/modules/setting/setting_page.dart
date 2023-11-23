import 'package:analects/app/modules/creator_subscription/creator_subscription.dart';
import 'package:analects/app/modules/user_edit_profile/user_edit_profile.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:flutter/cupertino.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final user = Get.find<UserController>().currentUser;
  final auth = AuthService();
  final notificationPermission = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: CustomAppBar(
        title: "Setting",
        backgroundColor: AppColors.noColor,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(()=> UserEditProfilePage());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SvgPicture.asset(AppAssets.editIcon),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              CircleAvatar(
                radius: 50.w,
                backgroundImage: CachedNetworkImageProvider(user!.profileImage),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                user!.name,
                style: AppTypography.kBold24.copyWith(
                  color: AppColors.kWhiteColor,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              CustomButton(
                text: user!.creator?"See Your Creator Profile": "Become a Creator",
                onTap: () {
                   user!.creator? Get.to( ()=>CreatorProfilePage(creatorData: user!)): Get.to(()=> const CreatorSubscriptionPage());
                },
                buttonColor: AppColors.kBlueColor,
                width: 315.w,
                height: 64.h,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 315.w,
                height: 64.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: AppColors.kPrimary1Color,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(children: [
                  SvgPicture.asset(AppAssets.notificationIcon,height: 20.h,),

                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    "Notifications",
                    style: AppTypography.kLight16.copyWith(
                      color: AppColors.kWhiteColor,
                    ),
                  ),
                  const Spacer(),
                  Obx(
                     () {
                      return SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: Transform.scale(
                          transformHitTests: false,
                              scale: .7,
                          child: CupertinoSwitch(
                            value: notificationPermission.value,
                            onChanged: (value) {
                              notificationPermission.value = value;
                            },
                            activeColor: AppColors.kSecondaryColor,
                          ),
                        ),
                      );
                    }
                  ),
                ]),
              ),
              const Spacer(),
              CustomButton(
                text: "Log Out",
                onTap: () {
                  auth.signOut();
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
