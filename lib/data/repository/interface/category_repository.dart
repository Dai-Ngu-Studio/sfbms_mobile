import 'package:sfbms_mobile/data/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories({required String idToken});
}
