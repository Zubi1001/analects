import '../app/modules/widgets/widget_imports.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (authController.user == null) {
          return const OnBoardingPage();
        } else {
          if (!Get.isRegistered<UserController>()) {
            Get.put(UserController(), permanent: true);
          }
          final uc = Get.find<UserController>();
          if (uc.currentUser == null) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  TextButton(onPressed: AuthService().signOut, child: const Text('Sign Out')),
                ],
              ),
            );
          } else {
            return  LandingPage();
          }
        }
      },
    );
  }
}