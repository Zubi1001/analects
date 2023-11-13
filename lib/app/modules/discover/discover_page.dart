import '../widgets/widget_imports.dart';

class Discover extends StatelessWidget {
  const Discover({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: CustomAppBar(
        title: "Discover",
        backgroundColor: AppColors.noColor,
        actions: [
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Design', style: AppTypography.kExtraBold20),
                    InkWell(
                      onTap: () => Get.to(() => const DiscoverDetailPage()),
                      child: Text('See All', style: AppTypography.specialTextStyle),
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
                    topLabelCheck: false,
                  )),
              // SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Marketing', style: AppTypography.kExtraBold20),
                    Text('See All', style: AppTypography.specialTextStyle),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: HorizontalScrollView(
                    topLabelCheck: false,
                  )),
              // SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Development', style: AppTypography.kExtraBold20),
                    Text('See All', style: AppTypography.specialTextStyle),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: HorizontalScrollView(
                    topLabelCheck: false,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
