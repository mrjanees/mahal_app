import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/bloc/printer/printer_bloc.dart';
import 'package:mahal_app/core/apis.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/model/subscription/subscription_add.dart';
import 'package:mahal_app/utils/snack_bar.dart';
import 'package:mahal_app/views/widgets/common/app_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_botton.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class SubscriptionPrinting extends StatelessWidget {
  final SubscriptionAdd addSubscriptionData;
  const SubscriptionPrinting({super.key, required this.addSubscriptionData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            80,
          ),
          child: CommonAppBar(
            backPress: () {
              context.pop();
            },
            title: 'Subscription Printing',
          )),
      body: BlocConsumer<PrinterBloc, PrinterState>(
        listener: (context, state) {
          if (state is PrinterLoaded) {
            customSnackBar(context, state.message);
            if (state.message == "Successfully Added" ||
                state.message == "Printed Successfully") {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          if (state is PrinterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrinterLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(kSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const CustomText(
                    //       "Paired Devices",
                    //       color: AppColors.black,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //     CustomButton(
                    //       onTap: () {
                    //         context.read<PrinterBloc>().add(SearchPrinters());
                    //       },
                    //       title: "Search Devices",
                    //       fontSize: 13,
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //     padding: const EdgeInsets.all(kSpace),
                    //     width: double.infinity,
                    //     height: 250,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(15),
                    //       color: AppColors.whiteColor,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           color: Colors.black.withOpacity(
                    //               0.1), // Shadow color with opacity
                    //           spreadRadius: 1, // How much the shadow spreads
                    //           blurRadius: 8, // Blur effect
                    //           offset:
                    //               const Offset(0, 3), // Shadow position (x, y)
                    //         ),
                    //       ],
                    //     ),
                    //     child: state.isBluetoothEnabled == true
                    //         ? state.pairedDevices.isNotEmpty
                    //             ? ListView(
                    //                 children: state.pairedDevices
                    //                     .map((device) => ListTile(
                    //                           onTap: () {
                    //                             context.read<PrinterBloc>().add(
                    //                                 ConnectPrinter(
                    //                                     macAddress:
                    //                                         device.macAdress));
                    //                           },
                    //                           title: Row(
                    //                             children: [
                    //                               CustomText(device.name),
                    //                               state.macId.toString() ==
                    //                                       device.macAdress
                    //                                           .toString()
                    //                                   ? state.isConnected
                    //                                       ? const CustomText(
                    //                                           " Conneted",
                    //                                           color: AppColors
                    //                                               .greeen,
                    //                                         )
                    //                                       : const SizedBox()
                    //                                   : const SizedBox()
                    //                             ],
                    //                           ),
                    //                           trailing: state.macId
                    //                                       .toString() ==
                    //                                   device.macAdress
                    //                                       .toString()
                    //                               ? state.isConnected
                    //                                   ? IconButton(
                    //                                       onPressed: () {
                    //                                         context
                    //                                             .read<
                    //                                                 PrinterBloc>()
                    //                                             .add(
                    //                                                 DisconnectPrinter());
                    //                                       },
                    //                                       icon: const Icon(
                    //                                           Icons.cancel,
                    //                                           color:
                    //                                               Colors.red))
                    //                                   : const SizedBox()
                    //                               : const SizedBox(),
                    //                           subtitle: CustomText(
                    //                             device.macAdress,
                    //                             fontSize: 12,
                    //                           ),
                    //                         ))
                    //                     .toList(),
                    //               )
                    //             : const Center(
                    //                 child: CustomText("No devices found."),
                    //               )
                    //         : const Center(
                    //             child: CustomText(
                    //                 "Bluetooth is off. Please On it!."),
                    //           )),
                    // const SizedBox(
                    //   height: kSpace,
                    // ),
                    const Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          "Receipt",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        )),
                    const SizedBox(
                      height: kSpace,
                    ),
                    subscriptionPreview(addSubscriptionData),
                    const SizedBox(
                      height: kSpace * 2,
                    ),

                    Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                            onTap: () {
                              context
                                  .read<PrinterBloc>()
                                  .add(PrintReceipt(addSubscriptionData));
                            },
                            title: "SUBMIT AND PRINT")),
                    const SizedBox(
                      height: kSpace,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: kSpace,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                            onTap: () {
                              context
                                  .read<PrinterBloc>()
                                  .add(SubmitReceipt(addSubscriptionData));
                            },
                            title: "SUBMIT")),
                    const SizedBox(
                      height: kSpace * 3,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget subscriptionPreview(SubscriptionAdd data) {
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
          const SizedBox(
            height: kSpace,
          ),
          const Align(
              alignment: Alignment.center,
              child: CustomText(
                mahalName,
                textAlign: TextAlign.center,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("Type : ${data.type}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("House No : ${data.houseNo}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("Family Head : ${data.houseHead}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("House Name : ${data.houseName}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("Date : ${data.dateOfCollection}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("Year : ${data.year}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("Months: ${data.month.toString()}"),
          const SizedBox(
            height: kSpace,
          ),
          CustomText("Amount : ${data.amount}"),
          const SizedBox(
            height: kSpace * 2,
          ),
          const Align(
            alignment: Alignment.center,
            child: CustomText(
              'Thank You',
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
