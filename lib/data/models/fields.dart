import 'package:sfbms_mobile/data/models/field.dart';

class Fields {
  List<Field>? fields;
  int? numOfFieldPages;

  Fields({this.fields, this.numOfFieldPages});

  Fields.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fields = <Field>[];
      json['fields'].forEach((v) {
        fields!.add(Field.fromJson(v));
      });
    }
    numOfFieldPages = json['numOfFieldPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    data['numOfFieldPages'] = numOfFieldPages;
    return data;
  }
}
