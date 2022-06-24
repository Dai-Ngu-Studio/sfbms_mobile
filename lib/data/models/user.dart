import 'package:sfbms_mobile/data/models/feedback.dart';

class User {
  String? id;
  String? email;
  String? password;
  String? name;
  int? isAdmin;
  List<String>? bookings;
  List<Feedback>? feedbacks;

  User({
    this.id,
    this.email,
    this.password,
    this.name,
    this.isAdmin,
    this.bookings,
    this.feedbacks,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    isAdmin = json['isAdmin'];
    bookings = json['bookings'].cast<String>();
    if (json['feedbacks'] != null) {
      feedbacks = <Feedback>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(Feedback.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['isAdmin'] = isAdmin;
    data['bookings'] = bookings;
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
