class HouseBasicDetails {
  String? houseno;
  String? familyhead;
  String? familyname;
  String? location;
  String? contact;
  String? amount;

  HouseBasicDetails(
      {this.familyhead,
      this.familyname,
      this.location,
      this.contact,
      this.houseno,
      this.amount});

  HouseBasicDetails.fromJson(Map<String, dynamic> json) {
    if (json["familyhead"] is String) {
      familyhead = json["familyhead"];
    }
    if (json["familyname"] is String) {
      familyname = json["familyname"];
    }
    if (json["location"] is String) {
      location = json["location"];
    }
    if (json["contact"] is String) {
      contact = json["contact"];
    }
    if (json["amount"] is String) {
      amount = json["amount"];
    }
    if (json["houseno"] is String) {
      houseno = json["houseno"];
    }
  }

  static List<HouseBasicDetails> fromList(List<Map<String, dynamic>> list) {
    return list.map(HouseBasicDetails.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["familyhead"] = familyhead;
    data["familyname"] = familyname;
    data["location"] = location;
    data["contact"] = contact;
    data["amount"] = amount;
    data["houseno"] = houseno;
    return data;
  }
}
