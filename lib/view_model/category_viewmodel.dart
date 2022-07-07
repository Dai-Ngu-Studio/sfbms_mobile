import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/category.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/category_repository_impl.dart';

class CategoryViewModel extends ChangeNotifier {
  final _categoryRepo = CategoryRepositoryImpl();

  ApiResponse<List<Category>> categories = ApiResponse.loading();

  void _setCategories(ApiResponse<List<Category>> response) {
    log(response.toString());
    categories = response;
    notifyListeners();
  }

  Future getCategories({required String idToken}) async {
    try {
      _setCategories(ApiResponse.loading());

      var response = await _categoryRepo.getCategories(idToken: idToken);

      _setCategories(ApiResponse.completed(response));
    } catch (e) {
      _setCategories(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
