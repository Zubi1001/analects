import '../widget_imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final bool hasBackButton;
  final Color backgroundColor, shadowColor, backColor;
  final double elevation;
  final bool centerTitle;
  final double fontSize;
    final VoidCallback? onBack;




  const CustomAppBar({
    Key? key,
    required this.title,
    required this.actions,
    this.backgroundColor = AppColors.kPrimaryColor,
    this.elevation = 0,
    this.shadowColor = AppColors.kPrimaryColor,
    this.centerTitle = true,
    this.backColor = AppColors.kWhiteColor,
    this.fontSize = 16.0,
    this.hasBackButton = false, 
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      leading: hasBackButton
          ? InkWell(
              onTap: onBack ?? () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.kWhiteColor,
              ),
            )
          : null,
      title: Text(
        title,
        style: AppTypography.kBold16.copyWith(fontSize: fontSize, color: AppColors.kWhiteColor),
      ),
      centerTitle: centerTitle,
      iconTheme: IconThemeData(
        color: backColor,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
