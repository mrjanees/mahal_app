sealed class DateWiseEvent {}

class SelectFromDate extends DateWiseEvent {
  final String fromDate;
  SelectFromDate({required this.fromDate});
}

class SelectToDate extends DateWiseEvent {
  final String toDate;
  SelectToDate({required this.toDate});
}

class CurrentDateWiseCollection extends DateWiseEvent {
  final String fromDate;
  final String toDate;
  CurrentDateWiseCollection(this.fromDate, this.toDate);
}

class FetchDateWiseCollection extends DateWiseEvent {}
