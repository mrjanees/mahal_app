part of 'printer_bloc.dart';

sealed class PrinterState {}

// Initial State
class PrinterInitial extends PrinterState {}

// Loading State
class PrinterLoading extends PrinterState {}

// Loaded State (Bluetooth info, battery, etc.)
class PrinterLoaded extends PrinterState {
  final String platformVersion;
  final int batteryLevel;
  final bool isBluetoothEnabled;
  final List<BluetoothInfo> pairedDevices;
  final bool isConnected;
  final String message;
  final String macId;

  PrinterLoaded({
    required this.platformVersion,
    required this.batteryLevel,
    required this.isBluetoothEnabled,
    required this.pairedDevices,
    required this.isConnected,
    required this.message,
    required this.macId,
  });

  PrinterLoaded copyWith({
    String? platformVersion,
    int? batteryLevel,
    bool? isBluetoothEnabled,
    List<BluetoothInfo>? pairedDevices,
    bool? isConnected,
    String? message,
    String? macId,
  }) {
    return PrinterLoaded(
      platformVersion: platformVersion ?? this.platformVersion,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isBluetoothEnabled: isBluetoothEnabled ?? this.isBluetoothEnabled,
      pairedDevices: pairedDevices ?? this.pairedDevices,
      isConnected: isConnected ?? this.isConnected,
      message: message ?? this.message,
      macId: macId ?? this.macId,
    );
  }
}

// Error State
class PrinterError extends PrinterState {
  final String error;
  PrinterError({required this.error});

  @override
  List<Object> get props => [error];
}
