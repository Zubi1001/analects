import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';

class CreatorProfileController extends GetxController {
  final user = Get.find<UserController>().currentUser;
   final _analectList = Rx<List<AnalectModel?>>([]);

  List<AnalectModel?> get analectList => _analectList.value;
  final _db = DatabaseService();


  Stream<List<AnalectModel?>> _creatorsAnalects() {
    return _db.analectsCollection.where("creatorId", isEqualTo: user!.id)
        .snapshots()
        .map((event) {
          log("event  is ${event.docs.length}");
          return event.docs.map((e) => e.data()).toList();
        });
  }

  @override
  void onInit() {
    _analectList.bindStream(_creatorsAnalects());
    super.onInit();
  }
 
 @override
  void onClose() {
    _analectList.close();
    super.onClose();
  }
}