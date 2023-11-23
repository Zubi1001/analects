import 'package:analects/app/modules/create_analects/create_analects.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/controller/creator_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CreatorProfilePage extends StatelessWidget {
  final UserModel? creatorData;
  CreatorProfilePage({super.key, required this.creatorData});

  final controller = Get.put(CreatorProfileController());
  final user = Get.find<UserController>().currentUser;

  @override
  Widget build(BuildContext context) {
    print("Total analects ${controller.analectList.length}");
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: CustomAppBar(
        title: "",
        backgroundColor: AppColors.noColor,
        actions: [
          PullDownButton(
              itemBuilder: (context) => [
                    PullDownMenuItem(
                      title: "Create Analects",
                      onTap: () {
                        if(user!.creator) Get.to(() => const CreateAnalects());
                      },
                    ),
                  ],
              position: PullDownMenuPosition.automatic,
              buttonBuilder: (context, show) => CupertinoButton(
                    onPressed: show,
                    padding: EdgeInsets.zero,
                    color: AppColors.noColor,
                    child: SvgPicture.asset(AppAssets.moreIcon),
                  )),
          // GestureDetector(
          //   onTap: () {
          //   },
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 30.w),
          //     child: SvgPicture.asset(AppAssets.moreIcon),
          //   ),
          // )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 120.w,
                    height: 120.w,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kSecondaryColor,
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(creatorData!.profileImage),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(creatorData!.name,
                    style: AppTypography.kBold24
                        .copyWith(color: AppColors.kWhiteColor)),
                SizedBox(height: 15.h),
                Text(
                  creatorData!.creatorBio,
                  style: AppTypography.kLight14.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(.3),
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15.h),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       UpDownText(
                        title: creatorData!.followers,
                        subtitle: "Followers",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: const VerticalDivider(
                          color: AppColors.kSecondaryColor,
                        ),
                      ),
                       UpDownText(
                        title: creatorData!.following,
                        subtitle: "Following",
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: const VerticalDivider(
                          color: AppColors.kSecondaryColor,
                        ),
                      ),
                       UpDownText(
                        title: creatorData!.analects.toString(),
                        subtitle: "Analects",
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    CustomButton(
                      text: "Follow",
                      onTap: () {},
                      width: 150.w,
                      buttonColor: AppColors.kWhiteColor,
                      textColor: AppColors.kSecondaryColor,
                      height: 55.h,
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Subscribe",
                      onTap: () {
                        Get.to(() =>  SubscriptionPage(creatorData: creatorData!,));
                      },
                      width: 150.w,
                      height: 55.h,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Playlist",
                      style: AppTypography.kBold16.copyWith(
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                    SvgPicture.asset(
                      AppAssets.searchIcon,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Obx(() {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: controller.analectList.length,
                    itemBuilder: (context, index) {
                      return AnalectsListViewItem(
                        analectData: controller.analectList[index],
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
