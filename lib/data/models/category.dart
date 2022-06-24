class Category {
  int? id;
  String? name;
  List<String>? fields;

  Category({this.id, this.name, this.fields});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fields = json['fields'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['fields'] = fields;
    return data;
  }
}
