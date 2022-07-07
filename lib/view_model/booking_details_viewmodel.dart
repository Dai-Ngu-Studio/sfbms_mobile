import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/models/booking_details.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/booking_detail_repository_impl.dart';
import 'package:sfbms_mobile/data/repository/booking_repository_impl.dart';

class BookingDetailsViewModel extends ChangeNotifier {
  final _bookingRepo = BookingRepositoryImpl();
  final _bookingDetailRepo = BookingDetailRepositoryImpl();

  ApiResponse<Booking> booking = ApiResponse.loading();
  ApiResponse<BookingDetail> bookingDetail = ApiResponse.loading();

  int? count;

  void _setBooking(ApiResponse<Booking> response) {
    log(response.toString());
    booking = response;
    notifyListeners();
  }

  void _setBookingDetail(ApiResponse<BookingDetail> response) {
    log(response.toString());
    bookingDetail = response;
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

  Future getBookingDetail({
    required idToken,
    required int bookingDetailID,
  }) async {
    try {
      _setBookingDetail(ApiResponse.loading());

      var response = await _bookingDetailRepo.getBookingDetailByID(
        idToken: idToken,
        bookingDetailID: bookingDetailID,
        odataSegment: "\$expand=Feedbacks,Field",
      );

      _setBookingDetail(ApiResponse.completed(response));
    } catch (e) {
      _setBooking(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
