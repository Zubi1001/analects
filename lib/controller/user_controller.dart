import '../app/modules/widgets/widget_imports.dart';
import '../services/notifications_services.dart';

class UserController extends GetxController {
  final db = DatabaseService();
  final _ac = Get.find<AuthController>();
  final Rxn<UserModel?> _firebaseUser = Rxn<UserModel?>();
  UserModel? get currentUser => _firebaseUser.value;

 DocumentReference get currentUserReference =>
      db.userCollection.doc(_ac.user!.uid);
      
  Stream<UserModel?> get _currentUserStream {
    log("uid is ${_ac.user!.uid}");
    return db.userCollection.doc(_ac.user!.uid).snapshots().map((event) {
      return event.data()!;
    });
  }

  @override
  void onInit() {
    _firebaseUser.bindStream(_currentUserStream);
    once(
      _firebaseUser,
      (value) async {
        NotificationService().init();
      },
    );
    super.onInit();
  }

  @override
  void onClose() {
    _firebaseUser.close();
    super.onClose();
  }
}
