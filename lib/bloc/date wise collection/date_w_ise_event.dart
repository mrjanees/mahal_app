sealed class DateWiseEvent {}

class SelectFromDate extends DateWiseEvent {
  final String fromDate;
  SelectFromDate({required this.fromDate});
}

class SelectToDate extends DateWiseEvent {
  final String toDate;
  SelectToDate({required this.toDate});
}

class SelectType extends DateWiseEvent {
  final String type;
  SelectType({required this.type});
}

class CurrentDateWiseCollection extends DateWiseEvent {
  final String fromDate;
  final String toDate;
  final String type;
  CurrentDateWiseCollection(this.fromDate, this.toDate, this.type);
}

class FetchDateWiseCollection extends DateWiseEvent {}
