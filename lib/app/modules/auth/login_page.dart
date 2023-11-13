import '../widgets/widget_imports.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SafeArea(
        child: Form(
          key: _fromKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                SizedBox(
                  height: 50.h,
                ),
                Text('Login',
                    style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Log in to continue the app',
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
                  height: 30.h,
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
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  width: 343.w,
                  text: 'Log In',
                  onTap: () {
                    if (_fromKey.currentState!.validate()) {
                      Get.to(() => const LandingPage());
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
                    "Don't have an account?",
                    style: AppTypography.kLight14,
                  ),
                  CustomTextButton(
                      text: 'Sign Up',
                      textStyle: AppTypography.specialTextStyle,
                      onPressed: () {
                        //here we will navigate to the sign up page.
                        Get.to(() => SignUpPage());
                      },),
                ],),
              ],),
            ),
          ),
        ),
      ),
    );
  }
}
