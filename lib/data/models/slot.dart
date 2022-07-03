import 'package:sfbms_mobile/data/models/field.dart';

class Slot {
  int? id;
  int? fieldId;
  Field? field;
  String? startTime;
  String? endTime;
  int? status;
  int? slotNumber;
  int? bookingStatus;

  Slot({
    this.id,
    this.fieldId,
    this.field,
    this.startTime,
    this.endTime,
    this.status,
    this.slotNumber,
    this.bookingStatus,
  });

  Slot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldId = json['fieldId'];
    field = json['field'] != null ? Field.fromJson(json['field']) : null;
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    slotNumber = json['slotNumber'];
    bookingStatus = json['bookingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fieldId'] = fieldId;
    if (field != null) {
      data['field'] = field!.toJson();
    }
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['status'] = status;
    data['slotNumber'] = slotNumber;
    data['bookingStatus'] = bookingStatus;
    return data;
  }
}
