import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:mahal_app/core/apis.dart';
import 'package:mahal_app/model/subscription/subscription_add.dart';
import 'package:mahal_app/repositories/subscription_repo.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal_windows.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc() : super(PrinterInitial()) {
    on<InitPrinter>(_onInitPrinter);
    on<SearchPrinters>(_onSearchPrinters);
    on<ConnectPrinter>(_onConnectPrinter);
    on<DisconnectPrinter>(_onDisconnectPrinter);
    on<PrintReceipt>(_printReceipt);
    on<CheckConnection>(_onConnectionCheck);
    on<SubmitReceipt>(_submitReceipt);
  }

  Future<void> _onInitPrinter(
      InitPrinter event, Emitter<PrinterState> emit) async {
    try {
      emit(PrinterLoading());

      String platformVersion = await PrintBluetoothThermal.platformVersion;
      int batteryLevel = await PrintBluetoothThermal.batteryLevel;
      bool isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
      bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
      log("is Bluetooth On :$isBluetoothEnabled");
      log("connection Status: $connectionStatus");
      emit(PrinterLoaded(
          platformVersion: platformVersion,
          batteryLevel: batteryLevel,
          isBluetoothEnabled: isBluetoothEnabled,
          pairedDevices: [],
          isConnected: connectionStatus,
          message: "Bluetooth ${isBluetoothEnabled ? "enabled" : "disabled"}",
          macId: ""));
      getConnectedBluetoothDevice();
    } catch (e) {
      emit(PrinterError(error: e.toString()));
    }
  }

  Future<void> _onSearchPrinters(
      SearchPrinters event, Emitter<PrinterState> emit) async {
    try {
      if (state is PrinterLoaded) {
        final currentState = state as PrinterLoaded;
        bool isBluetoothEnabled = await PrintBluetoothThermal.bluetoothEnabled;
        if (isBluetoothEnabled) {
          emit(PrinterLoading()); // Show loading state before updating

          final List<BluetoothInfo> devices =
              await PrintBluetoothThermal.pairedBluetooths;

          // Emit a new PrinterLoaded state, keeping previous values
          emit(currentState.copyWith(
            isBluetoothEnabled: isBluetoothEnabled,
            pairedDevices: devices,
            message: devices.isEmpty
                ? "No Bluetooth devices found. Please pair a printer first."
                : "Select a printer to connect.",
          ));
        } else {
          emit(currentState.copyWith(
            message: "Please turn on Bluetooth",
          ));
        }
      } else {
        emit(PrinterError(error: "Cannot refresh devices. Invalid state."));
      }
    } catch (e) {
      emit(PrinterError(error: "Failed to search printers: ${e.toString()}"));
    }
  }

  Future<void> _onConnectionCheck(event, Emitter<PrinterState> emit) async {
    try {
      if (state is PrinterLoaded) {
        final connectionStatus = await PrintBluetoothThermal.connectionStatus;
        log("ConnectionSatus ${connectionStatus.toString()}");
        if (!connectionStatus) {
          await _onConnectPrinter(
              ConnectPrinter(macAddress: event.macAddress), emit);
        } else {
          await _onDisconnectPrinter(DisconnectPrinter(), emit);
        }
      } else {
        log("status false");
        emit(PrinterError(error: "Cannot refresh devices. Invalid state."));
      }
    } catch (e) {
      log(e.toString());
      emit(PrinterError(error: e.toString()));
    }
  }

  Future<void> _onConnectPrinter(
      ConnectPrinter event, Emitter<PrinterState> emit) async {
    log("on connect worked");
    try {
      if (state is PrinterLoaded) {
        final connectionStatus = await PrintBluetoothThermal.connectionStatus;
        log("ConnectionSatus ${connectionStatus.toString()}");
        if (!connectionStatus) {
          final currentState = state as PrinterLoaded;
          emit(PrinterLoading());
          bool connected = await PrintBluetoothThermal.connect(
              macPrinterAddress: event.macAddress);
          log("status ${connected.toString()}");
          emit(currentState.copyWith(
            isConnected: connected,
            message: connected ? "Connected to printer!" : "Failed to connect.",
            macId: event.macAddress,
          ));
        } else {}
      } else {
        log("status false");
        emit(PrinterError(error: "Cannot refresh devices. Invalid state."));
      }
    } catch (e) {
      log(e.toString());
      emit(PrinterError(error: e.toString()));
    }
  }

  Future<void> _onDisconnectPrinter(
      DisconnectPrinter event, Emitter<PrinterState> emit) async {
    await PrintBluetoothThermal.disconnect;
    final currentState = state as PrinterLoaded;
    emit(currentState.copyWith(
      isConnected: false,
      message: "Disconnected from printer.",
      macId: '',
    ));
  }

  Future<void> getConnectedBluetoothDevice() async {
    bool isConnected = await PrintBluetoothThermal.connectionStatus;
    if (isConnected) {
      List<BluetoothInfo> pairedDevices =
          await PrintBluetoothThermal.pairedBluetooths;
      for (var device in pairedDevices) {
        bool connected = await PrintBluetoothThermal.connectionStatus;
        if (connected) {
          log(device.name);
        }
      }
    } else {
      log("No device connected");
    }
  }

  FutureOr<void> _printReceipt(
      PrintReceipt event, Emitter<PrinterState> emit) async {
    final currentState = state as PrinterLoaded;
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;
    if (connectionStatus) {
      log("Bluetooth connected");
      emit(PrinterLoading());
      final reponse =
          await SubscriptionRepository().addSubcription(event.receiptData);
      if (reponse != null && reponse.status == true) {
        List<int> ticket = await testTicket(event.receiptData);
        bool result = await PrintBluetoothThermal.writeBytes(ticket);
        if (result) {
          emit(currentState.copyWith(message: "Printed Successfully"));
        } else {
          emit(currentState.copyWith(
              message: "Not Printed, Something went wrong"));
        }
      } else {
        emit(
            currentState.copyWith(message: "Something went wrong. try again!"));
      }
    } else {
      emit(currentState.copyWith(message: "Printer Not Connected!"));
    }
  }

  Future<List<int>> testTicket(SubscriptionAdd data) async {
    List<int> bytes = [];

    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);

    bytes += generator.reset();
    bytes += generator.text(
      mahalName,
      styles: const PosStyles(
          align: PosAlign.center, bold: true, height: PosTextSize.size2),
    );
    bytes += generator.feed(1);

    bytes += generator.text('Type : ${data.type}');
    bytes += generator.text('House No : ${data.houseNo}');
    bytes += generator.text('Family Head : ${data.houseHead}');
    bytes += generator.text('House Name : ${data.houseName}');
    bytes += generator.text('Date : ${data.dateOfCollection}');
    bytes += generator.text('Year : ${data.year}');
    bytes += generator.text('Months: ${data.month.join(", ")}');
    bytes += generator.text('Amount : ${data.amount}');
    bytes += generator.feed(1);

    bytes += generator.text(
      'Thank You',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    );

    bytes += generator.cut();
    return bytes;
  }

  FutureOr<void> _submitReceipt(
      SubmitReceipt event, Emitter<PrinterState> emit) async {
    final currentState = state as PrinterLoaded;
    emit(PrinterLoading());
    final reponse =
        await SubscriptionRepository().addSubcription(event.subscriptioData);
    if (reponse != null && reponse.status == true) {
      if (reponse.status ?? false) {
        emit(currentState.copyWith(message: "Successfully Added"));
      } else {
        emit(
            currentState.copyWith(message: "Not Stored, Something went wrong"));
      }
    } else {
      emit(currentState.copyWith(message: "Something went wrong. try again!"));
    }
  }
}
