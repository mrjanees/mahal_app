
import 'package:mahal_app/model/subscription/house_details_list.dart';

sealed class DateWiseState {}

class DateWiseInitial extends DateWiseState {}

class DateWiseLoading extends DateWiseState {}

class DateWiseLoaded extends DateWiseState {
  final DateTime fromDate;
  final DateTime toDate;
  final List<Result> collectionData; // Replace with your model

  DateWiseLoaded({
    required this.fromDate,
    required this.toDate,
    required this.collectionData,
  });

  DateWiseLoaded copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    List<Result>? collectionData, // Replace with your model
  }) {
    return DateWiseLoaded(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      collectionData: collectionData ?? this.collectionData,
    );
  }
}

class DateWiseFailure extends DateWiseState {
  final String message;
  DateWiseFailure(this.message);
}