class HouseDetialsList {
  List<Result>? result;
  int? total;
  HouseDetialsList({this.result, this.total});

  HouseDetialsList.fromJson(Map<String, dynamic> json) {
    if (json["result"] is List) {
      result = json["result"] == null
          ? null
          : (json["result"] as List).map((e) => Result.fromJson(e)).toList();
    }
    if (json["total"] is int) {
      total = json["total"];
    }
  }

  static List<HouseDetialsList> fromList(List<Map<String, dynamic>> list) {
    return list.map(HouseDetialsList.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data["result"] = result?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  String? houseno;
  String? familyhead;
  String? familyname;
  String? type;
  String? month;
  String? year;
  String? amount;
  String? dateofcollection;

  Result({
    this.id,
    this.houseno,
    this.familyhead,
    this.familyname,
    this.type,
    this.month,
    this.year,
    this.amount,
    this.dateofcollection,
  });

  Result.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["houseno"] is String) {
      houseno = json["houseno"];
    }
    if (json["familyhead"] is String) {
      familyhead = json["familyhead"];
    }
    if (json["familyname"] is String) {
      familyname = json["familyname"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["month"] is String) {
      month = json["month"];
    }
    if (json["year"] is String) {
      year = json["year"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["dateofcollection"] is String) {
      dateofcollection = json["dateofcollection"];
    }
  }

  static List<Result> fromList(List<Map<String, dynamic>> list) {
    return list.map(Result.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["houseno"] = houseno;
    data["familyhead"] = familyhead;
    data["familyname"] = familyname;
    data["type"] = type;
    data["month"] = month;
    data["year"] = year;
    data["amount"] = amount;
    return data;
  }
}
