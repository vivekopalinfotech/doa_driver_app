// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';

import 'package:doa_driver_app/bloc/shift/shift_bloc.dart';
import 'package:doa_driver_app/bloc/shifts_data/shifts_data_bloc.dart';
import 'package:doa_driver_app/bloc/shifts_data/shifts_data_event.dart';
import 'package:doa_driver_app/bloc/shifts_data/shifts_data_state.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/constants/showsnackbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class ShiftScreen extends StatefulWidget {
  final type;

  ShiftScreen({
    Key? key,
    this.type,
  }) : super(key: key);

  @override
  State<ShiftScreen> createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  bool online = false;

  File? imageFile;
  int i = 0;

  @override
  void initState() {
    BlocProvider.of<ShiftsDataBloc>(context).add(GetShiftsData(AppData.user!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocListener(
            listeners: [
          BlocListener<UpdateShiftBloc, UpdateShiftState>(
            listener: (context, state) {
              if (state is UpdateShiftSuccess) {
                Loader.hide();
                BlocProvider.of<ShiftsDataBloc>(context).add(GetShiftsData(AppData.user!.id));
              }
              // if (state is UpdateShiftLoading) {
              // loader(context);
              // }
              if (state is UpdateShiftFailed) {
                Loader.hide();
              }
            },
          )
        ],
            child: BlocBuilder<ShiftsDataBloc, ShiftsDataState>(
              builder: (context, state) {
                if (state is ShiftsDataLoading) {
                  loader(context);
                }
                if (state is ShiftsDataLoaded) {
                  Loader.hide();
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Container(
                            decoration: BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                          child: Text(
                                        'Amount Delivered',
                                        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                      )),
                                      Text(
                                        '${state.shiftsDataResponse.data!.Total_Deliver_Order}/\$${state.shiftsDataResponse.data!.Total_Deliver_Amount!.toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                          child: Text(
                                        'Pending Amount',
                                        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                      )),
                                      Text(
                                        '${state.shiftsDataResponse.data!.Total_Pending_Order}/\$${state.shiftsDataResponse.data!.Total_Pending_Amount!.toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                          child: Text(
                                        'Opening Amount',
                                        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                      )),
                                      Text(
                                        '\$${0.00.toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                          child: Text(
                                        'Cash Traders',
                                        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                      )),
                                      Text(
                                        '\$${state.shiftsDataResponse.data!.Total_cash!.toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Flexible(
                                          child: Text(
                                        'Expected Drawer',
                                        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
                                      )),
                                      Text(
                                        '\$${state.shiftsDataResponse.data!.Total_cc!.toStringAsFixed(2)}',
                                        style: const TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        state.shiftsDataResponse.data!.Availability_status == '1'
                            ? InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  state.shiftsDataResponse.data!.Total_Pending_Order != 0
                                      ? ''
                                      : showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                // Your dialog content and actions go here
                                                return AlertDialog(
                                                  content: const Text("Are you sure you want to close shift?"),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text("No"),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text("Yes"),
                                                      onPressed: () {
                                                        FirebaseMessaging.instance.getToken().then((value) {
                                                          BlocProvider.of<UpdateShiftBloc>(context).add(CheckUpdateShift(int.parse(AppData.user!.id.toString()), 0, value ?? ''));
                                                        });
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  child: Container(
                                    color: state.shiftsDataResponse.data!.Total_Pending_Order != 0 ? Colors.grey : Colors.red,
                                    height: 60,
                                    child: const Center(
                                      child: Text(
                                        'Close Shift',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          // Your dialog content and actions go here
                                          return AlertDialog(
                                            content: const Text("Are you sure you want to open shift?"),
                                            actions: [
                                              TextButton(
                                                child: const Text("No"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Yes"),
                                                onPressed: () {
                                                  FirebaseMessaging.instance.getToken().then((value) {
                                                    BlocProvider.of<UpdateShiftBloc>(context).add(CheckUpdateShift(int.parse(AppData.user!.id.toString()), 1, value ?? ''));
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  child: Container(
                                    color: Colors.green,
                                    height: 60,
                                    child: const Center(
                                      child: Text(
                                        'Open Shift',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            BlocProvider.of<ShiftsDataBloc>(context).add(GetShiftsData(AppData.user!.id));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            child: Container(
                              color: Colors.black12,
                              height: 60,
                              child: const Center(
                                child: Text(
                                  'Refresh',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppStyles.MAIN_COLOR,
                  ),
                );
              },
            )
            //    ),
            ));
  }
}
