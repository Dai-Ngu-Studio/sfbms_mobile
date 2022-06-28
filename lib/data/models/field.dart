import 'package:sfbms_mobile/data/models/category.dart';
import 'package:sfbms_mobile/data/models/slot.dart';

class Field {
  int? id;
  String? name;
  String? description;
  double? price;
  int? categoryId;
  Category? category;
  int? numberOfSlots;
  int? totalRating;
  String? imageUrl;
  List<Slot>? slots;

  Field({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.category,
    this.numberOfSlots,
    this.totalRating,
    this.imageUrl,
    this.slots,
  });

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    categoryId = json['categoryId'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    numberOfSlots = json['numberOfSlots'];
    totalRating = json['totalRating'];
    imageUrl = json['imageUrl'];
    if (json['slots'] != null) {
      slots = <Slot>[];
      json['slots'].forEach((v) {
        slots!.add(Slot.fromJson(v));
      });
    }
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
    data['imageUrl'] = imageUrl;
    if (slots != null) {
      data['slots'] = slots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
