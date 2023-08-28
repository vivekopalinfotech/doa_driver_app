// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:math';

import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/customcards.dart';
import 'package:geolocator/geolocator.dart';

class OrderScreen extends StatefulWidget {
  String lat = '';
  String lng = '';
  final type;
  var online;
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

   OrderScreen(this.navigateToNext, this.openDrawer,this.online,this.lat,this.lng, {super.key, this.type, });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  bool  online = false;


  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add(const GetOrders());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppStyles.SECOND_COLOR.withOpacity(.2),
        appBar: widget.type == 'order' ? AppBar(
            elevation: 0,
            backgroundColor: AppStyles.MAIN_COLOR,
            iconTheme: const IconThemeData(color: AppStyles.SECOND_COLOR),
            title: const Text(
              "Orders",
              // AppLocalizations.of(context)!.translate('app_name')!,
              style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "MontserratBold",
                  fontWeight: FontWeight.bold,
                  color: AppStyles.SECOND_COLOR
              ),
            )

        ) : const PreferredSize(preferredSize: Size.zero, child: SizedBox()),


        body:  BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrdersLoaded) {

              return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.ordersData.length,
                  itemBuilder: (context,index){
                    return CustomCard(navigateToNext:  widget.navigateToNext,type: 'order',online: widget.online, ordersData: state.ordersData[index],lat: widget.lat,lng: widget.lng,);
                  },),
              ),
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
        ),
    );
  }

}
