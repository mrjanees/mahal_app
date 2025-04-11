import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mahal_app/bloc/login/login_bloc.dart';
import 'package:mahal_app/bloc/printer/printer_bloc.dart';
import 'package:mahal_app/bloc/subscription/subscription_bloc.dart';
import 'package:mahal_app/core/color.dart';
import 'package:mahal_app/core/router.dart';
import 'package:mahal_app/service_locator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator(); //
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(
      const Duration(seconds: 2), () => FlutterNativeSplash.remove());
  await requestBluetoothPermissions(); //
  runApp(const MyApp());
}

Future<void> requestBluetoothPermissions() async {
  // Request all needed permissions
  Map<Permission, PermissionStatus> statuses = await [
    Permission.bluetooth,
    Permission.bluetoothScan,
    Permission.bluetoothConnect,
    Permission.location,
  ].request();

  // Print out status for each permission
  statuses.forEach((permission, status) {
    print('Permission $permission: ${status.isGranted ? 'GRANTED' : 'DENIED'}');
  });

  // Optional: Open settings if permissions are permanently denied
  if (statuses.values.any((status) => status.isPermanentlyDenied)) {
    await openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginBloc>()),
        BlocProvider(create: (context) => getIt<SubscriptionBloc>()),
        BlocProvider(
          create: (_) => PrinterBloc()..add(InitPrinter()),
        )
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: MaterialApp.router(
          title: 'Mahal App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: AppColors.primaryColor,
                  statusBarIconBrightness: Brightness.light,
                ),
              )),
          routerConfig: router,
        ),
      ),
    );
  }
}
