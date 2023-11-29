import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/services/search_service.dart';

// ignore: must_be_immutable
class SearchPage extends GetWidget<AppSearchController> {
  SearchPage({super.key});
  final sc = Get.put(AppSearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.kPrimaryColor,
          appBar: const CustomAppBar(
            title: "Search",
            backgroundColor: AppColors.noColor,
            actions: [],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                TextFormField(
                  style: AppTypography.kBold14.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: AppTypography.kBold14.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.kWhiteColor.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: AppColors.kPrimary1Color,
                  ),
                  onChanged: (value) async {
                    controller.searchedText.value = value;
                  },
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 230.h,
                        child: HorizontalScrollViewItem(
                          labelButtonCheck: true,
                          creatorData: controller.searchResults[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
