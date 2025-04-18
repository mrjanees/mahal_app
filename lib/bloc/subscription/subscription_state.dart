part of 'subscription_bloc.dart';

@immutable
sealed class SubscriptionState {}

class HouseDetailsInitial extends SubscriptionState {}

class HouseDetialsLoading extends SubscriptionState {}

class HouseDetailsLoaded extends SubscriptionState {
  final HouseDetials houseDetials;
  final Selection selectedValue;
  final int selectedYear;
  final Set<String> selectedMonths;
  final double monthlyAmount;
  final HouseBasicDetails houseBasicDetails;

  HouseDetailsLoaded(
    this.houseDetials,
    this.selectedValue,
    this.selectedYear,
    this.selectedMonths,
    this.monthlyAmount,
    this.houseBasicDetails
  );
}

class HouseDetailsFailure extends SubscriptionState {
  final String message;
  HouseDetailsFailure(this.message);
}

class HouseDetailsError extends SubscriptionState {
  final String message;
  HouseDetailsError(this.message);
}


// class ToggleButtonState extends SubscriptionState {
 
//   ToggleButtonState(this.selectedValue);
// }
