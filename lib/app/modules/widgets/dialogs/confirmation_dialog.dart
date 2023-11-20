import 'package:analects/app/modules/widgets/widget_imports.dart';

class ConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final String? confirmationText;
  const ConfirmationDialog(
      {super.key, required this.onConfirm, this.confirmationText});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      content: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            gradient: const LinearGradient(
                colors: [AppColors.kPrimaryColor, AppColors.kPrimary1Color],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Glassmorphism(
          borderRadius: BorderRadius.circular(10.r),
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.w),
              Text(
                'Confirmation',
                style: AppTypography.kBold16
                    .copyWith(color: AppColors.kWhiteColor),
              ),
              Text(
                confirmationText ?? 'Are you sure you want to proceed?',
                style: AppTypography.kMedium14
                    .copyWith(color: AppColors.kWhiteColor, fontSize: 13),
              ),
              SizedBox(height: 20.h),
              Divider(height: 0.h, color: AppColors.kSecondaryColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Semantics(
                      button: true,
                      child: InkWell(
                        onTap: () {
                          Get.back<void>();
                        },
                        child: Container(
                          height: 50.0.h,
                          alignment: Alignment.center,
                          child: Text(
                            'Cancel',
                            style: AppTypography.kMedium14.copyWith(
                                color: AppColors.kWhiteColor, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.00.h,
                    width: 0.8.w,
                    color: AppColors.kSecondaryColor,
                  ),
                  Expanded(
                    child: Semantics(
                      button: true,
                      child: InkWell(
                        onTap: () {
                          onConfirm();
                        },
                        child: Container(
                          height: 50.01.h,
                          alignment: Alignment.center,
                          child: Text(
                            'Confirm',
                            style: AppTypography.kMedium14.copyWith(
                                color: AppColors.kSecondaryColor, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
