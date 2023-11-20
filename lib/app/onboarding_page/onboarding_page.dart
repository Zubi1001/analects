

import '../modules/widgets/widget_imports.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(

        child: Center(
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
                  CustomButton(
                      onTap: () {
                        Get.to(
                      () => LoginPage(),
                    );
                  },
                      text: 'Log In'),
                  SizedBox(height: 20.h),
                  CustomTextButton(
                      text: 'Sign Up',
                      onPressed: () {
                        Get.to(
                      () => SignUpPage(),
                    );
                  })
                ]),
          ),
        ),
      ),
    );
  }
}
