import 'package:sfbms_mobile/data/models/booking_time.dart';
import 'package:sfbms_mobile/data/models/slot.dart';

class Utils {
  static List<BookingTime> getBookingTimesBySlots(List<Slot>? slots) {
    if (slots == null) return [];

    List<BookingTime> bookingTimes = [];

    for (var slot in slots) {
      final startTime = DateTime.parse(slot.startTime!).hour;

      if (startTime >= 2 && startTime < 6) {
        bookingTimes.add(BookingTime.MIDNIGHT);
      } else if (startTime >= 6 && startTime < 10) {
        bookingTimes.add(BookingTime.MORNING);
      } else if (startTime >= 10 && startTime < 14) {
        bookingTimes.add(BookingTime.NOON);
      } else if (startTime >= 14 && startTime < 18) {
        bookingTimes.add(BookingTime.AFTERNOON);
      } else if (startTime >= 18 && startTime < 22) {
        bookingTimes.add(BookingTime.EVENING);
      } else if (startTime >= 22 && startTime < 26) {
        bookingTimes.add(BookingTime.NIGHT);
      }
    }

    return bookingTimes.toSet().toList();
  }
}
