import 'package:sfbms_mobile/data/models/booking.dart';

class Bookings {
  List<Booking>? bookings;
  int? count;

  Bookings({this.bookings, this.count});

  Bookings.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      bookings = <Booking>[];
      json['value'].forEach((v) {
        bookings!.add(Booking.fromJson(v));
      });
    }
    count = json['@odata.count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookings != null) {
      data['value'] = bookings!.map((v) => v.toJson()).toList();
    }
    data['@odata.count'] = count;
    return data;
  }
}
