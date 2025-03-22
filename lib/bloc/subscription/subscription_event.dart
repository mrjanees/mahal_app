part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionEvent {}

class GetHouseDetails extends SubscriptionEvent {
  final String houseNo;
  GetHouseDetails({required this.houseNo});
}

class GetTodaysCollection extends SubscriptionEvent {}

class ToggleChangeType extends SubscriptionEvent {
  final Selection selection;
  ToggleChangeType({required this.selection});
}

enum Selection { masjid, madhrasa }

class SelectYearEvent extends SubscriptionEvent {
  final int year;
  SelectYearEvent(this.year);
}

class ToggleMonthSelectionEvent extends SubscriptionEvent {
  final String month;
  ToggleMonthSelectionEvent(this.month);
}

// class SaveButtonPress extends SubscriptionEvent {
//   final SubscriptionAdd data;
//   SaveButtonPress(this.data);
// }
