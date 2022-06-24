class Feedback {
  int? id;
  String? userId;
  String? user;
  int? fieldId;
  String? field;
  String? title;
  String? content;
  int? rating;

  Feedback({
    this.id,
    this.userId,
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
    user = json['user'];
    fieldId = json['fieldId'];
    field = json['field'];
    title = json['title'];
    content = json['content'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['user'] = user;
    data['fieldId'] = fieldId;
    data['field'] = field;
    data['title'] = title;
    data['content'] = content;
    data['rating'] = rating;
    return data;
  }
}
