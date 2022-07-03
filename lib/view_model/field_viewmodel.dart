import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/models/fields.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/field_repository_impl.dart';

class FieldViewModel extends ChangeNotifier {
  final _fieldRepo = FieldRepositoryImpl();

  ApiResponse<Fields> fields = ApiResponse.loading();

  int currentPage = 0;
  int? totalPages;

  void _setFields(ApiResponse<Fields> response) {
    log(response.toString());
    fields = response;
    notifyListeners();
  }

  Future<bool?> getFields({
    required String idToken,
    bool isRefresh = false,
    int quantityToGet = 2, // size of array of field need to get
  }) async {
    try {
      var prevFields = fields.data?.fields; // previous request

      _setFields(ApiResponse.loading());

      if (isRefresh) {
        currentPage = 0;
      } else if (currentPage >= totalPages!) {
        // last page -> no more data -> return null to set loadNoData for refreshController
        _setFields(ApiResponse.completed(
          Fields(
            fields: prevFields,
            odataCount: totalPages,
          ),
        ));
        return null;
      }

      var response = await _fieldRepo.getFields(
        idToken: idToken,
        odataSegment:
            "\$count=true&\$skip=${quantityToGet * currentPage}&\$top=$quantityToGet&\$expand=Slots,Category",
      );

      if (isRefresh) {
        _setFields(ApiResponse.completed(response));
      } else {
        if (response.fields!.isNotEmpty) {
          var tempFields = Fields(
            fields:
                prevFields == null ? [...response.fields!] : [...prevFields, ...response.fields!],
            odataCount: response.odataCount,
          );
          _setFields(ApiResponse.completed(tempFields));
        }
      }

      currentPage += 1;

      totalPages = (response.odataCount! / quantityToGet).ceil();
      return true;
    } catch (e) {
      _setFields(ApiResponse.error(e.toString()));
      rethrow;
    }
  }

  Field findFieldByID(int fieldID) {
    return fields.data!.fields!.firstWhere((field) => field.id == fieldID);
  }
}
