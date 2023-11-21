import 'package:analects/app/modules/widgets/widget_imports.dart';


class CatagoriesScrollViewItem extends StatelessWidget {
  final String category;
  const CatagoriesScrollViewItem({required this.category, super.key});
  
  String get _category => category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => DiscoverDetailPage(title: _category));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(6.h),
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.kWhiteColor.withOpacity(0.1),
        ),
        height: 80.h,
        child:  Text(_category.capitalize.toString(), style: AppTypography.kBold14),
      ),
    );
  }
}
