import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/repo/user_repo.dart';

import '../widgets/dialogs/custom_toast.dart';

class UserEditProfilePage extends StatelessWidget {
  UserEditProfilePage({super.key});

  final user = Get.find<UserController>().currentUser;

  final _formKey = GlobalKey<FormState>();
  final pickedFile = Rxn<File?>();


  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user!.name);
    final bioController = TextEditingController(text: user!.creatorBio);
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: CustomAppBar(
        title: "Profile",
        backgroundColor: AppColors.noColor,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SvgPicture.asset(AppAssets.moreIcon),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          width: context.width,
          height: context.height,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Select option',
                        backgroundColor: AppColors.kPrimary1Color,
                        titleStyle: const TextStyle(
                          color: AppColors.kWhiteColor,
                        ),
                        content: SizedBox(
                          width: 270.w,
                          height: 130.h,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  Get.back();
                                  pickedFile.value = await ImagePickerService
                                      .getImageFromCamera();
                                },
                                child: Container(
                                  width: context.width,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 20.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.kSecondaryColor,
                                    borderRadius: BorderRadius.circular(
                                      20.r,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.camera_alt,
                                        color: AppColors.kWhiteColor,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Take using camera",
                                        style: AppTypography.kLight16.copyWith(
                                          color: AppColors.kWhiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              InkWell(
                                onTap: () async {
                                  Get.back();
                                  pickedFile.value = await ImagePickerService
                                      .getImageFromGallery();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 20.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.kSecondaryColor,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.photo_album_rounded,
                                        color: AppColors.kWhiteColor,
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Pick from gallery",
                                        style: AppTypography.kLight16.copyWith(
                                          color: AppColors.kWhiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: user!.profileImage,
                        imageBuilder: (context, imageProvider) {
                          return Obx(() {
                            return CircleAvatar(
                              radius: 50.r,
                              backgroundImage: pickedFile.value == null
                                  ? imageProvider
                                  : FileImage(pickedFile.value!),
                              child: CircleAvatar(
                                radius: 15.h,
                                backgroundColor:
                                    AppColors.kPrimary1Color.withOpacity(.5),
                                child: SvgPicture.asset(
                                  AppAssets.cameraIcon,
                                  width: 16.w,
                                  height: 14.h,
                                ),
                              ),
                            );
                          });
                        },
                        placeholder: (context, url) {
                          return CircleAvatar(
                            radius: 50.r,
                            backgroundColor: AppColors.kSecondaryColor,
                            child: Text(
                              user!.name.isEmpty
                                  ? "A"
                                  : user!.name[0].toUpperCase(),
                              style: AppTypography.kBold18.copyWith(
                                  color: AppColors.kWhiteColor,
                                  fontSize: 36.sp),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return CircleAvatar(
                            radius: 50.r,
                            backgroundColor: AppColors.kSecondaryColor,
                            backgroundImage: pickedFile.value == null
                                ? null
                                : FileImage(pickedFile.value!),
                            child: pickedFile.value == null
                                ? Text(
                                    user!.name.isEmpty
                                        ? "A"
                                        : user!.name[0].toUpperCase(),
                                    style: AppTypography.kBold18.copyWith(
                                        color: AppColors.kWhiteColor,
                                        fontSize: 36.sp),
                                  )
                                : null,
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Name",
                    style: AppTypography.kLight16.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(.3),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomTextField(
                    controller: nameController,
                    hintText: "Name",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Email",
                    style: AppTypography.kLight16.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(.3),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  AbsorbPointer(
                    absorbing: true,
                    child: CustomTextField(
                      controller: TextEditingController(text: user!.email),
                      hintText: "Email",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (user!.creator) ...[
                    Text(
                      "Creator Bio",
                      style: AppTypography.kLight16.copyWith(
                        color: AppColors.kWhiteColor.withOpacity(.3),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomTextField(
                      maxlines: 5,
                      controller: bioController,
                      hintText: "Creator Bio",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Creator Bio';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Change Password",
                      style: AppTypography.kLight16.copyWith(
                        color: AppColors.kBlueColor,
                      ),
                    ),
                  ),
                  user!.creator
                      ? SizedBox(height: 30.h)
                      : SizedBox(height: 270.h),
                  CustomButton(
                    text: "Save",
                    onTap: () async {
                      log(nameController.text);
                      await UserRepo().updateNameAndBio(
                        name: nameController.text,
                        bio: bioController.text,
                      );
                      if (pickedFile.value != null) {
                        await UserRepo()
                            .updateProfilePhoto(photo: pickedFile.value!);
                      }
                      showToast('Profile updated');
                      Get.find<UserController>().update();
                      Get.offAll(()=> AuthWrapper());
                    },
                    buttonColor: AppColors.kSecondaryColor,
                    width: 315.w,
                    height: 64.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
