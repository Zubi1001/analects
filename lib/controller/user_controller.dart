import '../app/modules/widgets/widget_imports.dart';

class UserController extends GetxController {
  final db = DatabaseService();
  final _ac = Get.find<AuthController>();
  final Rxn<UserModel?> _firebaseUser = Rxn<UserModel?>();
  UserModel? get currentUser => _firebaseUser.value;
  DocumentReference get userReference => db.usersCollection.doc(_ac.user!.uid);

  Stream<UserModel?> get _currentUserStream {
    log("uid is ${_ac.user!.uid}");
    return userReference.snapshots().map((snapshot) =>
        UserModel.fromMap(snapshot.data()! as Map<String, dynamic>),);
  }

  @override
  void onInit() {
    _firebaseUser.bindStream(_currentUserStream);
    super.onInit();
  }

  @override
  void onClose() {
    _firebaseUser.close();
    super.onClose();
  }
}