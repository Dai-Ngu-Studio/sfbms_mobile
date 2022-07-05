import 'package:sfbms_mobile/data/models/booking_details.dart';
import 'package:sfbms_mobile/data/models/user.dart';

class Booking {
  int? id;
  double? totalPrice;
  String? userId;
  User? user;
  List<BookingDetail>? bookingDetails;
  String? bookingDate;
  int? numberOfFields;

  Booking({
    this.id,
    this.totalPrice,
    this.userId,
    this.user,
    this.bookingDetails,
    this.bookingDate,
    this.numberOfFields,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['bookingDetails'] != null) {
      bookingDetails = <BookingDetail>[];
      json['bookingDetails'].forEach((v) {
        bookingDetails!.add(BookingDetail.fromJson(v));
      });
    }
    bookingDate = json['bookingDate'];
    numberOfFields = json['numberOfFields'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalPrice'] = totalPrice;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['bookingDetails'] = bookingDetails;
    data['bookingDate'] = bookingDate;
    data['numberOfFields'] = numberOfFields;
    return data;
  }
}
