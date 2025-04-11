import 'package:mahal_app/model/subscription/house_details_list.dart';

sealed class DateWiseState {}

class DateWiseInitial extends DateWiseState {}

class DateWiseLoading extends DateWiseState {}

class DateWiseLoaded extends DateWiseState {
  final DateTime fromDate;
  final DateTime toDate;
  final List<Result> collectionData; // Replace with your model
  final int total;
  final String type;

  DateWiseLoaded(
      {required this.fromDate,
      required this.toDate,
      required this.collectionData,
      required this.total,
      required this.type});

  DateWiseLoaded copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    List<Result>? collectionData, // Replace with your model
    int? total,
    String? type,
  }) {
    return DateWiseLoaded(
        type: type ?? this.type,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        collectionData: collectionData ?? this.collectionData,
        total: total ?? this.total);
  }
}

class DateWiseFailure extends DateWiseState {
  final String message;
  DateWiseFailure(this.message);
}
