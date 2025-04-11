part of 'printer_bloc.dart';

sealed class PrinterEvent {}

// Initial Event
class InitPrinter extends PrinterEvent {}

// Search for Bluetooth devices
class SearchPrinters extends PrinterEvent {}

class CheckConnection extends PrinterEvent {
  final String macAddress;
  CheckConnection({required this.macAddress});

  @override
  List<Object> get props => [macAddress];
}

// Connect to a Bluetooth printer
class ConnectPrinter extends PrinterEvent {
  final String macAddress;
  ConnectPrinter({required this.macAddress});

  @override
  List<Object> get props => [macAddress];
}

// Disconnect from a printer
class DisconnectPrinter extends PrinterEvent {}

// Print receipt
class PrintReceipt extends PrinterEvent {
  SubscriptionAdd receiptData;
  PrintReceipt(this.receiptData);
}

class SubmitReceipt extends PrinterEvent {
  SubscriptionAdd subscriptioData;
  SubmitReceipt(this.subscriptioData);
}
