import 'package:analects/app/modules/widgets/widget_imports.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: const LinearGradient(
                  colors: [AppColors.kPrimaryColor, AppColors.kPrimary1Color],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Glassmorphism(
            borderRadius: BorderRadius.circular(10.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/animations/error.json',
                    height: 100.h, repeat: false),
                Text(
                  'Error',
                  style: AppTypography.kBold16
                      .copyWith(fontSize: 17)
                      .copyWith(color: AppColors.kWhiteColor),
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTypography.kMedium14
                      .copyWith(fontSize: 13)
                      .copyWith(color: AppColors.kWhiteColor),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  onTap: () {
                    Get.back<void>();
                  },
                  text: 'Okay',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showErrorDialog(String message) {
  Get.dialog(ErrorDialog(message: message));
}

void hideErrorDialog() {
  Get.back<void>();
}
