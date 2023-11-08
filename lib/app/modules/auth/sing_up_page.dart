import 'package:analects/app/data/contents/app_assets.dart';
import 'package:analects/app/data/contents/app_colors.dart';
import 'package:analects/app/data/contents/app_typography.dart';
import 'package:analects/app/modules/auth/components/cutsom_text_filed.dart';
import 'package:analects/app/modules/widgets/button/custom_text_button.dart';
import 'package:analects/app/modules/widgets/button/login_signin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _confirmPassFocusNode = FocusNode();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 20.h,
                ),
                Text('Sing Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Sing up to continue the app',
                  style: AppTypography.kLight14,
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: 343.w,
                  child: CustomTextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    hintText: 'Email address',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 343.w,
                  child: CustomTextField(
                    isPasswordField: true,
                    controller: _passwordController,
                    hintText: 'Password',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _passwordFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 343.w,
                  child: CustomTextField(
                    isPasswordField: true,
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _confirmPassFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                LoginSignInCustomButton(
                  width: 343.w,
                  text: 'Sign Up',
                  onTap: () {
                    if (_fromKey.currentState!.validate()) {
                      print('Email: ${_emailController.text}');
                      print('Password: ${_passwordController.text}');
                    }
                  },
                ),
                SizedBox(height: 120.h),
                Text(
                  'or log in with',
                  style: AppTypography.kLight18,
                ),
                SizedBox(height: 40.h),
                Row(
                  children: [
                    SizedBox(width: 120.w),
                    SvgPicture.asset(AppAssets.loginWithIPhone, width: 50.w),
                    SizedBox(width: 50.w),
                    SvgPicture.asset(AppAssets.loginWithGoogle, width: 65.w),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(children: [
                  SizedBox(width: 100.w),
                  Text(
                    "Already have an account?",
                    style: AppTypography.kLight14,
                  ),
                  CustomTextButton(
                      text: 'Log in',
                      textStyle: AppTypography.specialTextStyle,
                      onPressed: () {
                        Get.back();
                      }),
                ]),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
