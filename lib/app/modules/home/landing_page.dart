import 'package:analects/app/data/contents/app_analect_categories.dart';
import 'package:analects/app/modules/create_analects/create_analects.dart';
import 'package:analects/app/modules/home/components/catagories_scroll_view_item.dart';
import 'package:analects/app/modules/search/search.dart';
import 'package:analects/app/modules/setting/setting_page.dart';
import 'package:analects/controller/home_controller.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/widget_imports.dart';

// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final _user = Get.find<UserController>().currentUser!;
   UserModel get user => _user;
  final controller = Get.put(HomeController());
  bool filteredBySearch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      floatingActionButton: _user.creator
            ? const CreateAnalectFloatingButton()
            : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   
                    Text('Hey ${user.name == "" ? "User" : user.name}!',
                        style: AppTypography.kExtraBold20),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=>SearchPage());
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => SettingPage());
                      },
                      child: CircleAvatar(
                        radius: 20.w,
                        backgroundColor: AppColors.kSecondaryColor,
                        backgroundImage:
                            CachedNetworkImageProvider(_user.profileImage),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Top Creators', style: AppTypography.kExtraBold20),
                    InkWell(
                      onTap: () => Get.to(() => Discover()),
                      child: Text('See All',
                          style: AppTypography.specialTextStyle),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Obx(() {
                  return SizedBox(
                    height: 230.h,
                    child: controller.topCreatorList.isEmpty
                        ? Center(
                            child: Text(
                              "No Creator Found",
                              style: AppTypography.kBold16
                                  .copyWith(color: AppColors.kWhiteColor),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: controller.topCreatorList.length,
                            itemBuilder: (context, index) {
                              return HorizontalScrollViewItem(
                                labelButtonCheck: true,
                                creatorData: controller.topCreatorList[index]!,
                              );
                            },
                          ),
                  );
                }),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Catagories', style: AppTypography.kExtraBold20)
                    ]),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: SizedBox(
                  height: 80.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: AnalectCategories.values.length,
                    itemBuilder: (context, index) {
                      return CatagoriesScrollViewItem(
                        category: replaceUnderScoreWithSpace(
                            AnalectCategories.values[index].name),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Newest Analects', style: AppTypography.kExtraBold20)
                  ],
                ),
              ),
              Obx(() {
                return controller.newestAnalectList.isEmpty
                    ? Center(
                        child: Text(
                          "No Analects Found",
                          style: AppTypography.kBold16
                              .copyWith(color: AppColors.kWhiteColor),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.newestAnalectList.length,
                        itemBuilder: (context, index) {
                          return AnalectsListViewItem(
                            analectData: controller.newestAnalectList[index],
                          );
                        },
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateAnalectFloatingButton extends StatelessWidget {
  const CreateAnalectFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => const CreateAnalects());
        },
        backgroundColor: AppColors.kSecondaryColor,
        label: Row(
          children: [
            const Icon(CupertinoIcons.waveform, color: AppColors.kWhiteColor),
            SizedBox(width: 5.w,),
            Text(
              "Create Analect",
              style: AppTypography.kBold16.copyWith(
                  color: AppColors.kWhiteColor, fontSize: 14),
            ),
          ],
        ),
      );
  }
}

String replaceUnderScoreWithSpace(String str) {
  str = str.replaceAll("_", " ");
  return str;
}
