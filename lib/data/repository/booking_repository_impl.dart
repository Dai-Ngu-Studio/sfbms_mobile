import 'dart:developer';

import 'package:sfbms_mobile/data/models/bookings.dart';
import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  final _apiService = NetworkApiService();

  @override
  Future<Booking> getBookingByID({
    required String idToken,
    required int bookingID,
    String? odataSegment,
  }) async {
    dynamic response = odataSegment == null
        ? await _apiService.getResponse(
            "${ApiEndPoint().booking}/$bookingID",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          )
        : await _apiService.getResponse(
            "${ApiEndPoint().booking}/$bookingID?$odataSegment",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          );
    log('BookingRepositoryImpl :: getBookingByID :: response: $response');

    return Booking.fromJson(response);
  }

  @override
  Future<Bookings> getBookings({
    required String idToken,
    String? odataSegment,
  }) async {
    dynamic response = odataSegment == null
        ? await _apiService.getResponse(
            ApiEndPoint().booking,
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          )
        : await _apiService.getResponse(
            "${ApiEndPoint().booking}?$odataSegment",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          );

    log('BookingRepositoryImpl :: getBookings :: response: $response');
    return Bookings.fromJson(response);
  }
}
