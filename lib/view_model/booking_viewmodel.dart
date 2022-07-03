import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sfbms_mobile/data/models/bookings.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/booking_repository_impl.dart';

class BookingViewModel extends ChangeNotifier {
  final _bookingRepo = BookingRepositoryImpl();

  ApiResponse<Bookings> bookings = ApiResponse.loading();

  int currentPage = 1;
  int? totalPages;

  void _setBookings(ApiResponse<Bookings> response) {
    log(response.toString());
    bookings = response;
    notifyListeners();
  }

  Future<bool?> getBookings({
    required String idToken,
    bool isRefresh = false,
  }) async {
    try {
      var prevBookings = bookings.data?.bookings;
      _setBookings(ApiResponse.loading());

      if (isRefresh) {
        currentPage = 1;
      } else if (currentPage > (totalPages ?? 9999999)) {
        _setBookings(ApiResponse.completed(
          Bookings(bookings: prevBookings),
        ));
      }

      var response = await _bookingRepo.getBookings(
        idToken: idToken,
        odataSegment: "\$top=2&\$skip=0&\$count=true",
      );

      if (isRefresh) {
        _setBookings(ApiResponse.completed(response));
      } else {
        if (response.bookings!.isNotEmpty) {
          var tempBookings = Bookings(
            bookings: prevBookings == null
                ? [...response.bookings!]
                : [...prevBookings, ...response.bookings!],
          );
          _setBookings(ApiResponse.completed(tempBookings));
        }
      }

      currentPage += 1;
      totalPages = (response.count! / 2).ceil();
      return true;
    } catch (e) {
      _setBookings(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
