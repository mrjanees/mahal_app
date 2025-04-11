import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mahal_app/bloc/printer/printer_bloc.dart';
import 'package:mahal_app/core/apis.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/cost_value.dart';
import 'package:mahal_app/utils/snack_bar.dart';
import 'package:mahal_app/views/pages/bluetooth_screen.dart';
import 'package:mahal_app/views/widgets/common/custom_image.dart';
import 'package:mahal_app/views/widgets/common/custom_text.dart';
import 'package:mahal_app/views/widgets/dash_board.dart/option_tile.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PrinterBloc, PrinterState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PrinterLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrinterLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double
                        .infinity, // Ensures the parent container takes full width
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                            width: double
                                .infinity, // Forces the SVG to take full width
                            child: CustomSvgImage(
                              imageName: 'dashboard_vector',
                            )),
                        const Column(
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            CustomPngImage(
                              imageName: 'icon_image',
                              height: 100,
                              width: 100,
                            ),
                            CustomText(
                              mahalName,
                              textAlign: TextAlign.center,
                              color: AppColors.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  BlocBuilder<PrinterBloc, PrinterState>(
                    builder: (context, state) {
                      String statusText = "Not Connected";
                      IconData statusIcon = Icons.bluetooth_disabled;

                      if (state is PrinterLoaded) {
                        if (state.isConnected) {
                          statusText = "Device Connected";
                          statusIcon = Icons.bluetooth_connected;
                        }
                      }

                      return InkWell(
                        onTap: () {
                          // Navigate to BluetoothScreen for device selection

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BluetoothScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: kSpace * 3),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: kSpace, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                statusIcon,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: kSpace),
                              CustomText(
                                statusText,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: kSpace,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpace * 3),
                    child: OptionTile(
                      icon: 'payment',
                      onTap: () async {
                        // final connection =
                        //     await PrintBluetoothThermal.connectionStatus;
                        // final isEnabled =
                        //     await PrintBluetoothThermal.bluetoothEnabled;
                        // if (state.isConnected && connection && isEnabled) {
                        //   context.push("/subscription");
                        // } else if (!isEnabled) {
                        //   customSnackBar(context, "Please Turn on Bluetooth");
                        // } else if (state.isConnected == false ||
                        //     connection == false) {
                        //   customSnackBar(
                        //       context, "Please Connect with Printer");
                        // }
                        context.push("/subscription");
                      },
                      title: 'Monthly House Subscription',
                    ),
                  ),
                  const SizedBox(
                    height: kSpace,
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
