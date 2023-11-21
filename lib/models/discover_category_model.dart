import 'package:analects/app/data/contents/app_analect_categories.dart';
import 'package:analects/app/modules/widgets/widget_imports.dart';

class DiscoverCategoryModel {
  final AnalectCategories category;
  final List<UserModel> users;

  DiscoverCategoryModel({required this.category, required this.users});
}
