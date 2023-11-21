import '../app/modules/widgets/widget_imports.dart';

class AuthService {
  final db = DatabaseService();
  final _auth = FirebaseAuth.instance;

  UserController get _uc => Get.find<UserController>();

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    LoadingConfig.showLoading();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      LoadingConfig.hideLoading();
      Get.put(UserController(), permanent: true);
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
      log(e.toString());
    }
  }

  Future<void> signupWithEmail(
      {required String email, required String password}) async {
    LoadingConfig.showLoading();
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final userModel = UserModel(
            id: value.user!.uid,
            email: email,
            name: "",
            creator: false,
            analects: '',
            category: '',
            );
        await db.userCollection.doc(userModel.id).set(userModel);
        Get.put(UserController(), permanent: true);
        Get.back();
        LoadingConfig.hideLoading();
      });
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
      log(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    LoadingConfig.showLoading();

    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
        ],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredentials =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredentials.user;
      log("userData  $user");
      if (user != null) {
        final doc = await db.userCollection.doc(user.uid).get();
        if (!doc.exists) {
          final userModel = UserModel(
            id: user.uid,
            name: user.displayName ?? "",
            email: user.email ?? "",
            profileImage: user.photoURL ?? "",
            creator: false,
            analects: '',
            category: '',
          );
          log("userData ${userModel.toMap().toString()}");
          await db.userCollection
              .doc(user.uid)
              .set(userModel)
              .then((value) {
            log("user data successfully added");
          });
        }
        Get.put(UserController(), permanent: true);
        Get.back();
        LoadingConfig.hideLoading();
      }
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
      log(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      Get.delete<UserController>(force: true);
    } catch (e) {
      showErrorDialog(e.toString());
      log(e.toString());
    }
  }
}
