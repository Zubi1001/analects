import 'package:analects/app/modules/widgets/dialogs/loader_dialog.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';

class AnalectsRepo {
  final _db = DatabaseService();
  String get _currentUid => Get.find<UserController>().currentUser!.id;

  Future<void> postAnalects({required String audioFilePath, required File analectImage, required String category, required String analectName}) async {
    LoadingConfig.showLoading();
    try {
      final file = File(audioFilePath);
      final audioUrl = await FirebaseStorageService.uploadToStorage(file: file, folderName: 'analects/$_currentUid');
      final imageUrl = await FirebaseStorageService.uploadToStorage(file: analectImage, folderName: 'analects/$_currentUid',imageName: "analects_cover");
      await _db.analectsCollection.doc().set({
        "url": audioUrl,
        "image": imageUrl,
        "category": category,
        "analectName": analectName,
        "creatorId": _currentUid,
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      // showErrorDialog(e.toString());
    }
  }
}
