import '../../widgets/widget_imports.dart';

class PlayAndPauseButton extends StatelessWidget {
  const PlayAndPauseButton(
      {super.key,
      required this.onPressed,
      this.isPlaying = false,
      this.height,
      this.width});
  final bool isPlaying;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 50.h,
        width: width ?? 50.h,
        decoration: const BoxDecoration(color: AppColors.kSecondaryColor, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(isPlaying ? AppAssets.playButton : AppAssets.pauseButton,),
        ),
      ),
    );
  }
}
