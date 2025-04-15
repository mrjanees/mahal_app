import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mahal_app/model/subscription/house_details_list.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/model/subscription/subscription_add.dart';
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
    final response =
        await subscriptionRepo.getHouseDetials(houseNo: event.houseNo);
    if (response != null) {
      if (response.familyhead != null) {
        emit(HouseDetailsLoaded(
            response, Selection.madhrasa, DateTime.now().year, const {}, 0));
      } else {
        emit(HouseDetailsFailure('No House.'));
      }
    } else {
      emit(HouseDetailsError("Somthing went wrong!"));
    }
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
      ));
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
          currentState.monthlyAmount));
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
      ));
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
