import 'package:sfbms_mobile/data/models/field.dart';
import 'package:sfbms_mobile/data/models/fields.dart';

abstract class FieldRepository {
  Future<Fields> getFields({
    required String idToken,
    String? odataSegment,
    String? searchValue,
  });

  Future<Fields> getFieldsFilter({
    required String idToken,
    required String odataSegment,
    List<int>? categoryIds,
    String? searchValue,
  });

  Future<Field> getFieldByID({
    required String idToken,
    required DateTime bookingDate,
    required int fieldID,
    String? odataSegment,
  });
}
