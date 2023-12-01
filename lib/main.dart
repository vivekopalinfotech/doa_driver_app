
import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/bloc/delivery_update/delivery_update_bloc.dart';
import 'package:doa_driver_app/bloc/history/history_bloc.dart';
import 'package:doa_driver_app/bloc/login/mobile_bloc.dart';
import 'package:doa_driver_app/bloc/online/online_bloc.dart';
import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/bloc/order_status/check_order_status_bloc.dart';
import 'package:doa_driver_app/bloc/otp/otp_bloc.dart';
import 'package:doa_driver_app/bloc/payment/payment_bloc.dart';
import 'package:doa_driver_app/repos/auth_repo.dart';
import 'package:doa_driver_app/repos/check_order_status_repo.dart';
import 'package:doa_driver_app/repos/history_repo.dart';
import 'package:doa_driver_app/repos/mobile_repo.dart';
import 'package:doa_driver_app/repos/online_repo.dart';
import 'package:doa_driver_app/repos/order_repo.dart';
import 'package:doa_driver_app/repos/otp_repo.dart';
import 'package:doa_driver_app/repos/update_delivery.dart';
import 'package:doa_driver_app/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
      RestartWidget(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(RealAuthRepo())),
        BlocProvider(create: (context) => OnlineBloc(RealOnlineRepo())),
        BlocProvider(create: (context) => MobileBloc(RealMobileRepo())),
        BlocProvider(create: (context) => OtpBloc(RealOtpRepo())),
        BlocProvider(create: (context) => OrdersBloc(RealOrderRepo()),),
        BlocProvider(create: (context) => HistoryBloc(RealHistoryRepo()),),
        BlocProvider(create: (context) => DeliveryUpdateBloc(RealDeliveryUpdateRepo()),),
        BlocProvider(create: (context) => OrderStatusBloc(RealOrderStatusRepo()),),
        BlocProvider(create: (context) => PaymentBloc(RealOrderStatusRepo()),),
      ],
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MyHomePage(),
    );
  }
}
class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key,  required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}
class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
