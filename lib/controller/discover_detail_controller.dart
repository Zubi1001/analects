import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/models/analect_model.dart';

class DiscoverDetailController extends GetxController{
  final _discoverDetailList = Rx<List<AnalectModel?>>([]);
  List<AnalectModel?> get discoverDetailList => _discoverDetailList.value;


  Future<List<AnalectModel>> getAnalectsByCategory({String? category}) async {
    log(category.toString());
    var results = await DatabaseService().analectsCollection.where("category", isEqualTo: category.toString()).get();
    return _discoverDetailList.value = results.docs.map((e) => e.data()!).toList();
  }

}