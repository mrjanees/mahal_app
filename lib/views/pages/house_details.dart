import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mahal_app/bloc/subscription/subscription_bloc.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/subscription/huse_details.dart';
import 'package:mahal_app/model/subscription/subscription_add.dart';
import 'package:mahal_app/utils/snack_bar.dart';
import 'package:mahal_app/views/pages/prinitng.dart';
import 'package:mahal_app/views/pages/subscription_history.dart';
import 'package:mahal_app/views/widgets/common/app_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_botton.dart';
import 'package:mahal_app/views/widgets/common/custom_image.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/common/custom_text_form_field.dart';

class HouseDetails extends StatelessWidget {
  final TextEditingController amountCtrl = TextEditingController();
  final nowDate = DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
  final formGlobalKey = GlobalKey<FormState>();
  HouseDetails({super.key});

  @override
  Widget build(BuildContext context) {
    log("Mian Build Called");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            80,
          ),
          child: CommonAppBar(
            backPress: () {
              context.pop();
            },
            title: 'House Subscription',
          )),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
          builder: (context, state) {
        log("bloc Consumer rebuild");
        return Center(
          child: state is HouseDetialsLoading
              ? const CustomText("Detials Loading")
              : state is HouseDetailsLoaded
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: formGlobalKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              houseDetails(state.houseDetials, context),
                              const SizedBox(
                                height: kSpace * 2,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // toggleButton(context, "Masjid",
                                    //     Selection.masjid, state.selectedValue),
                                    // const SizedBox(
                                    //   width: kSpace,
                                    // ),
                                    toggleButton(
                                        context,
                                        "Madrasa",
                                        Selection.madhrasa,
                                        state.selectedValue),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: kSpace * 2,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.1), // Shadow color with opacity
                                      spreadRadius:
                                          1, // How much the shadow spreads
                                      blurRadius: 8, // Blur effect
                                      offset: const Offset(
                                          0, 3), // Shadow position (x, y)
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    yearDropdown(context, state.selectedYear),
                                    const Divider(),
                                    monthSelectionGrid(
                                        context, state.selectedMonths),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: kSpace * 2,
                              ),
                              const CustomText(
                                "Amount",
                                fontWeight: FontWeight.bold,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomSvgImage(
                                    imageName: "rupees",
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: CustomTextField(
                                        textEditingController: amountCtrl,
                                        name: "amount",
                                        isThisFieldRequired: true),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: kSpace,
                              ),
                              Align(
                                  alignment: Alignment.center,
                                  child: CustomButton(
                                      onTap: () {
                                        // context.read<SubscriptionBloc>().add(
                                        //     SaveButtonPress(SubscriptionAdd(
                                        //         state.houseDetials.houseno
                                        //             .toString(),
                                        //         state.selectedValue.name,
                                        //         state.selectedMonths.toList(),
                                        //         state.selectedYear.toString(),
                                        //         nowDate,
                                        //         amountCtrl.text.trim())));
                                        if (formGlobalKey.currentState!
                                            .validate()) {
                                          if (state.selectedMonths.isNotEmpty) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubscriptionPrinting(
                                                        addSubscriptionData: SubscriptionAdd(
                                                            state.houseDetials
                                                                .houseno
                                                                .toString(),
                                                            state.selectedValue
                                                                .name,
                                                            state.selectedMonths
                                                                .toList(),
                                                            state.selectedYear
                                                                .toString(),
                                                            state.houseDetials
                                                                .familyname
                                                                .toString(),
                                                            state.houseDetials
                                                                .familyhead
                                                                .toString(),
                                                            nowDate,
                                                            amountCtrl.text),
                                                      )),
                                            );
                                          } else {
                                            customSnackBar(
                                                context, "Please Select Month");
                                          }
                                        }
                                      },
                                      title: "Save"))
                            ],
                          ),
                        ),
                      ),
                    )
                  : state is HouseDetailsFailure
                      ? CustomText(state.message)
                      : state is HouseDetailsError
                          ? CustomText(state.message)
                          : const SizedBox(),
        );
      }, listener: (context, state) {
        if (state is HouseDetailsLoaded) {
          final selectedCount = state.selectedMonths.toList().length;
          log(selectedCount.toString());
          final totalAmount =
              selectedCount * int.parse(state.houseDetials.familyAmount ?? "0");

          log(totalAmount.toString());
          // Update the controller
          amountCtrl.text = totalAmount.toString();
        }
      }),
    );
  }

  Widget houseDetails(HouseDetials details, BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(kSpace),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color with opacity
              spreadRadius: 1, // How much the shadow spreads
              blurRadius: 8, // Blur effect
              offset: const Offset(0, 3), // Shadow position (x, y)
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSvgImage(
                    imageName: "house",
                  ),
                  const SizedBox(
                    width: kSpace,
                  ),
                  const CustomText(
                    "House No",
                    color: AppColors.black54,
                  ),
                  CustomText(
                    ": ${details.houseno}",
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: kSpace,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  "Fmaily Head ",
                  color: AppColors.black54,
                ),
                Flexible(
                  child: CustomText(
                    ": ${details.familyhead}  ",
                    maxLines: 3,
                    color: AppColors.black,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kSpace,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  "Fmaily Name ",
                  color: AppColors.black54,
                ),
                Flexible(
                  child: CustomText(
                    ": ${details.familyname} ",
                    color: AppColors.black,
                    maxLines: 3,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kSpace,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  "Fmaily Amount",
                  color: AppColors.black54,
                ),
                Flexible(
                  child: CustomText(
                    ": ${details.familyAmount} ",
                    color: AppColors.black,
                    maxLines: 3,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: kSpace,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomSvgImage(
                  imageName: "calendar",
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: kSpace,
                ),
                const CustomText(
                  "Date ",
                  color: AppColors.black54,
                ),
                CustomText(
                  ": $nowDate",
                  color: AppColors.black,
                )
              ],
            ),
            const SizedBox(
              height: kSpace * 2,
            ),
            Align(
              alignment: Alignment.center,
              child: CustomButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubscriptionHistory(
                            subscriptionList: details.subscription ?? [])),
                  );
                },
                title: "View History",
                fontSize: 13,
              ),
            )
          ],
        ));
  }

  Widget toggleButton(
      BuildContext context, String text, Selection value, Selection selected) {
    bool isSelected = selected == value;
    return GestureDetector(
      onTap: () => context
          .read<SubscriptionBloc>()
          .add(ToggleChangeType(selection: value)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.black38,
            )),
        child: CustomText(
          text,
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget yearDropdown(BuildContext context, int selectedYear) {
    List<int> years =
        List.generate(10, (index) => DateTime.now().year - 5 + index);

    return Padding(
      padding: const EdgeInsets.only(left: kSpace),
      child: Row(
        children: [
          CustomSvgImage(
            imageName: 'calendar',
            color: AppColors.primaryColor,
            height: 35,
            width: 35,
          ),
          const SizedBox(width: 8),
          const CustomText(
            "Year:",
            fontWeight: FontWeight.bold,
            color: AppColors.black54,
          ),
          const SizedBox(width: 8),
          DropdownButton<int>(
            value: selectedYear,
            underline: const SizedBox(),
            items: years.map((year) {
              return DropdownMenuItem<int>(
                value: year,
                child: CustomText(
                  year.toString(),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              );
            }).toList(),
            onChanged: (year) {
              if (year != null) {
                context.read<SubscriptionBloc>().add(SelectYearEvent(year));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget monthSelectionGrid(BuildContext context, Set<String> selectedMonths) {
    List<String> months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
      ),
      itemCount: months.length,
      itemBuilder: (context, index) {
        String month = months[index];
        bool isSelected = selectedMonths.contains(month);

        return GestureDetector(
          onTap: () {
            context
                .read<SubscriptionBloc>()
                .add(ToggleMonthSelectionEvent(month));
          },
          child: Row(
            children: [
              Checkbox(
                value: isSelected,
                activeColor: AppColors.primaryColor,
                onChanged: (value) {
                  context
                      .read<SubscriptionBloc>()
                      .add(ToggleMonthSelectionEvent(month));
                },
              ),
              Text(month),
            ],
          ),
        );
      },
    );
  }
}
