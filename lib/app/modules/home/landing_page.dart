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
                    Text('Hey ${userName == "" ? "User": userName}!', style: AppTypography.kExtraBold20),
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
                      onTap: () => Get.to(() => const Discover()),
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
                child: HorizontalScrollView(
                  topLabelCheck: true,
                ),
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
                  child: const CatagoriesScrollView()),
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
              Obx(
                () {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: controller.newestAnalectList.length,
                    itemBuilder: (context, index) {
                      return AnalectsListViewItem(analectData: controller.newestAnalectList[index],);
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
