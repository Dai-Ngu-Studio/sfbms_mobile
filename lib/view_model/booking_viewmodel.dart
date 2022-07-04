import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sfbms_mobile/data/models/bookings.dart';
import 'package:sfbms_mobile/data/remote/response/api_response.dart';
import 'package:sfbms_mobile/data/repository/booking_repository_impl.dart';

class BookingViewModel extends ChangeNotifier {
  final _bookingRepo = BookingRepositoryImpl();

  ApiResponse<Bookings> bookings = ApiResponse.loading();

  int? count;
  int currentPage = 0;
  int? totalPages;

  void _setBookings(ApiResponse<Bookings> response) {
    log(response.toString());
    bookings = response;
    notifyListeners();
  }

  Future<bool?> getBookings({
    required String idToken,
    bool isRefresh = false,
    int quantityToGet = 5, // size of array of bookings needed to fetch
  }) async {
    try {
      var prevBookings = bookings.data?.bookings; // bookings fetched from previous request
      _setBookings(ApiResponse.loading());

      if (isRefresh) {
        currentPage = 0;
      } else if (currentPage >= totalPages!) {
        // reached last page, return null to set loadNoData for refreshController
        _setBookings(ApiResponse.completed(
          Bookings(bookings: prevBookings, count: count),
        ));
        return null;
      }

      var response = await _bookingRepo.getBookings(
        idToken: idToken,
        odataSegment:
            "\$count=true&\$top=$quantityToGet&\$skip=${quantityToGet * currentPage}&\$expand=BookingDetails&\$orderby=BookingDate desc",
      );

      if (isRefresh) {
        _setBookings(ApiResponse.completed(response));
      } else {
        if (response.bookings!.isNotEmpty) {
          var tempBookings = Bookings(
            bookings: prevBookings == null
                ? [...response.bookings!]
                : [...prevBookings, ...response.bookings!],
            count: response.count,
          );
          _setBookings(ApiResponse.completed(tempBookings));
        }
      }

      currentPage += 1;
      totalPages = (response.count! / quantityToGet).ceil();
      return true;
    } catch (e) {
      _setBookings(ApiResponse.error(e.toString()));
      rethrow;
    }
  }
}
