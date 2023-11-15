import '../../modules/widgets/widget_imports.dart';

class HeaderWidgetOfOnBoardingPage extends StatelessWidget {
  const HeaderWidgetOfOnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450.h,
        width: 300.w,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          // color: AppColors.kSecondaryColor,
          image: DecorationImage(
              image: AssetImage(AppAssets.onBoardingHeaderImages), fit: BoxFit.fitWidth),
        ),);
  }
}
