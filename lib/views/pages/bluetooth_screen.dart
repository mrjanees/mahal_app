import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/bloc/printer/printer_bloc.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/utils/snack_bar.dart';
import 'package:mahal_app/views/widgets/common/app_bar.dart';
import 'package:mahal_app/views/widgets/common/custom_botton.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';

class BluetoothScreen extends StatelessWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PrinterBloc printerBloc = context.read<PrinterBloc>();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        printerBloc.add(SearchPrinters());
      },
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: CommonAppBar(
          backPress: () {
            context.pop();
          },
          title: 'Bluetooth Devices',
        ),
      ),
      body: BlocConsumer<PrinterBloc, PrinterState>(
        listener: (context, state) {
          if (state is PrinterLoaded) {
            customSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is PrinterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrinterLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(kSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        "Paired Devices",
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      CustomButton(
                        onTap: () {
                          printerBloc.add(SearchPrinters());
                        },
                        title: "Search Devices",
                        fontSize: 13,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(kSpace),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: state.isBluetoothEnabled
                        ? state.pairedDevices.isNotEmpty
                            ? ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: state.pairedDevices.map((device) {
                                  final isCurrent =
                                      state.macId == device.macAdress;
                                  return ListTile(
                                    onTap: () {
                                      printerBloc.add(CheckConnection(
                                          macAddress: device.macAdress));
                                    },
                                    title: Row(
                                      children: [
                                        CustomText(device.name),
                                        if (isCurrent && state.isConnected)
                                          const CustomText(
                                            "  Connected",
                                            color: AppColors.greeen,
                                          ),
                                      ],
                                    ),
                                    trailing: isCurrent && state.isConnected
                                        ? IconButton(
                                            icon: const Icon(Icons.cancel,
                                                color: Colors.red),
                                            onPressed: () {
                                              printerBloc
                                                  .add(DisconnectPrinter());
                                            },
                                          )
                                        : null,
                                    subtitle: CustomText(
                                      device.macAdress,
                                      fontSize: 12,
                                    ),
                                  );
                                }).toList(),
                              )
                            : const Center(
                                child: CustomText("No devices found."),
                              )
                        : const Center(
                            child: CustomText(
                                "Bluetooth is off. Please turn it on."),
                          ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
