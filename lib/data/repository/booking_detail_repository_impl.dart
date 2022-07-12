import 'dart:developer';

import 'package:sfbms_mobile/data/models/booking_details.dart';
import 'package:sfbms_mobile/data/remote/network/api_end_point.dart';
import 'package:sfbms_mobile/data/remote/network/network_api_service.dart';
import 'package:sfbms_mobile/data/repository/interface/booking_detail_repository.dart';

class BookingDetailRepositoryImpl implements BookingDetailRepository {
  final _apiService = NetworkApiService();

  @override
  Future<BookingDetail> getBookingDetailByID({
    required String idToken,
    required int bookingDetailID,
    String? odataSegment,
  }) async {
    dynamic response = odataSegment == null
        ? await _apiService.getResponse(
            "${ApiEndPoint().bookingDetails}/$bookingDetailID",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
          )
        : await _apiService.getResponse(
            "${ApiEndPoint().bookingDetails}/$bookingDetailID",
            header: Map<String, String>.from({"Authorization": "Bearer $idToken"}),
            odataSegment: odataSegment,
          );
    log('BookingDetailRepositoryImpl :: getBookingDetailByID :: response: $response');

    return BookingDetail.fromJson(response);
  }
}
