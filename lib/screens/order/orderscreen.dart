// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:async';
import 'dart:math';

import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'widgets/customcards.dart';
import 'package:geolocator/geolocator.dart';

class OrderScreen extends StatefulWidget {
  final lat;
  final lng;
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

  LocationData? currentLocation;
  final Completer<GoogleMapController> controller = Completer();
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
          (location) {
        currentLocation = location;

      },
    );

    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
          (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }
  @override
  void initState() {
    BlocProvider.of<OrdersBloc>(context).add( GetOrders(AppData.user!.id));
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
                    return CustomCard(navigateToNext:  widget.navigateToNext,
                        type: 'order',online: widget.online,
                        ordersData: state.ordersData[index],
                        lat:widget.lat,lng: widget.lng,
                    customerAddress: state.ordersData[index].customerId!=null?
                    state.ordersData[index].customerId!.customer_address![index]:'',);
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
