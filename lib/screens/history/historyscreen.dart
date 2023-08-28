// ignore_for_file: library_private_types_in_public_api

import 'package:doa_driver_app/bloc/history/history_bloc.dart';
import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/order/widgets/customcards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;
  var online;
  final lat;
  final lng;

  HistoryScreen(this.navigateToNext, this.openDrawer, this.online, {super.key, this.lat, this.lng});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool online = false;
  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add(const GetHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.SECOND_COLOR.withOpacity(.2),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return
              state.ordersData.isNotEmpty?
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListView.builder(
                    shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.ordersData.length,
              itemBuilder: (context, index) {
                  return CustomCard(
                    type: 'history',
                    navigateToNext: widget.navigateToNext,
                    ordersData: state.ordersData[index],
                    lat: widget.lat,
                    lng: widget.lng,
                  );
              },

            ),
                )):Center(
                child: Text('No History'),
              );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppStyles.MAIN_COLOR,
            ),
          );
        },
      ),
    );
  }
}
