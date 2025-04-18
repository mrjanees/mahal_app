class HouseDetials {
  List<Subscription>? subscription;

  HouseDetials({this.subscription});

  HouseDetials.fromJson(Map<String, dynamic> json) {
    if (json["subscription"] is List) {
      subscription = json["subscription"] == null
          ? null
          : (json["subscription"] as List)
              .map((e) => Subscription.fromJson(e))
              .toList();
    }
  }

  static List<HouseDetials> fromList(List<Map<String, dynamic>> list) {
    return list.map(HouseDetials.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (subscription != null) {
      data["subscription"] = subscription?.map((e) => e.toJson()).toList();
    }
    return data;
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
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["month"] is String) {
      month = json["month"];
    }
    if (json["year"] is String) {
      year = json["year"];
    }
    if (json["date"] is String) {
      date = json["date"];
    }
    if (json["payed_amount"] is String) {
      amount = json["payed_amount"];
    }
  }

  static List<Subscription> fromList(List<Map<String, dynamic>> list) {
    return list.map(Subscription.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["type"] = type;
    data["month"] = month;
    data["year"] = year;
    data["date"] = date;
    data["amount"] = amount;
    return data;
  }
}
