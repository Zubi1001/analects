import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';
import 'package:analects/repo/user_repo.dart';

class AnalectsRepo {
  final _db = DatabaseService();
  UserModel? get _currentUser => Get.find<UserController>().currentUser!;

  Future<void> postAnalects(
      {required String audioFilePath,
      required File analectImage,
      required String category,
      required String analectName}) async {
    LoadingConfig.showLoading();
    try {
      final file = File(audioFilePath);
      final audioUrl = await FirebaseStorageService.uploadToStorage(
          file: file, folderName: 'analects/${_currentUser!.id}');
      final imageUrl = await FirebaseStorageService.uploadToStorage(
          file: analectImage,
          folderName: 'analects/${_currentUser!.id}',
          imageName: "analects_cover");
      final analectModel = AnalectModel(
          analectId: "",
          creatorId: _currentUser!.id,
          creatorName: _currentUser!.name,
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
            creatorId: _currentUser!.id,
            creatorName: _currentUser!.name,
            analectName: analectName,
            category: category,
            image: imageUrl,
            audioUrl: audioUrl,
            noOfListen: '',
            noOfView: '');

        await _db.analectsCollection.doc(value.id).update(analectModel1.toMap());
        await UserRepo().incrementAnalects(uid: _currentUser!.id);
      
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }
}
