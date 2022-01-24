class EventModel {
  int? id;
  String? event_type;
  String? count;
  int? date;
  int? price;
  int? estate_id;

  // List<Map<int, bool>>? classCheckList;

  EventModel({this.id,
    this.event_type,
    this.count,
    this.date,
    this.price,
    this.estate_id

    // this.classCheckList,
  });

  EventModel.fromJson(Map<String, dynamic> json, {int table = -1}) {
    id = json['id'];
    event_type = json['event_type'];
    count = json['count'];
    date = json['date'];
    price = json['price'];
    estate_id = json['estate_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_type'] = this.event_type;
    data['count'] = this.count;
    data['date'] = this.date;
    data['price'] = this.price;
    data['estate_id'] = this.estate_id;
    return data;
  }
}