class AptDataModel {
  int? id;
  String? apt;
  String? owner;
  int? price;

  // List<Map<int, bool>>? classCheckList;

  AptDataModel({this.id,
    this.apt,
    this.owner,
    this.price,

    // this.classCheckList,
  });

  AptDataModel.fromJson(Map<String, dynamic> json, {int table = -1}) {
    id = json['id'];
    apt = json['apt'];
    owner = json['owner'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['apt'] = this.apt;
    data['owner'] = this.owner;
    data['price'] = this.price;
    return data;
  }
}