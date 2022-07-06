import 'package:sfbms_mobile/data/models/booking_details.dart';

abstract class BookingDetailRepository {
  Future<BookingDetail> getBookingDetailByID({
    required String idToken,
    required int bookingDetailID,
    String? odataSegment,
  });
}
