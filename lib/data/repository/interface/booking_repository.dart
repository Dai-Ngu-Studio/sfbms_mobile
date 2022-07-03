import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/models/bookings.dart';

abstract class BookingRepository {
  Future<Bookings> getBookings({required String idToken});
  Future<Booking> getBookingByID({required String idToken, required String bookingID});
}
