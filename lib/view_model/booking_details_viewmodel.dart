import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/booking_repository_impl.dart';

class BookingDetailsViewModel extends ChangeNotifier {
  final _bookingRepo = BookingRepositoryImpl();

  ApiResponse<Booking> booking = ApiResponse.loading();

  int? count;

  void _setBooking(ApiResponse<Booking> response) {
    log(response.toString());
    booking = response;
    notifyListeners();
  }

  Future<bool?> getBooking({
    required String idToken,
    bool isRefresh = false,
    required int bookingID,
  }) async {
    try {
      _setBooking(ApiResponse.loading());

      if (isRefresh) {
      } else {
        return null;
      }

      var response = await _bookingRepo.getBookingByID(
        idToken: idToken,
        bookingID: bookingID,
        odataSegment: "\$expand=BookingDetails(\$orderby=startTime asc;\$expand=Field)",
      );

      if (isRefresh) {
        _setBooking(ApiResponse.completed(response));
      } else {}

      return true;
    } catch (e) {
      _setBooking(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
