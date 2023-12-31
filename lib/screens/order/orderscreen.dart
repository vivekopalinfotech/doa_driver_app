// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:async';
import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/constants/showsnackbar.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:doa_driver_app/tweaks/location_service.dart';
import 'package:doa_driver_app/utils/NotificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geolocator/geolocator.dart';

class OrderScreen extends StatefulWidget {
  final type;

  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  const OrderScreen(
    this.navigateToNext,
    this.openDrawer, {
    super.key,
    this.type,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool online = false;
  late bool serviceEnabled;
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> _callSplashScreen() async {
    Position position = await _getGeoLocationPosition();
    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future<Position> _getGeoLocationPosition() async {
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } else {}

    return await Geolocator.getCurrentPosition();
  }

  LocationService locationService = LocationService();
  @override
  void initState() {
    super.initState();
    locationService.startLocationService(context);
    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
    _callSplashScreen();
   context.read<NotificationProvider>().addListener(_refreshPage);
  }

  _refreshPage() {
    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
  }

  @override
  void didChangeDependencies() {
   context.read<NotificationProvider>().removeListener(_refreshPage);
    //_callSplashScreen();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    context.read<NotificationProvider>().removeListener(_refreshPage);
    super.dispose();
  }

  var lat;
  var lng;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.type == 'order'
          ? AppBar(
              elevation: 0,
              backgroundColor: AppStyles.MAIN_COLOR,
              iconTheme: const IconThemeData(color: AppStyles.SECOND_COLOR),
              title: const Text(
                "Orders",
                style: TextStyle(fontSize: 20.0, fontFamily: "MontserratBold", fontWeight: FontWeight.bold, color: AppStyles.SECOND_COLOR),
              ))
          : const PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      body:
          // UpgradeAlert(
          //   upgrader: Upgrader(
          //     dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
          //     debugDisplayAlways: true,
          //   ),
          //   child:
          BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) {
        //    loader(context);
          }
          if (state is OrdersLoaded) {
            Loader.hide();
            return
             //  RefreshIndicator(
             //  onRefresh: () async {
             // //   BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
             //  },
             //  child:

              state.ordersData.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.ordersData.length,
                              itemBuilder: (context, index) {
                                lat = double.parse(state.ordersData[index].latlong.toString().split(',')[0]);
                                lng = double.parse(state.ordersData[index].latlong.toString().split(',')[1]);
                                double distanceInMiles = AppUtils.calculateDistanceInMiles(latitude, longitude, lat, lng);

                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    var lat = '0.0';
                                    var lng = '0.0';
                                    if (state.ordersData[index].latlong.toString().contains(',')) {
                                      lat = state.ordersData[index].latlong.toString().split(',')[0] == '' ? '0.00' : state.ordersData[index].latlong.toString().split(',')[0];
                                      lng = state.ordersData[index].latlong.toString().split(',')[1] == '' ? '0.00' : state.ordersData[index].latlong.toString().split(',')[1];
                                    }
                                    widget.navigateToNext(OrderDetailScreen(
                                      type: widget.type,
                                      navigateToNext: widget.navigateToNext,
                                      ordersData: state.ordersData[index],
                                      orderDetail: state.ordersData[index].orderDetail,
                                      miles: distanceInMiles.toStringAsFixed(2),
                                      lat: double.parse(lat),
                                      lng: double.parse(lng),
                                      location:
                                          '${state.ordersData[index].billing_street_aadress.toString().toUpperCase()}, ${state.ordersData[index].billing_city.toString().toUpperCase()}, ${state.ordersData[index].billing_postcode}',
                                    ));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Order #${state.ordersData[index].orderId}',
                                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          state.ordersData[index].delivery_status == 'Delivery Stop'
                                                              ? Icons.not_interested_outlined
                                                              : state.ordersData[index].delivery_status == 'Assigned'
                                                                  ? Icons.verified_outlined
                                                                  : Icons.delivery_dining_outlined,
                                                          color: state.ordersData[index].delivery_status == 'Delivery Stop'
                                                              ? Colors.deepOrange
                                                              : state.ordersData[index].delivery_status == 'Assigned'
                                                                  ? Colors.blue
                                                                  : Colors.green,
                                                          size: 16,
                                                        ),
                                                        Text(
                                                          ' ${state.ordersData[index].delivery_status}',
                                                          style: TextStyle(
                                                              color: state.ordersData[index].delivery_status == 'Delivery Stop'
                                                                  ? Colors.deepOrange
                                                                  : state.ordersData[index].delivery_status == 'Assigned'
                                                                      ? Colors.blue
                                                                      : Colors.green,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 14),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Icon(Icons.remove_red_eye_outlined),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  AppUtils.capitalizeFirstLetter('${state.ordersData[index].billing_first_name} ${state.ordersData[index].billing_last_name}'),
                                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                                ),
                                              ),
                                              Text('${distanceInMiles.toStringAsFixed(2)} mi')
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            '${state.ordersData[index].billing_street_aadress.toString().toUpperCase()}, ${state.ordersData[index].billing_city.toString().toUpperCase()}, ${state.ordersData[index].billing_postcode}',
                                            maxLines: 2,
                                            style: const TextStyle(color: Colors.black, fontSize: 14),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    state.ordersData[index].delivery_dt != null ? AppUtils.formattedDate(state.ordersData[index].delivery_dt.toString()) : 'N/A',
                                                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    state.ordersData[index].delivery_time ?? '',
                                                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                                //   CustomCard(
                                //   navigateToNext: widget.navigateToNext,
                                //   type: 'order',
                                //   online: widget.online,
                                //   ordersData: state.ordersData[index],
                                //   lat: widget.lat,
                                //   lng: widget.lng,
                                //   customerAddress: state.ordersData[index].customerId != null ? state.ordersData[index].customerId!.customer_address![index] : '',
                                // );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const Divider(
                                  color: Colors.black12,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No Orders'),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Container(
                                width: 20,
                                height: 60,
                                child: const Center(
                                  child: Icon(
                                    Icons.refresh,
                                    color: AppStyles.MAIN_COLOR,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
           // );
          }

          return const Center(
            child: CircularProgressIndicator(
              color: AppStyles.MAIN_COLOR,
            ),
          );
        },
      ),
    )
        //)
        ;
  }
}
