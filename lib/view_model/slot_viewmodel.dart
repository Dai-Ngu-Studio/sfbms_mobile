import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/slot.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/slot_repository_impl.dart';

class SlotViewModel extends ChangeNotifier {
  final _slotRepo = SlotRepositoryImpl();

  ApiResponse<List<Slot>> slots = ApiResponse.loading();

  void _setFields(ApiResponse<List<Slot>> response) {
    log(response.toString());
    slots = response;
    notifyListeners();
  }

  Future getSlotsByFieldID({required String idToken, required int fieldID}) async {
    try {
      _setFields(ApiResponse.loading());

      var response = await _slotRepo.getSlotsByFieldID(idToken: idToken, fieldID: fieldID);

      _setFields(ApiResponse.completed(response));
    } catch (e) {
      _setFields(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
