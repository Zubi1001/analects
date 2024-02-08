import '../widgets/widget_imports.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        body: SafeArea(
          child: Form(
            key: _fromKey,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Column(
                    children: [
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
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email';
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
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            final passwordResetEmailController =
                                TextEditingController();
                            Get.defaultDialog(
                              titlePadding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 20.w),
                              title:
                                  'Enter your email address for password reset',
                              backgroundColor: AppColors.kPrimary1Color,
                              titleStyle: AppTypography.kMedium16.copyWith(
                                color: AppColors.kWhiteColor,
                              ),
                              content: SizedBox(
                                width: 270.w,
                                height: 140.h,
                                child: Column(
                                  children: [
                                    CustomTextField(
                                      controller: passwordResetEmailController,
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
                                    SizedBox(height: 20.h),
                                    CustomButton(
                                      text: "Send",
                                      width: 200.w,
                                      height: 40.h,
                                      onTap: () {
                                        if (passwordResetEmailController
                                            .text.isEmpty) {
                                          showToast("Email is required");
                                          return;
                                        } else {
                                          authService.sendPasswordResetEmail(
                                              passwordResetEmailController
                                                  .text);
                                          Get.back();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: AppTypography.kLight16.copyWith(
                              color: AppColors.kBlueColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h),
                      CustomButton(
                        width: 343.w,
                        text: 'Log In',
                        onTap: () async {
                          if (_fromKey.currentState!.validate()) {
                            await authService.signInWithEmail(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset(AppAssets.loginWithIPhone,
                          //     width: 50.w),
                          // SizedBox(width: 50.w),
                          InkWell(
                              onTap: () => authService.signInWithGoogle(),
                              child: SvgPicture.asset(AppAssets.loginWithGoogle,
                                  width: 65.w)),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: AppTypography.kLight14,
                          ),
                          CustomTextButton(
                            text: 'Sign Up',
                            textStyle: AppTypography.specialTextStyle,
                            onPressed: () {
                              Get.to(() => SignUpPage());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
