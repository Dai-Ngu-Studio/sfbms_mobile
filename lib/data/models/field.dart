import 'package:sfbms_mobile/data/models/category.dart';
import 'package:sfbms_mobile/data/models/feedback.dart';
import 'package:sfbms_mobile/data/models/slot.dart';

class Field {
  int? id;
  String? name;
  String? description;
  int? price;
  int? categoryId;
  Category? category;
  int? numberOfSlots;
  int? totalRating;
  List<Slot>? slots;
  List<Feedback>? feedbacks;
  List<String>? bookingDetails;

  Field({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.category,
    this.numberOfSlots,
    this.totalRating,
    this.slots,
    this.feedbacks,
    this.bookingDetails,
  });

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    numberOfSlots = json['numberOfSlots'];
    totalRating = json['totalRating'];
    if (json['slots'] != null) {
      slots = <Slot>[];
      json['slots'].forEach((v) {
        slots!.add(Slot.fromJson(v));
      });
    }
    if (json['feedbacks'] != null) {
      feedbacks = <Feedback>[];
      json['feedbacks'].forEach((v) {
        feedbacks!.add(Feedback.fromJson(v));
      });
    }
    bookingDetails = json['bookingDetails'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['categoryId'] = categoryId;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['numberOfSlots'] = numberOfSlots;
    data['totalRating'] = totalRating;
    if (slots != null) {
      data['slots'] = slots!.map((v) => v.toJson()).toList();
    }
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
    }
    data['bookingDetails'] = bookingDetails;
    return data;
  }
}
