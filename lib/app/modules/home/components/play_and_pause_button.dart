import 'package:analects/app/data/contents/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Container(
      height: height ?? 50.h,
      width: width ?? 50.h,
      decoration: const BoxDecoration(
          color: AppColors.kButtonColor, shape: BoxShape.circle),
      child: IconButton(
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            color: AppColors.kWhiteColor,
          ),
          onPressed: onPressed),
    );
  }
}
