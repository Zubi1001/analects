import '../../widgets/widget_imports.dart';

class UpDownText extends StatelessWidget {
  final String title;
  final String subtitle;

  const UpDownText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTypography.kBold16.copyWith(
            color: AppColors.kWhiteColor,
          ),
        ),
        Text(
          subtitle,
          style: AppTypography.kExtraLight12.copyWith(
            color: AppColors.kWhiteColor.withOpacity(.3),
          ),
        ),
      ],
    );
  }
}
