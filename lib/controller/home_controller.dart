import 'package:analects/models/analect_model.dart';

import '../app/modules/widgets/widget_imports.dart';

class HomeController extends GetxController{

  final _newestAnalectList =  Rx<List<AnalectModel?>>([]);

  List<AnalectModel?> get newestAnalectList => _newestAnalectList.value;
  final db = DatabaseService();

  Stream<List<AnalectModel?>> _newestAnalects(){
    return db.analectsCollection.snapshots().map((event) => event.docs.map((e) => e.data()).toList());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    _newestAnalectList.bindStream(_newestAnalects());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    _newestAnalectList.close();
    super.onClose();
  }

}