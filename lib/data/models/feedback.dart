import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/models/user.dart';

class Feedback {
  int? id;
  String? userId;
  String? feedbackTime;
  User? user;
  int? fieldId;
  Field? field;
  String? title;
  String? content;
  int? rating;

  Feedback({
    this.id,
    this.userId,
    this.feedbackTime,
    this.user,
    this.fieldId,
    this.field,
    this.title,
    this.content,
    this.rating,
  });

  Feedback.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    feedbackTime = json['feedbackTime'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    fieldId = json['fieldId'];
    field = json['field'] != null ? Field.fromJson(json['field']) : null;
    title = json['title'];
    content = json['content'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['feedbackTime'] = feedbackTime;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['fieldId'] = fieldId;
    if (field != null) {
      data['field'] = field!.toJson();
    }
    data['title'] = title;
    data['content'] = content;
    data['rating'] = rating;
    return data;
  }
}
