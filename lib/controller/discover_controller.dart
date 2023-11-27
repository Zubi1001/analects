import 'package:analects/app/modules/widgets/widget_imports.dart';

import 'package:analects/models/discover_category_model.dart';

import '../app/data/contents/app_analect_categories.dart';

class DiscoverController extends GetxController {
  final _discoverList = Rx<List<DiscoverCategoryModel?>>([]);
  List<DiscoverCategoryModel?> get discoverList => _discoverList.value;
  
  final _db = DatabaseService();

  Future<List<UserModel>> getCreatorByCategory(
      AnalectCategories analectCaegory) async {
    var results = await _db.userCollection
        .where("category", isEqualTo: analectCaegory.name.toString())
        .where("creator" , isEqualTo: true)
        .get();
    return results.docs.map((e) => e.data()!).toList();
  }


  Future<List<DiscoverCategoryModel>> getDiscoverCategory() async {
    LoadingConfig.showLoading();
    try {

      List<DiscoverCategoryModel> discoverCategoryList = [];
      var lists = await Future.wait(List.generate(
              AnalectCategories.values.length,
              (index) => getCreatorByCategory(AnalectCategories.values[index]))
          .toList());
      for (int i = 0; i < AnalectCategories.values.length; i++) {
        discoverCategoryList.add(DiscoverCategoryModel(
            category: AnalectCategories.values[i], users: lists[i]));
      }
      
      LoadingConfig.hideLoading();
      update();
      return discoverCategoryList;
    

    } on Exception catch (e) {
      LoadingConfig.hideLoading();
      log(e.toString());
      return [];
    }
  }

  @override
  void onReady() async {
    _discoverList.value = await getDiscoverCategory();
    super.onReady();
  }

  @override
  void onClose() {
    _discoverList.close();
    super.onClose();
  }
}
