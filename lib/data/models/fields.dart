import 'package:sfbms_mobile/data/models/field.dart';

class Fields {
  int? count;
  List<Field>? fields;

  Fields({this.count, this.fields});

  Fields.fromJson(Map<String, dynamic> json) {
    count = json['@odata.count'];
    if (json['value'] != null) {
      fields = <Field>[];
      json['value'].forEach((v) {
        fields!.add(Field.fromJson(v));
      });
    }
  }
}
