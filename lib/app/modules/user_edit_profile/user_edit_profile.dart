

import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/repo/user_repo.dart';

class UserEditProfilePage extends StatelessWidget {
  UserEditProfilePage({super.key});

  final user = Get.find<UserController>().currentUser;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            key : _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50.w,
                    backgroundImage:
                        CachedNetworkImageProvider(user!.profileImage),
                    child: CircleAvatar(
                      radius: 15.h,
                      backgroundColor: AppColors.kPrimary1Color.withOpacity(.5),
                      child: SvgPicture.asset(
                        AppAssets.cameraIcon,
                        width: 16.w,
                        height: 14.h,
                      ),
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
                  controller: TextEditingController(text: user!.name),
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
                if(user!.creator)...[
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
                  controller: TextEditingController(text: user!.creatorBio),
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
                
                const Spacer(),
                CustomButton(
                  text: "Save",
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      await UserRepo().updateNameAndBio(
                        name: user!.name,
                        creatorBio: user!.creatorBio,
                      );
                    }
                  },
                  buttonColor: AppColors.kSecondaryColor,
                  width: 315.w,
                  height: 64.h,
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
