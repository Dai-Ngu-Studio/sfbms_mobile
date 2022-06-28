import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/models/fields.dart';

abstract class FieldRepository {
  Future<Fields> getFields({required String idToken});
  Future<Field> getFieldByID({required String idToken, required String fieldID});
}
