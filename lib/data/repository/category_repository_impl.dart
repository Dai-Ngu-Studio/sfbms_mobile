import 'dart:developer';

import 'package:sfbms_mobile/data/models/category.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final _apiService = NetworkApiService();

  @override
  Future<List<Category>> getCategories({required String idToken}) async {
    dynamic response = await _apiService.getResponse(
      ApiEndPoint().category,
      isOdataApi: true,
      header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
    );

    log('CategoryRepositoryImpl :: getCategories :: response: $response');

    var listCategory = <Category>[];

    for (var category in response["value"]) {
      listCategory.add(Category.fromJson(category));
    }

    return listCategory;
  }
}
