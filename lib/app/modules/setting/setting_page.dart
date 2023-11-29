import 'package:analects/app/modules/creator_subscription/creator_subscription.dart';
import 'package:analects/app/modules/user_edit_profile/user_edit_profile.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:flutter/cupertino.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  UserModel get user => Get.find<UserController>().currentUser!;
  final auth = AuthService();
  final notificationPermission = RxBool(false);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: CustomAppBar(
          title: "Setting",
          backgroundColor: AppColors.noColor,
          actions: [
            GestureDetector(
              onTap: () async {
                await Get.to(() => UserEditProfilePage());
                Get.find<UserController>().update();
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
                  backgroundImage:
                      CachedNetworkImageProvider(user.profileImage),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  user.name == "" ? "User" : user.name,
                  style: AppTypography.kBold24.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
                ),
                if (user.creator) ...[
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: 110.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    decoration: BoxDecoration(
                        color: AppColors.kBlueColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.subscriptionIcon,
                          height: 15.h,
                          width: 15.w,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "Creator",
                          style: AppTypography.kLight14
                              .copyWith(color: AppColors.kWhiteColor),
                        ),
                      ],
                    ),
                  )
                ],
                SizedBox(
                  height: 30.h,
                ),
                CustomButton(
                  text: user.creator
                      ? "See Your Creator Profile"
                      : "Become a Creator",
                  onTap: () {
                    user.creator
                        ? Get.to(() => CreatorProfilePage(creatorId: user.id))
                        : Get.to(() => const CreatorSubscriptionPage());
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimary1Color,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.notificationIcon,
                        height: 20.h,
                      ),
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
                        },
                      ),
                    ],
                  ),
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
    });
  }
}
