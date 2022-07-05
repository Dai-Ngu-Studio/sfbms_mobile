import 'dart:developer';

import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/models/fields.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/field_repository.dart';

class FieldRepositoryImpl implements FieldRepository {
  final _apiService = NetworkApiService();

  @override
  Future<Fields> getFields({required String idToken, String? odataSegment}) async {
    dynamic response = odataSegment == null
        ? await _apiService.getResponse(
            ApiEndPoint().field,
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          )
        : await _apiService.getResponse(
            "${ApiEndPoint().field}?$odataSegment",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          );

    log('FieldRepositoryImpl :: getFields :: response: $response');

    return Fields.fromJson(response);
  }

  @override
  Future<Field> getFieldByID({
    required String idToken,
    required int fieldID,
    required DateTime bookingDate,
    String? odataSegment,
  }) async {
    dynamic response = await _apiService.postResponse(
      "${ApiEndPoint().field}/$fieldID",
      header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
      body: Map<String, String>.from({"BookingDate": bookingDate.toUtc().toIso8601String()}),
      function: "SlotStatus",
      odataSegment: "\$expand=Slots,Feedbacks(\$expand=User)",
    );

    log('FieldRepositoryImpl :: getFieldByID :: response: $response');

    return Field.fromJson(response);
  }
}
