import 'package:sfbms_mobile/data/models/user.dart';

class Booking {
  int? id;
  int? totalPrice;
  String? userId;
  User? user;
  List<String>? bookingDetails;

  Booking({
    this.id,
    this.totalPrice,
    this.userId,
    this.user,
    this.bookingDetails,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalPrice = json['totalPrice'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    bookingDetails = json['bookingDetails'].cast<String>();
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
    return data;
  }
}
