class Slot {
  int? id;
  int? fieldId;
  String? field;
  String? startTime;
  String? endTime;
  int? status;
  int? slotNumber;

  Slot({
    this.id,
    this.fieldId,
    this.field,
    this.startTime,
    this.endTime,
    this.status,
    this.slotNumber,
  });

  Slot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldId = json['fieldId'];
    field = json['field'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    status = json['status'];
    slotNumber = json['slotNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fieldId'] = fieldId;
    data['field'] = field;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['status'] = status;
    data['slotNumber'] = slotNumber;
    return data;
  }
}
