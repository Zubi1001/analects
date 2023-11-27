import '../widgets/widget_imports.dart';

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
  final AuthService authService = AuthService();

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
                  height: 20.h,
                ),
                Text('Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Sign up to continue the app',
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
                      if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email';
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
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
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
                        return 'Please enter your confirm password';
                      }
                      if (value != _passwordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 50.h),
                CustomButton(
                  width: 343.w,
                  text: 'Sign Up',
                  onTap: () async {
                    if (_fromKey.currentState!.validate()) {
                      await authService.signupWithEmail(
                          email: _emailController.text,
                          password: _passwordController.text);
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
                    InkWell(
                        onTap: () => authService.signInWithGoogle(),
                        child: SvgPicture.asset(AppAssets.loginWithGoogle, width: 65.w)),
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
