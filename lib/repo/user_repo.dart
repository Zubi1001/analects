import '../app/modules/widgets/widget_imports.dart';

class UserRepo {
  final _db = DatabaseService();
  String get _currentUid => Get.find<UserController>().currentUser!.id;

  Future<void> updateNameAndBio(
      {required String name, required String bio}) async {
    LoadingConfig.showLoading();
    try {
      await _db.userCollection
          .doc(_currentUid)
          .update({'name': name, 'creatorbio': bio});
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }

  Future<void> updateProfilePhoto({required File photo}) async {
    LoadingConfig.showLoading();
    try {
      final url = await FirebaseStorageService.uploadToStorage(
        file: photo,
        folderName: StorageFolderNames.userFolder(_currentUid),
      );
      await _db.userCollection.doc(_currentUid).update({'profileImage': url});
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }

  Future<void> incrementAnalects({required String uid}) async {
    LoadingConfig.showLoading();
    try {
      _db.userCollection.doc(_currentUid).update({
        "analects": FieldValue.increment(1),
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }

  Future<void> decrementAnalects({required String uid}) async {
    LoadingConfig.showLoading();
    try {
      _db.userCollection.doc(_currentUid).update({
        "analects": FieldValue.increment(-1),
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }


  Future<void> addBioAndCategory(
      {required String bio, required String category, required String creatorSubs}) async {
    LoadingConfig.showLoading();
    try {
      await _db.userCollection
          .doc(_currentUid)
          .update({'creatorBio': bio,'category': category,"creatorSubs":creatorSubs});
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }
}

class StorageFolderNames {
  static String userFolder(String uid) => 'Users/$uid';
}
