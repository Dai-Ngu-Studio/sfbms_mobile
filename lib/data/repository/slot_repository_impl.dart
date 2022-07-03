import 'dart:developer';

import 'package:sfbms_mobile/data/models/slot.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/slot_repository.dart';

class SlotRepositoryImpl implements SlotRepository {
  final _apiService = NetworkApiService();

  @override
  Future<List<Slot>> getSlotsByFieldID({required String idToken, required int fieldID}) async {
    dynamic response = await _apiService.getResponse(
      "${ApiEndPoint().slot}?\$filter=fieldId eq $fieldID",
      header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
    );

    log('SlotRepositoryImpl :: getSlotsByFieldID :: response: $response');

    var listSlot = <Slot>[];

    for (var feedback in response["value"]) {
      listSlot.add(Slot.fromJson(feedback));
    }

    return listSlot;
  }
}
