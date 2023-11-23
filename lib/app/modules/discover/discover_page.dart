import 'package:analects/controller/discover_controller.dart';
import '../widgets/widget_imports.dart';

class Discover extends StatelessWidget {
  Discover({super.key});

  final controller = Get.put(DiscoverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: const CustomAppBar(
        title: "Discover",
        backgroundColor: AppColors.noColor,
        actions: [],
      ),
      body: SafeArea(
        child: Obx(() {
          return ListView.separated(
            itemBuilder: (BuildContext context, index) {
              return Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            controller.discoverList[index]!.category.name
                                .capitalizeFirst
                                .toString(),
                            style: AppTypography.kExtraBold20),
                        InkWell(
                          onTap: () => Get.to(() => DiscoverDetailPage(
                                title: controller
                                    .discoverList[index]!.category.name
                                    .toString(),
                              )),
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
                    child: SizedBox(
                      height: 230.h,
                      child: controller.discoverList[index]!.users.isEmpty
                          ? Center(
                              child: Text(
                                "No data found",
                                style: AppTypography.kBold14
                                    .copyWith(color: AppColors.kWhiteColor),
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount:
                                  controller.discoverList[index]!.users.length,
                              itemBuilder: (context, i) {
                                return HorizontalScrollViewItem(
                                  labelButtonCheck: true,
                                  creatorData:
                                      controller.discoverList[index]!.users[i],
                                );
                              },
                            ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, index) {
              return SizedBox(
                height: 20.w,
              );
            },
            itemCount: controller.discoverList.length,
          );
        }),
      ),
    );
  }
}
