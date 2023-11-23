import 'package:analects/controller/discover_detail_controller.dart';
import 'package:analects/models/analect_model.dart';

import '../widgets/widget_imports.dart';

class DiscoverDetailPage extends StatelessWidget {
  final String title;
  DiscoverDetailPage({super.key, required this.title});

  String get header => title;

  final controller = Get.put(DiscoverDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: CustomAppBar(
        title: header.capitalize.toString(),
        backgroundColor: AppColors.noColor,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SvgPicture.asset(AppAssets.searchIcon),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: DatabaseService()
              .analectsCollection
              .where("category", isEqualTo: header)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if(snapshot.data!.docs.isEmpty){
              return Center(
                child: Text(
                  "No data found",
                  style: AppTypography.kBold16
                      .copyWith(color: AppColors.kWhiteColor),
                ),
              );
            }

            if (snapshot.hasData) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  var data = document.data();
                  return AnalectsListViewItem(
                    analectData: data as AnalectModel?,
                  );
                }).toList(),
              );
            } else {
              return Center(
                child: Text(
                  "No data found",
                  style: AppTypography.kBold14
                      .copyWith(color: AppColors.kWhiteColor),
                ),
              );
            }
          },
          //  Obx(
          //    () {
          //     return ListView.builder(
          //       padding: EdgeInsets.symmetric(horizontal: 25.w),
          //       scrollDirection: Axis.vertical,
          //       itemCount: controller.discoverDetailList.length,
          //       itemBuilder: (context, index) {
          //         return AnalectsListViewItem(
          //           analectData: controller.discoverDetailList[index],
          //         );
          //       },
          //     );
          //   }
          // ),
        ),
      ),
    );
  }
}
