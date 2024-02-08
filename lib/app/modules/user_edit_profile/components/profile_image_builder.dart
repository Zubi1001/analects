

import '../../widgets/widget_imports.dart';

class ProfileImageBuilder extends StatelessWidget {
  final double? radius;
  final File? imagePicked;
  const ProfileImageBuilder({super.key, this.radius, this.imagePicked});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return CachedNetworkImage(
        imageUrl: controller.currentUser!.profileImage,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: radius ?? 50.r,
            backgroundImage:
                imagePicked == null ? imageProvider : FileImage(imagePicked!),
          );
        },
        placeholder: (context, url) {
          return CircleAvatar(
            radius: radius ?? 50.r,
            backgroundColor: AppColors.kSecondaryColor,
            child: Text(
              controller.currentUser!.name.isEmpty
                  ? "A"
                  : controller.currentUser!.name[0].toUpperCase(),
              style: AppTypography.kBold18
                  .copyWith(color: AppColors.kWhiteColor, fontSize: 36.sp),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return CircleAvatar(
            radius: radius ?? 50.r,
            backgroundColor: AppColors.kSecondaryColor,
            backgroundImage:
                imagePicked == null ? null : FileImage(imagePicked!),
            child: imagePicked == null
                ? Text(
                    controller.currentUser!.name.isEmpty
                        ? "A"
                        : controller.currentUser!.name[0].toUpperCase(),
                    style: AppTypography.kBold18
                        .copyWith(color: AppColors.kWhiteColor, fontSize: 36.sp),
                  )
                : null,
          );
        },
      );
    });
  }
}
