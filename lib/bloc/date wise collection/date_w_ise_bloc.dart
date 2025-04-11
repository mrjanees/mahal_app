import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mahal_app/repositories/subscription_repo.dart';

import 'date_w_ise_event.dart';
import 'date_w_ise_state.dart';

class DateWiseBloc extends Bloc<DateWiseEvent, DateWiseState> {
  DateWiseBloc() : super(DateWiseInitial()) {
    on<SelectFromDate>(_selectFromDate);
    on<SelectToDate>(_selectToDate);
    on<FetchDateWiseCollection>(_fetchDateWiseCollection);
    on<CurrentDateWiseCollection>(_currentDateWiseCollection);
    on<SelectType>(_selectType);
  }

  FutureOr<void> _selectFromDate(
      SelectFromDate event, Emitter<DateWiseState> emit) {
    if (state is DateWiseLoaded) {
      final currentState = state as DateWiseLoaded;
      emit(currentState.copyWith(
          fromDate: DateFormat("yyyy-MM-dd").parse(event.fromDate)));
      add(FetchDateWiseCollection());
    }
  }

  FutureOr<void> _selectToDate(
      SelectToDate event, Emitter<DateWiseState> emit) {
    if (state is DateWiseLoaded) {
      final currentState = state as DateWiseLoaded;
      emit(currentState.copyWith(
          toDate: DateFormat("yyyy-MM-dd").parse(event.toDate)));
      add(FetchDateWiseCollection());
    }
  }

  FutureOr<void> _fetchDateWiseCollection(
      FetchDateWiseCollection event, Emitter<DateWiseState> emit) async {
    if (state is DateWiseLoaded) {
      final currentState = state as DateWiseLoaded;
      emit(DateWiseLoading());
      log(currentState.type);
      try {
        final response = await SubscriptionRepository().getDateWiseCollection(
          fromDate: DateFormat("yyyy-MM-dd").format(currentState.fromDate),
          toDate: DateFormat("yyyy-MM-dd").format(currentState.toDate),
          type: currentState.type,
        );
        if (response != null) {
          emit(DateWiseLoaded(
            fromDate: currentState.fromDate,
            toDate: currentState.toDate,
            collectionData: response.result ?? [],
            total: response.total ?? 00,
            type: currentState.type,
          ));
        } else {
          emit(DateWiseFailure("No data found for selected dates."));
        }
      } catch (e) {
        emit(DateWiseFailure("Error fetching data: ${e.toString()}"));
      }
    }
  }

  FutureOr<void> _currentDateWiseCollection(
      CurrentDateWiseCollection event, Emitter<DateWiseState> emit) async {
    emit(DateWiseLoading());
    try {
      final response = await SubscriptionRepository().getDateWiseCollection(
          fromDate: event.fromDate, toDate: event.toDate, type: event.type);
      if (response != null) {
        emit(DateWiseLoaded(
          collectionData: response.result ?? [],
          fromDate: DateFormat("yyyy-MM-dd").parse(event.fromDate),
          toDate: DateFormat("yyyy-MM-dd").parse(event.toDate),
          total: response.total ?? 00,
          type: event.type,
        ));
      } else {
        emit(DateWiseFailure("No data found for selected dates."));
      }
    } catch (e) {
      emit(DateWiseFailure("Error fetching data: ${e.toString()}"));
    }
  }

  FutureOr<void> _selectType(SelectType event, Emitter<DateWiseState> emit) {
    if (state is DateWiseLoaded) {
      final currentState = state as DateWiseLoaded;
      emit(currentState.copyWith(type: event.type));
      add(FetchDateWiseCollection());
    }
  }
}
