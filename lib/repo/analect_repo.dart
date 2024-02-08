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
          file: file,
          folderName:
              'analects/${_currentUser!.id}/${analectName + DateTime.now().millisecondsSinceEpoch.toString()}',
          fileName: 'audio_${analectName + DateTime.now().millisecondsSinceEpoch.toString()}');
      final imageUrl = await FirebaseStorageService.uploadToStorage(
          file: analectImage,
          folderName: 'analects/${_currentUser!.id}',
          fileName:
              "analects_cover_${analectName + DateTime.now().millisecondsSinceEpoch.toString()}");
      final analectModel = AnalectModel(
        analectId: "",
        creatorId: _currentUser!.id,
        creatorName: _currentUser!.name,
        analectName: analectName,
        category: category,
        image: imageUrl,
        audioUrl: audioUrl,
        noOfListen: 0,
        noOfView: 0,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      await _db.analectsCollection.add(analectModel).then((value) async {
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
          noOfListen: 0,
          noOfView: 0,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        );

        await _db.analectsCollection
            .doc(value.id)
            .update(analectModel1.toMap());
        await UserRepo()
            .incrementAnalectsAndChangeUserCategoryWithAnalectCreation(
                uid: _currentUser!.id, category: category);
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }

  Future<void> incrementAnalectViewAndListenCount(
      {required String analectId}) async {
    LoadingConfig.showLoading();
    try {
      _db.analectsCollection.doc(analectId).update({
        "noOfView": FieldValue.increment(1),
        "noOfListen": FieldValue.increment(1),
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }

  Future<void> incrementAnalectView({required String analectId}) async {
    LoadingConfig.showLoading();
    try {
      _db.analectsCollection.doc(analectId).update({
        "noOfView": FieldValue.increment(1),
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }

  Future<void> incrementListenCount({required String analectId}) async {
    LoadingConfig.showLoading();
    try {
      _db.analectsCollection.doc(analectId).update({
        "noOfListen": FieldValue.increment(1),
      });
      LoadingConfig.hideLoading();
    } catch (e) {
      LoadingConfig.hideLoading();
      showErrorDialog(e.toString());
    }
  }
}
