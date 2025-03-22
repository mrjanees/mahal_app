class SubscriptionAdd {
  final String houseNo;
  final String houseHead;
  final String houseName;
  final String type;
  final List<String> month;
  final String year;
  final String dateOfCollection;
  final String amount;
  SubscriptionAdd(this.houseNo, this.type, this.month, this.year,
      this.houseName, this.houseHead, this.dateOfCollection, this.amount);

  Map<String, dynamic> toJson() {
    return {
      "houseNo": houseNo,
      "houseHead": houseHead,
      "houseName": houseName,
      "type": type,
      "month": month,
      "year": year,
      "dateOfCollection": dateOfCollection,
      "amount": amount,
    };
  }
}
