
class HouseDetials {
  String? familyhead;
  String? familyname;
  String? houseno;
  List<Subscription>? subscription;

  HouseDetials({this.familyhead, this.familyname, this.houseno, this.subscription});

  HouseDetials.fromJson(Map<String, dynamic> json) {
    if(json["familyhead"] is String) {
      familyhead = json["familyhead"];
    }
    if(json["familyname"] is String) {
      familyname = json["familyname"];
    }
    if(json["houseno"] is String) {
      houseno = json["houseno"];
    }
    if(json["subscription"] is List) {
      subscription = json["subscription"] == null ? null : (json["subscription"] as List).map((e) => Subscription.fromJson(e)).toList();
    }
  }

  static List<HouseDetials> fromList(List<Map<String, dynamic>> list) {
    return list.map(HouseDetials.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["familyhead"] = familyhead;
    _data["familyname"] = familyname;
    _data["houseno"] = houseno;
    if(subscription != null) {
      _data["subscription"] = subscription?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Subscription {
  String? type;
  String? month;
  String? year;
  String? date;
  String? amount;

  Subscription({this.type, this.month, this.year, this.date, this.amount});

  Subscription.fromJson(Map<String, dynamic> json) {
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["month"] is String) {
      month = json["month"];
    }
    if(json["year"] is String) {
      year = json["year"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["amount"] is String) {
      amount = json["amount"];
    }
  }

  static List<Subscription> fromList(List<Map<String, dynamic>> list) {
    return list.map(Subscription.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["type"] = type;
    _data["month"] = month;
    _data["year"] = year;
    _data["date"] = date;
    _data["amount"] = amount;
    return _data;
  }
}