import 'package:analects/app/data/contents/app_colors.dart';
import 'package:analects/app/modules/auth/login_page.dart';
import 'package:analects/app/modules/auth/sing_up_page.dart';
import 'package:analects/app/modules/widgets/button/custom_text_button.dart';
import 'package:analects/app/modules/widgets/button/login_signin_button.dart';
import 'package:analects/app/onboarding_page/components/on_boarding_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.kPrimaryColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeaderWidgetOfOnBoardingPage(),
                    SizedBox(height: 20.h),
                    Text('The Analects',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold)),
                    Text('Listen your favorite analects anytime',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 20.sp)),
                    SizedBox(height: 40.h),
                    LoginSignInCustomButton(
                        onTap: () {
                          Get.to(() => LoginPage());
                        },
                        text: 'Log In'),
                    SizedBox(height: 20.h),
                    CustomTextButton(
                        text: 'Sign Up',
                        onPressed: () {
                          Get.to(() => SignUpPage());
                        })
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
