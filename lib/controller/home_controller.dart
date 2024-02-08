import 'package:analects/models/analect_model.dart';

import '../app/modules/widgets/widget_imports.dart';

class HomeController extends GetxController {
  final _topCreatorAnalectList = Rx<List<UserModel?>>([]);
  final _newestAnalectList = Rx<List<AnalectModel?>>([]);

  List<UserModel?> get topCreatorList => _topCreatorAnalectList.value;
  List<AnalectModel?> get newestAnalectList => _newestAnalectList.value;

  final _db = DatabaseService();

  Stream<List<UserModel?>> _topCreators() {
    return _db.userCollection
        .where("creator", isEqualTo: true)
        .snapshots()
        .map((event) {
      log("event  is ${event.docs.length}");
      return event.docs.map((e) => e.data()).toList();
    });
  }

  Stream<List<AnalectModel?>> _newestAnalects() {
    return _db.analectsCollection
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _topCreatorAnalectList.bindStream(_topCreators());
    _newestAnalectList.bindStream(_newestAnalects());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _topCreatorAnalectList.close();
    _newestAnalectList.close();
    super.onClose();
  }
}
