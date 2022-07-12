import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/models/bookings.dart';
import 'package:sfbms_mobile/data/models/cart_item.dart';

abstract class BookingRepository {
  Future<Bookings> getBookings({required String idToken, String? odataSegment});
  Future<Booking> getBookingByID({
    required String idToken,
    required int bookingID,
    String? odataSegment,
  });
  Future<Booking> postBooking({
    required String idToken,
    required Map<String, CartItem> cartItems,
  });
}
