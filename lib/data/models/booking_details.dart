import 'package:sfbms_mobile/data/models/booking.dart';
import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/models/user.dart';

class BookingDetail {
  int? id;
  int? bookingId;
  Booking? booking;
  String? startTime;
  String? endTime;
  int? fieldId;
  Field? field;
  String? userId;
  User? user;
  int? slotNumber;
  int? price;
  int? status;

  BookingDetail({
    this.id,
    this.bookingId,
    this.booking,
    this.startTime,
    this.endTime,
    this.fieldId,
    this.field,
    this.userId,
    this.user,
    this.slotNumber,
    this.price,
    this.status,
  });

  BookingDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookingId = json['bookingId'];
    booking =
        json['booking'] != null ? Booking.fromJson(json['booking']) : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
    fieldId = json['fieldId'];
    field = json['field'] != null ? Field.fromJson(json['field']) : null;
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    slotNumber = json['slotNumber'];
    price = json['price'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bookingId'] = bookingId;
    if (booking != null) {
      data['booking'] = booking!.toJson();
    }
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['fieldId'] = fieldId;
    if (field != null) {
      data['field'] = field!.toJson();
    }
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['slotNumber'] = slotNumber;
    data['price'] = price;
    data['status'] = status;
    return data;
  }
}
