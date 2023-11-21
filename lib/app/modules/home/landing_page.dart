import 'package:analects/app/data/contents/app_analect_categories.dart';
import 'package:analects/app/modules/home/components/catagories_scroll_view_item.dart';
import 'package:analects/controller/home_controller.dart';

import '../widgets/widget_imports.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  final _user = Get.find<UserController>().currentUser!;
  String? get userName => _user.name;
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hey ${userName == "" ? "User" : userName}!',
                        style: AppTypography.kExtraBold20),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.sp,
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
                      onTap: () => Get.to(() =>  Discover()),
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
                    child: ListView.builder(
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
                      return  CatagoriesScrollViewItem(category: AnalectCategories.values[index].name,);
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
                return ListView.builder(
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
