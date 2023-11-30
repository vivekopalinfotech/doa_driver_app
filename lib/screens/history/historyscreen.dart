// ignore_for_file: library_private_types_in_public_api, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:doa_driver_app/bloc/history/history_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/order/widgets/customcards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  final lat;
  final lng;

  HistoryScreen(this.navigateToNext, this.openDrawer,  {super.key, this.lat, this.lng});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool online = false;
  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add( GetHistory(AppData.user!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return
              state.ordersData.isNotEmpty
                  ?
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListView.builder(
                    shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.ordersData.length,
              itemBuilder: (context, index) {
                  return  CustomCard(
                    type: 'history',
                    navigateToNext: widget.navigateToNext,
                    ordersData: state.ordersData[index],
                    lat: widget.lat,
                    lng: widget.lng,
                  );
              },

            ),
                )): const Center(
                child: Text('No Orders'),
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
