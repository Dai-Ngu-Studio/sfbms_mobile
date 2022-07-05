import 'package:sfbms_mobile/data/models/category.dart';
import 'package:sfbms_mobile/data/models/feedback.dart';
import 'package:sfbms_mobile/data/models/slot.dart';

class Field {
  int? id;
  String? name;
  String? description;
  double? price;
  int? categoryId;
  int? numberOfSlots;
  double? totalRating;
  String? imageUrl;
  List<Slot>? slots;
  Category? category;
  List<Feedback>? feedbacks;

  Field({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.numberOfSlots,
    this.totalRating,
    this.imageUrl,
    this.slots,
    this.category,
    this.feedbacks,
  });

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];
    numberOfSlots = json['numberOfSlots'];
    totalRating = json['totalRating'];
    imageUrl = json['imageUrl'];
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
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['categoryId'] = categoryId;
    data['numberOfSlots'] = numberOfSlots;
    data['totalRating'] = totalRating;
    data['imageUrl'] = imageUrl;
    if (slots != null) {
      data['slots'] = slots!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (feedbacks != null) {
      data['feedbacks'] = feedbacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
