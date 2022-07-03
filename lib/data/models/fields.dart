import 'package:sfbms_mobile/data/models/field.dart';

class Fields {
  int? odataCount;
  List<Field>? fields;

  Fields({this.odataCount, this.fields});

  Fields.fromJson(Map<String, dynamic> json) {
    odataCount = json['@odata.count'];
    if (json['value'] != null) {
      fields = <Field>[];
      json['value'].forEach((v) {
        fields!.add(Field.fromJson(v));
      });
    }
  }
}
