import 'dart:convert';
import 'dart:developer';

import 'package:sfbms_mobile/data/models/bookings.dart';
import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/models/cart_item.dart';
import 'package:sfbms_mobile/data/models/slot.dart';
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
            "${ApiEndPoint().booking}/$bookingID",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
            odataSegment: odataSegment,
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
            ApiEndPoint().booking,
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
            odataSegment: odataSegment,
          );

    log('BookingRepositoryImpl :: getBookings :: response: $response');
    return Bookings.fromJson(response);
  }

  @override
  Future<Booking> postBooking({
    required String idToken,
    required Map<String, CartItem> cartItems,
  }) async {
    var slots = [];
    cartItems.forEach((cartItemId, cartItem) {
      var slot = Slot(
        id: cartItem.id,
        fieldId: cartItem.fieldId,
        startTime: cartItem.startTime,
        endTime: cartItem.endTime,
        slotNumber: cartItem.slotNumber,
      );
      slots.add(slot);
    });

    dynamic response = await _apiService.postResponse(
      ApiEndPoint().booking,
      header: Map<String, String>.from({
        "Authorization": "Bearer $idToken",
        "Content-Type": "application/json",
      }),
      body: json.encode({"slots": slots}),
    );

    log('BookingRepositoryImpl :: postBooking :: response: $response');
    return Booking.fromJson(response);
  }
}
