

import '../app/modules/widgets/widget_imports.dart';

class AuthController extends GetxController {
  final Rxn<User> _firebaseUser = Rxn<User>();
  User? get user => _firebaseUser.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }
}