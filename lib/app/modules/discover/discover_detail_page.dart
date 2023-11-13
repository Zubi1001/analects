import '../widgets/widget_imports.dart';

class DiscoverDetailPage extends StatelessWidget {
  const DiscoverDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar:    CustomAppBar(
        title: "Design",
        backgroundColor: AppColors.noColor,
        actions: [
          GestureDetector(
            onTap: () {
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SvgPicture.asset(AppAssets.searchIcon),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          scrollDirection: Axis.vertical,
          itemCount: 10,
          itemBuilder: (context, index) {
            return const AnalectsListViewItem();
          },
        ),
      ),
    );
  }
}
