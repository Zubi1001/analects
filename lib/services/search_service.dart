import 'package:analects/app/modules/widgets/widget_imports.dart';
import 'package:analects/services/algolia_search.dart';

class AppSearchController extends GetxController {
  var searchedText = "".obs;
  var searchResults= <UserModel>[].obs;
  final _algoliaApplication = AlgoliaApplication();
  Future<List<UserModel>> filterUsersBySearch(String query) async {
    final results =
        await _algoliaApplication.getSearchResult(query, SearchType.users);
    searchResults.value= results.map((e) => UserModel.fromMap(e.data)).toList();
    return searchResults;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    debounce(searchedText, (callback) => filterUsersBySearch(callback), time: 500.milliseconds);
  }
}
