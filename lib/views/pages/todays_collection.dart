import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mahal_app/bloc/date%20wise%20collection/date_w_ise_bloc.dart';
import 'package:mahal_app/bloc/date%20wise%20collection/date_w_ise_event.dart';
import 'package:mahal_app/bloc/date%20wise%20collection/date_w_ise_state.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/views/widgets/common/app_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_date_selection.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/common/subscription_tile.dart';

class DateWiseCollection extends StatelessWidget {
  final String dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());

  DateWiseCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DateWiseBloc()..add(CurrentDateWiseCollection(dateNow, dateNow)),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130),
            child: CommonAppBar(
              backPress: () {
                context.pop();
              },
              title: 'Date Wise Collections',
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: BlocBuilder<DateWiseBloc, DateWiseState>(
                  builder: (context, state) {
                    if (state is DateWiseLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // From Date Selection
                          CustomDateSelection(
                            onTap: () => _pickFromDate(
                                context, state.fromDate, state.toDate),
                            title:
                                DateFormat('yyyy-MM-dd').format(state.fromDate),
                          ),
                          Container(
                            width: 10,
                            height: 3,
                            color: AppColors.primaryColor,
                          ),
                          // To Date Selection
                          CustomDateSelection(
                            onTap: () => _pickToDate(
                                context, state.fromDate, state.toDate),
                            title:
                                DateFormat('yyyy-MM-dd').format(state.toDate),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
          body: BlocConsumer<DateWiseBloc, DateWiseState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DateWiseLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DateWiseLoaded) {
                return state.collectionData.isEmpty
                    ? const Center(
                        child: CustomText("No Collections."),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(16.0),
                        itemBuilder: (context, index) {
                          final data = state.collectionData[index];
                          return SubscriptionTile(
                            subsData: Subscription(
                              type: data.type.toString(),
                              month: data.month.toString(),
                              year: data.year.toString(),
                              date: "",
                              amount: data.amount,
                            ),
                            houseNo: data.houseno.toString(),
                            familyHead: data.familyhead.toString(),
                            familyName: data.familyname.toString(),
                            collectionDate: data.dateofcollection.toString(),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16.0),
                        itemCount: state.collectionData.length,
                      );
              } else if (state is DateWiseFailure) {
                return Center(
                  child: CustomText(state.message),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  /// Function to Pick "From Date" (must be before or equal to To Date)
  Future<void> _pickFromDate(
    BuildContext context,
    DateTime fromDate,
    DateTime toDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(2000),
      lastDate: toDate, // Ensures user can't pick a date after To Date
    );

    if (picked != null) {
      final dateString = DateFormat('yyyy-MM-dd').format(picked);
      log("date:$dateString");
      context.read<DateWiseBloc>().add(SelectFromDate(fromDate: dateString));
    }
  }

  /// Function to Pick "To Date" (must be after or equal to From Date)
  Future<void> _pickToDate(
      BuildContext context, DateTime fromDate, DateTime toDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate, // Ensures To Date starts from From Date
      firstDate: fromDate, // Ensures user can't pick a date before From Date
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final dateString = DateFormat('yyyy-MM-dd').format(picked);
      context.read<DateWiseBloc>().add(SelectToDate(toDate: dateString));
    }
  }
}
