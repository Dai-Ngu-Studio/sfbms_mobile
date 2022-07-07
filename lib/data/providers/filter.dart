import 'package:flutter/material.dart';

class Filter extends ChangeNotifier {
  String _searchValue = '';

  List<int> _categoriesID = [];

  List<int> get categories {
    return [..._categoriesID];
  }

  String get searchValue => _searchValue;

  void setCategory(List<int> listCategoryID) {
    _categoriesID = listCategoryID;
    notifyListeners();
  }

  void setSearchValue(String searchValue) {
    _searchValue = searchValue;
    notifyListeners();
  }

  void reset() {
    _categoriesID.clear();
    notifyListeners();
  }
}
