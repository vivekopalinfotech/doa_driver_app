// ignore_for_file: library_private_types_in_public_api, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:doa_driver_app/bloc/history/history_bloc.dart';
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/constants/showsnackbar.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:doa_driver_app/screens/order/widgets/customcards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geolocator/geolocator.dart';

class HistoryScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;
  final type;

  HistoryScreen(
    this.navigateToNext,
    this.openDrawer, {
    super.key,
    this.type,
  });

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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

  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add(GetHistory(AppData.user!.id));
    _callSplashScreen();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callSplashScreen();
  }

  var lat;
  var lng;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoading) {
         //   loader(context);
          }
          if (state is HistoryLoaded) {
            Loader.hide();
            return RefreshIndicator(
                notificationPredicate: (notification) {
                  (notification.metrics.pixels < 0 && notification.metrics.maxScrollExtent > 20);
                  return true;
                },
                onRefresh: () async {
                  BlocProvider.of<HistoryBloc>(context).add(GetHistory(AppData.user!.id));
                },
                child: state.ordersData.isNotEmpty
                    ? ScrollConfiguration(
                        behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
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
                                        widget.navigateToNext(OrderDetailScreen(
                                          type: 'history',
                                          navigateToNext: widget.navigateToNext,
                                          ordersData: state.ordersData[index],
                                          orderDetail: state.ordersData[index].orderDetail,
                                          miles: distanceInMiles.toStringAsFixed(2),
                                          lat: double.parse(state.ordersData[index].latlong.toString().split(',')[0]),
                                          lng: double.parse(state.ordersData[index].latlong.toString().split(',')[1]),
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
                                                    child: Text(
                                                      'Order #${state.ordersData[index].orderId}',
                                                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
                                                    ),
                                                  ),
                                                  const Icon(Icons.remove_red_eye_outlined),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.verified_outlined,
                                                    color: Colors.black26,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    state.ordersData[index].delivery_status.toString(),
                                                    style: const TextStyle(color: Colors.black26, fontWeight: FontWeight.bold, fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                AppUtils.capitalizeFirstLetter('${state.ordersData[index].customerId!.customer_first_name ?? ''} ${state.ordersData[index].customerId!.customer_last_name ?? ''}'),
                                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                  '${state.ordersData[index].billing_street_aadress.toString().toUpperCase()}\n${state.ordersData[index].billing_city.toString().toUpperCase()}, ${state.ordersData[index].billing_postcode}',
                                                  maxLines: 2,
                                                  style: const TextStyle(color: Colors.black, fontSize: 14),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                state.ordersData[index].order_date != null ? AppConstants.convertTime(state.ordersData[index].order_date.toString()) : 'N/A',
                                                style: const TextStyle(color: Colors.black54, fontSize: 16),
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
                        ))
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
                                BlocProvider.of<HistoryBloc>(context).add(GetHistory(AppData.user!.id));
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
                      ));
            //     );
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
