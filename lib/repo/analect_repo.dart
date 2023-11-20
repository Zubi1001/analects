import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';

class AnalectsRepo {
  final _db = DatabaseService();
  String get _currentUid => Get.find<UserController>().currentUser!.id;

  Future<void> postAnalects(
      {required String audioFilePath,
      required File analectImage,
      required String category,
      required String analectName}) async {
    LoadingConfig.showLoading();
    try {
      final file = File(audioFilePath);
      final audioUrl = await FirebaseStorageService.uploadToStorage(
          file: file, folderName: 'analects/$_currentUid');
      final imageUrl = await FirebaseStorageService.uploadToStorage(
          file: analectImage,
          folderName: 'analects/$_currentUid',
          imageName: "analects_cover");
      final analectModel = AnalectModel(
          analectId: "",
          creatorId: _currentUid,
          analectName: analectName,
          category: category,
          image: imageUrl,
          audioUrl: audioUrl,
          noOfListen: '',
          noOfView: '');
      await _db.analectsCollection
          .add(analectModel
              //   {
              //   "url": audioUrl,
              //   "image": imageUrl,
              //   "category": category,
              //   "analectName": analectName,
              //   "creatorId": _currentUid,
              // }
              )
          .then((value) async {
        String tempId = value.id;
        log("tempId is $tempId");
        final analectModel1 = AnalectModel(
            analectId: value.id,
            creatorId: _currentUid,
            analectName: analectName,
            category: category,
            image: imageUrl,
            audioUrl: audioUrl,
            noOfListen: '',
            noOfView: '');

        await _db.usersCollection.doc(value.id).update(analectModel1.toMap());
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }
}
