// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, library_private_types_in_public_api, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print

import 'dart:async';
import 'dart:io';
import 'package:doa_driver_app/bloc/delivery_update/delivery_update_bloc.dart';
import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/bloc/order_status/check_order_status_bloc.dart';
import 'package:doa_driver_app/constants/app_constants.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DashboardScreen extends StatefulWidget {
  final type;
  var online;
  final latitude;
  final longitude;

  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  DashboardScreen(this.navigateToNext, this.openDrawer, this.online, {super.key, this.type, this.latitude, this.longitude});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ScrollController _controller = ScrollController();
  TextEditingController cancelController = TextEditingController();
  TextEditingController reScheduleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  late bool serviceEnabled;
  final PanelController _pc = PanelController();
  String latlng = "-1";
  final Completer<GoogleMapController> controller = Completer();
  LatLng? sourceLocation;
  bool start = false;

  toggleStart(){
    start = !start;
  }
  static const LatLng destination = LatLng(23.03085995, 72.53501535);
  List<LatLng> polylineCoordinates = [];
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      "assets/images/pin_source.png",
    ).then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/pin_source.png").then(
      (icon) {
        destinationIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/bike.png").then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }




  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      AppConstants.kGoogleApiKey, // Your Google Map Key
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
        sourceLocation = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
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
    //getPolyPoints();
    getCurrentLocation();
    //getPolyPoints();
    setCustomMarkerIcon();
    BlocProvider.of<DeliveryUpdateBloc>(context).add( GetDeliveryUpdate(AppData.user!.id));
    BlocProvider.of<OrdersBloc>(context).add( GetOrders(AppData.user!.id));
    super.initState();
    print('**********${widget.latitude}');
    print(widget.longitude);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: widget.type == 'order'
          ? AppBar(
              elevation: 0,
              backgroundColor: AppStyles.MAIN_COLOR,
              iconTheme: const IconThemeData(color: AppStyles.SECOND_COLOR),
              title: const Text(
                "Delivery Map",
                // AppLocalizations.of(context)!.translate('app_name')!,
                style: TextStyle(fontSize: 20.0, fontFamily: "MontserratBold", fontWeight: FontWeight.bold, color: AppStyles.SECOND_COLOR),
              ))
          : const PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        controller: _pc,
        minHeight: widget.type == 'order' ? 150 : 100,
        maxHeight: 290,
        onPanelOpened: () {},
        panelBuilder: (ScrollController sc) {
          _controller = sc;
          return _scrollingList();
        },
        body: MapDisplay(context),
      ),
    );
  }

  Widget _scrollingList() {

    bool isWithinDistanceThreshold(
        double currentLat, double currentLon, double destinationLat, double destinationLon, double thresholdMeters) {
      double distance = AppUtils.calculateDistance(
        currentLat,
        currentLon,
        destinationLat,
        destinationLon,
      );

      return distance <= thresholdMeters;
    }

    double thresholdMeters = 10.0;

    bool withinThreshold = isWithinDistanceThreshold(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
      destination.latitude,
      destination.longitude,
      thresholdMeters,
    );

    double distanceInMiles = AppUtils.calculateDistanceInMiles(
      currentLocation!.latitude!,
      currentLocation!.longitude!,
      destination.latitude,
      destination.longitude,
    );



    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onVerticalDragStart: (details) {
            if (_pc.isPanelOpen) {
              _pc.close();
            } else {
              _pc.open();
            }
          },
          child: Container(
            height: 8.0,
            width: 60.0,
            margin: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        Expanded(
            child: SingleChildScrollView(
                controller: _controller,
                child: widget.online == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 10,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          'https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${AppData.user!.firstName} ${AppData.user!.lastName}',
                                            style: const TextStyle(color:
                                            AppStyles.MAIN_COLOR,
                                                fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Basic Level',
                                                style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 12),
                                              ),
                                              const Text(
                                                ' | ',
                                                style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold, fontSize: 14),
                                              ),
                                              Image.asset(
                                                'assets/images/licence.png',
                                                height: 10,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                'ACX ${AppData.user!.vehicle_registration_no}',
                                                style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                            BlocBuilder<DeliveryUpdateBloc, DeliveryUpdateState>(
                            builder: (context, state) {
                            if (state is DeliveryUpdateLoaded) {

                            return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              height: 150,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppStyles.MAIN_COLOR),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/completed.png',
                                        height: 45,
                                        color: AppStyles.SECOND_COLOR,
                                      ),
                                      Text(
                                        state.deliveryUpdateResponse
                                            .complete_order.toString(),
                                        style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                                      ),
                                      const Text(
                                        'Complete Delivery',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset(
                                        'assets/images/pending.png',
                                        height: 45,
                                        color: AppStyles.SECOND_COLOR,
                                      ),
                                       Text(
                                        state.deliveryUpdateResponse
                                            .Pending_order.toString(),
                                        style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                                      ),
                                      const Text(
                                        'Pending Delivery',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:  [
                                      Image.asset(
                                        'assets/images/today.png',
                                        height: 45,
                                        color: AppStyles.SECOND_COLOR,
                                      ),
                                      Text(
                                        state.deliveryUpdateResponse
                                            .today_order.toString(),
                                        style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                                      ),
                                      const Text(
                                        "Today's Delivery",
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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

                        ],
                      )
                    : BlocBuilder<OrdersBloc, OrdersState>(
                      builder: (context, state) {
                      if (state is OrdersLoaded) {

                      return state.ordersData.isNotEmpty?Container(
                        height: 260,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 10,
                                    child: SizedBox(
                                      height: 60,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 20,
                                            backgroundImage: AssetImage(
                                              'assets/images/profile.jpg',
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                               Text(
                                                '${state.ordersData[0]
                                                    .delivery_first_name} ${state.ordersData[0].delivery_last_name}',
                                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              Text(
                                                '${state.ordersData[0]
                                                    .warehouse!
                                                    .warehouse_name}',
                                                style: const TextStyle(color: AppStyles.MAIN_COLOR,
                                                    fontWeight: FontWeight.bold, fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: SizedBox(
                                      width: 110,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                           Text(
                                            '\$${state.ordersData[0]
                                                .order_price}',
                                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                           Text(
                                            '${distanceInMiles.toStringAsFixed(2)} mi',
                                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                                          ),
                                         start == false? InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () {
                                                 widget.navigateToNext(OrderDetailScreen(navigateToNext: widget.navigateToNext,
                                                   ordersData: state.ordersData[0], orderDetail: state.ordersData[0].orderDetail,));
                                              },
                                              child: const Text('Order Details >',style: TextStyle(color: AppStyles.SECOND_COLOR,fontWeight: FontWeight.bold,fontSize: 14),
                                              )):const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Pick Up',
                                style: TextStyle(color: AppStyles
                                    .SECOND_COLOR,
                                    fontSize: 12),
                              ),
                               SizedBox(
                                width: 250,
                                child: Text(
                                  '${state.ordersData[0].warehouse!
                                      .warehouse_address}',
                                  style: const TextStyle(color: Colors.black, fontSize: 14),
                                ),
                              ),
                              const Text(
                                'Drop Off',
                                style: TextStyle(color: AppStyles
                                    .SECOND_COLOR, fontSize: 12),
                              ),
                               SizedBox(
                                width: 250,
                                child: Text(
                                  '${state.ordersData[0]
                                      .billing_street_aadress}, ${state
                                      .ordersData[0].billing_city},${state
                                      .ordersData[0].billing_postcode}',
                                  style: const TextStyle(color: Colors.black, fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                           start == false? InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  // showAlertDialog1(context);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        title: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/logo.png',
                                              height: 50,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(left: 10),
                                              width: 200,
                                              child: const Text(
                                                "Are You Ready For Start This Delivery?",
                                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.MAIN_COLOR),
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "Cancel",
                                              style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context, rootNavigator: true).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Start", style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold)),
                                            onPressed: () async {
                                              BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(state.ordersData[0].orderId.toString(), 'Shipped'));
                                              toggleStart();
                                              _pc.close();
                                              getPolyPoints();
                                              Navigator.of(context, rootNavigator: true).pop();

                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );

                                },
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: AppStyles.MAIN_COLOR,
                                      boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)]),
                                  child: const Center(
                                    child: Text(
                                      'Start Delivery',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ):
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        showAlertDialog1(context,state.ordersData[0]);
                                        _pc.close();
                                      },
                                      child: Container(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width*.4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: AppStyles.SECOND_COLOR,
                                            boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)]),
                                        child: const Center(
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        if (withinThreshold) {
                                          BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(state.ordersData[0].orderId.toString(), 'Complete'));
                                          widget.navigateToNext(OrderDetailScreen(navigateToNext: widget.navigateToNext,
                                            ordersData: state.ordersData[0], orderDetail: state.ordersData[0].orderDetail,type: 'delivered',));
                                        } else {

                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              backgroundColor: AppStyles.MAIN_COLOR,
                                              content: Center(child: Text('Sorry! you are not reached to the location',
                                                style: TextStyle(color: Colors.white),),)));
                                          print('Destination is beyond $thresholdMeters meters from the current location.');
                                        }
                                      },
                                      child: Container(
                                        height: 45,
                                        width: MediaQuery.of(context).size.width*.4,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: AppStyles.MAIN_COLOR,
                                            boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)]),
                                        child: const Center(
                                          child: Text(
                                            'Delivered',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ):Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 10,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          'https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${AppData.user!.firstName} ${AppData.user!.lastName}',
                                            style: const TextStyle(color:
                                            AppStyles.MAIN_COLOR,
                                                fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Basic Level',
                                                style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 12),
                                              ),
                                              const Text(
                                                ' | ',
                                                style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold, fontSize: 14),
                                              ),
                                              Image.asset(
                                                'assets/images/licence.png',
                                                height: 10,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                'ACX ${AppData.user!.vehicle_registration_no}',
                                                style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold, fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<DeliveryUpdateBloc, DeliveryUpdateState>(
                            builder: (context, state) {
                              if (state is DeliveryUpdateLoaded) {

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    height: 150,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppStyles.MAIN_COLOR),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [

                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/completed.png',
                                              height: 45,
                                              color: AppStyles.SECOND_COLOR,
                                            ),
                                            Text(
                                              state.deliveryUpdateResponse
                                                  .complete_order.toString(),
                                              style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                                            ),
                                            const Text(
                                              'Complete Delivery',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/pending.png',
                                              height: 45,
                                              color: AppStyles.SECOND_COLOR,
                                            ),
                                            Text(
                                              state.deliveryUpdateResponse
                                                  .Pending_order.toString(),
                                              style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                                            ),
                                            const Text(
                                              'Pending Delivery',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children:  [
                                            Image.asset(
                                              'assets/images/today.png',
                                              height: 45,
                                              color: AppStyles.SECOND_COLOR,
                                            ),
                                            Text(
                                              state.deliveryUpdateResponse
                                                  .today_order.toString(),
                                              style: const TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.w500),
                                            ),
                                            const Text(
                                              "Today's Delivery",
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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

                        ],
                      );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppStyles.MAIN_COLOR,
                  ),
                );
                },
                ),
    )),
      ],
    );
  }

  Widget MapDisplay(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: Platform.isIOS ? MediaQuery.of(context).size.height - 285 : MediaQuery.of(context).size.height - 235,
          child: Stack(
            children: [
              widget.latitude == ''
                  ? GoogleMap(
                      compassEnabled: false,
                      mapType: MapType.hybrid,
                      myLocationEnabled: false,
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.latitude,
                            widget.longitude),
                        zoom: 14,
                      ),
                      myLocationButtonEnabled: true,
                      tiltGesturesEnabled: false,
                      onCameraIdle: () {},
                      onCameraMove: (position) {},
                    )
                  : //Text(currentLocation!.longitude!.toString()),
                  GoogleMap(
                      compassEnabled: false,
                      mapType: MapType.normal,
                      myLocationEnabled: false,
                      rotateGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.latitude, widget.longitude),
                        zoom: 14,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("currentLocation"),
                          icon: currentLocationIcon,
                       //   rotation: currentLocation!.heading!,
                          position: LatLng(widget.latitude, widget.longitude),
                        ),
                        Marker(
                          markerId: const MarkerId("source"),
                          icon: sourceIcon,
                          position: sourceLocation!,
                        ),
                        Marker(
                          markerId: const MarkerId("destination"),
                          icon: destinationIcon,
                          position: destination,
                        ),
                      },
                      onMapCreated: (mapController) {
                        controller.complete(mapController);
                      },
                      polylines: {
                        Polyline(
                          polylineId: const PolylineId("route"),
                          points: polylineCoordinates,
                          color: AppStyles.MAIN_COLOR,
                          width: 6,
                        ),
                      },
                      myLocationButtonEnabled: true,
                      tiltGesturesEnabled: false,
                      onCameraIdle: () {},
                      //onCameraMove: (position) {},
                    ),
              Positioned(
                child: widget.online == false && widget.type != 'order'
                    ? Container(
                        height: 75,
                        color: AppStyles.MAIN_COLOR,
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: DottedBorder(
                                  padding: const EdgeInsets.all(3),
                                  borderType: BorderType.Circle,
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppStyles.SECOND_COLOR,
                                      child: Image.asset(
                                        'assets/images/offline.png',
                                        height: 25,
                                      ))),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                flex: 6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'You are offline.!',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Go online to start accepting orders',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      )
                    : currentLocation?.latitude!=null?Text('${currentLocation!.latitude!}===${currentLocation!.longitude!}'):const SizedBox(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future _selectDate() async {
    final now = DateTime.now();
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(now.year, now.month, now.day + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.brown,
              primaryColorDark: Colors.brown,
              accentColor: Colors.brown,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    );
    if(picked != null ){
      String formattedDate = DateFormat('yyyy/MM/dd').format(picked);
      setState(() => dateController.text = formattedDate);

    }
  }
  Future<void> _selectTime() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Set the initial time (optional)
    );

    if (selectedTime != null) {
      // Handle the selected time (e.g., update UI);
      setState(() => timeController.text = selectedTime.toString().replaceAll('TimeOfDay(', '').replaceAll(')', ""));
    }
  }

  bool schedule = false;
  toggleSchedule(){
   setState(() {
     schedule = !schedule;
   });
  }

  bool cancel = false;
  toggleCancel(){
    setState(() {
      cancel = !cancel;
    });
  }
  void showAlertDialog1(BuildContext context,OrdersData? ordersData) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateInsideDialog) {
          return  AlertDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.all(16),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                InkWell(
                  onTap: (){
                    setStateInsideDialog(() {
                      toggleSchedule();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppStyles.SECOND_COLOR
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Reschedule',style: TextStyle(
                            color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.w500
                        ),),
                        Icon(schedule == true?Icons.arrow_drop_up:Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                schedule==true? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      cursorColor: AppStyles.MAIN_COLOR,
                      controller: reScheduleController,
                      style: const TextStyle(
                          color: AppStyles.MAIN_COLOR,
                          fontSize: 14),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          fillColor:  AppStyles.COLOR_LITE_GREY_LIGHT,
                          filled: true,
                          contentPadding: const EdgeInsets.only(left: 10,right: 10),
                          hintText: "Why you Reschedule this delivery?",
                          hintStyle: const TextStyle(
                              color: AppStyles.SECOND_COLOR,
                              fontSize: 14)),
                    ),
                    const SizedBox(height: 16,),
                    const Text('Rescheduled Delivery:',style: TextStyle(fontSize: 18),),
                    const SizedBox(height: 12,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Delivery Date:   ', style: TextStyle(color: Colors.black,fontSize: 16),),
                        InkWell(
                            onTap: (){
                              setStateInsideDialog(() {
                                _selectDate();
                              });
                            },
                            child: Row(
                              children: [
                                dateController.text.isNotEmpty?
                                Text(
                                  AppUtils.splitDate(dateController.text),
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppStyles.SECOND_COLOR),):
                                const Text('',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppStyles.MAIN_COLOR,fontSize: 16),),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon(
                                      Icons.calendar_month,size: 16,color:dateController.text.isNotEmpty? AppStyles.MAIN_COLOR:Colors.black),
                                )
                              ],
                            ))
                      ],
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Delivery Time:   ', style: TextStyle(color: Colors.black,fontSize: 16),),
                        InkWell(

                            onTap: (){
                              setStateInsideDialog(() {
                                _selectTime();
                              });
                            },
                            child: Row(
                              children: [
                                timeController.text.isNotEmpty?
                                Text(
                                  AppUtils.splitTime(timeController.text),
                                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: AppStyles.SECOND_COLOR),):
                                const Text('',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppStyles.MAIN_COLOR,fontSize: 16),),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Icon(
                                      Icons.access_time_outlined,size: 16,color:timeController.text.isNotEmpty? AppStyles.MAIN_COLOR:Colors.black),
                                )
                              ],
                            ))
                      ],
                    ),
                  ],
                ):const SizedBox(),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    setStateInsideDialog(() {
                      toggleCancel();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppStyles.SECOND_COLOR
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Cancel',style: TextStyle(
                            color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.w500
                        ),),
                        Icon(cancel == true?Icons.arrow_drop_up:Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                cancel==true? TextFormField(
                  minLines: 1,
                  maxLines: 5,
                  controller: cancelController,
                  cursorColor: AppStyles.MAIN_COLOR,
                  style: const TextStyle(
                      color: AppStyles.MAIN_COLOR,
                      fontSize: 14),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor:  AppStyles.COLOR_LITE_GREY_LIGHT,
                      filled: true,
                      contentPadding: const EdgeInsets.only(left: 10,right: 10),
                      hintText: "Why you cancel this delivery?",
                      hintStyle: const TextStyle(
                          color: AppStyles.SECOND_COLOR,
                          fontSize: 14)),
                ):const SizedBox(),
              ],
            ),

            actions: [
              // cancelButton,
              schedule== true? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(AppStyles.MAIN_COLOR),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      ),
                    ),
                  ),
                  child: const Text(
                    "Reschedule",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  onPressed: () {
                    BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(ordersData!.orderId.toString(), 'Inprocess'));
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ) :Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(AppStyles.MAIN_COLOR),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                      ),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 16),
                  ),
                  onPressed: () {
                    cancelController.text.isNotEmpty?
                    BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(ordersData!.orderId.toString(), 'Cancel')):
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: AppStyles.MAIN_COLOR,
                            content: Center(child: Text('Please give reason why you cancel this order?',
                        style: TextStyle(color: Colors.white),),)));
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              )
            ],
          );
        });
      },
    );
  }
}
