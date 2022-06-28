import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/fields.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/field_repository_impl.dart';

class FieldViewModel extends ChangeNotifier {
  final _fieldRepo = FieldRepositoryImpl();

  ApiResponse<Fields> fields = ApiResponse.loading();

  int currentPage = 1;
  int? totalPages;

  void _setFields(ApiResponse<Fields> response) {
    log(response.toString());
    fields = response;
    notifyListeners();
  }

  Future<bool?> getFields({
    required String idToken,
    bool isRefresh = false,
  }) async {
    try {
      var prevFields = fields.data?.fields;

      _setFields(ApiResponse.loading());

      if (isRefresh) {
        currentPage = 1;
      } else if (currentPage > (totalPages ?? 9999999)) {
        _setFields(ApiResponse.completed(
          Fields(
            fields: prevFields,
            numOfFieldPages: totalPages,
          ),
        ));
        return null;
      }

      var response = await _fieldRepo.getFields(
        idToken: idToken,
        odataSegment: "page=$currentPage&size=2",
      );

      if (isRefresh) {
        _setFields(ApiResponse.completed(response));
      } else {
        if (response.fields!.isNotEmpty) {
          var tempFields = Fields(
            fields:
                prevFields == null ? [...response.fields!] : [...prevFields, ...response.fields!],
            numOfFieldPages: response.numOfFieldPages,
          );
          _setFields(ApiResponse.completed(tempFields));
        }
      }

      currentPage += 1;

      totalPages = response.numOfFieldPages!;
      return true;
    } catch (e) {
      _setFields(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
