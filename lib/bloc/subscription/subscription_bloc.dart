import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mahal_app/model/subscription/house_basic_details.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/repositories/subscription_repo.dart';
import 'package:meta/meta.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository subscriptionRepo;
  SubscriptionBloc(this.subscriptionRepo) : super(HouseDetailsInitial()) {
    on<GetHouseDetails>(_getHouseDetails);
    on<ToggleChangeType>(_toggleButtonPress);
    on<SelectYearEvent>(_selectYear);
    on<ToggleMonthSelectionEvent>(_selectMonth);
    // on<SaveButtonPress>(_saveButtonPress);
  }

  FutureOr<void> _getHouseDetails(
      GetHouseDetails event, Emitter<SubscriptionState> emit) async {
    emit(HouseDetialsLoading());

    final basicDetails =
        await subscriptionRepo.getHouseBasicDetials(houseNo: event.houseNo);

    if (basicDetails == null) {
      emit(HouseDetailsError("Something went wrong in basic details!"));
      return;
    }

    if (basicDetails.familyhead == null) {
      emit(HouseDetailsFailure('No basic house details.'));
      return;
    }

    final subscription =
        await subscriptionRepo.getHouseDetials(houseNo: event.houseNo);

    if (subscription == null) {
      emit(HouseDetailsError("Something went wrong in full details!"));
      return;
    }

    emit(HouseDetailsLoaded(subscription, Selection.madhrasa,
        DateTime.now().year, const {}, 0, basicDetails));
  }

  FutureOr<void> _toggleButtonPress(
      ToggleChangeType event, Emitter<SubscriptionState> emit) {
    if (state is HouseDetailsLoaded) {
      final currentState = state as HouseDetailsLoaded;
      emit(HouseDetailsLoaded(
          currentState.houseDetials,
          event.selection,
          currentState.selectedYear,
          currentState.selectedMonths,
          currentState.monthlyAmount,
          currentState.houseBasicDetails));
    }
  }

  FutureOr<void> _selectYear(
      SelectYearEvent event, Emitter<SubscriptionState> emit) {
    if (state is HouseDetailsLoaded) {
      final currentState = state as HouseDetailsLoaded;
      emit(HouseDetailsLoaded(
          currentState.houseDetials,
          currentState.selectedValue,
          event.year,
          currentState.selectedMonths,
          currentState.monthlyAmount,
          currentState.houseBasicDetails));
    }
  }

  FutureOr<void> _selectMonth(
      ToggleMonthSelectionEvent event, Emitter<SubscriptionState> emit) {
    if (state is HouseDetailsLoaded) {
      final currentState = state as HouseDetailsLoaded;
      final updatedMonths = Set<String>.from(currentState.selectedMonths);

      if (updatedMonths.contains(event.month)) {
        updatedMonths.remove(event.month);
      } else {
        updatedMonths.add(event.month);
      }
      emit(HouseDetailsLoaded(
          currentState.houseDetials,
          currentState.selectedValue,
          currentState.selectedYear,
          updatedMonths,
          currentState.monthlyAmount,
          currentState.houseBasicDetails));
    }
  }

  // FutureOr<void> _saveButtonPress(
  //     SaveButtonPress event, Emitter<SubscriptionState> emit) {
  //   if (state is HouseDetailsLoaded) {
  //     final currentState = state as HouseDetailsLoaded;
  //     emit(HouseDetailsLoaded(
  //         currentState.houseDetials,
  //         currentState.selectedValue,
  //         currentState.selectedYear,
  //         currentState.selectedMonths,
  //         SubscriptionAdd(
  //             event.data.houseNo,
  //             event.data.type,
  //             event.data.month,
  //             event.data.year,
  //             event.data.dateOfCollection,
  //             event.data.dateOfCollection)));
  //   }
  // }
}
