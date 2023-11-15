
import 'package:analects/controller/auth_controller.dart';
import 'package:analects/controller/user_controller.dart';
import 'package:analects/services/auth_service.dart';

import '../app/modules/widgets/widget_imports.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({super.key});

  final authController = Get.put<AuthController>(AuthController());

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
            return const LandingPage();
          }
        }
      },
    );
  }
}