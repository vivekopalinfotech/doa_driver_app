// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, avoid_print

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/bloc/order_status/check_order_status_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/constants/showsnackbar.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/screens/order/widgets/detailcard.dart';
import 'package:doa_driver_app/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps_marker;
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_widget/zoom_widget.dart';
import '../../bloc/shifts_data/shifts_data_bloc.dart';
import '../../bloc/shifts_data/shifts_data_event.dart';

class OrderDetailScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final type;
  final miles;
  final OrdersData ordersData;
  final List<OrderDetail>? orderDetail;
  final lat;
  final lng;
  final location;

  const OrderDetailScreen({super.key, this.type, this.miles, required this.navigateToNext, required this.ordersData, required this.orderDetail, this.lat, this.lng, this.location});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int itemDiscount = 0;
  double cartDiscount = 0;
  String deliveryCharges = '';
  bool start = false;
  bool isZoom = false;

  void receiveDataFromChild(bool data) {
    setState(() {
      isZoom = data;
    });
  }

  @override
  void initState() {
    print(widget.lat);
    print(widget.lng);
    print(widget.ordersData.coupon_amount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double orderTotal = 0;
    double itemTotal = 0;
    double itemDiscount = 0;
    double item = 0;
    double amount = 0;
    String tax = '';
    deliveryCharges = widget.ordersData.shipping_cost.toString();
    tax = widget.ordersData.total_tax.toString();
    // orderTotal = widget.ordersData.order_price.toString();
    for (int i = 0; i < widget.orderDetail!.length; i++) {
      item = double.parse(widget.orderDetail![i].productDiscount) != 0.00 ? (double.parse(widget.orderDetail![i].productPrice) - double.parse(widget.orderDetail![i].productDiscount)) : 0;
      itemDiscount += (double.parse(widget.orderDetail![i].productQty.toString())) * item;
      cartDiscount = double.parse(widget.orderDetail![i].productDiscount);
      itemTotal += double.parse(widget.orderDetail![i].productPrice) * double.parse(widget.orderDetail![i].productQty.toString());
    }
    subtotal = itemTotal - itemDiscount;
    amount = widget.ordersData.coupon_amount != null ? double.parse(widget.ordersData.coupon_amount.toString()) : 0;
    subtotal = subtotal - amount;
    orderTotal = subtotal + num.parse(deliveryCharges) + num.parse(tax) + double.parse(widget.ordersData.transaction_fee.toString());
    Iterable markers = Iterable.generate(1, (index) {
      return maps_marker.Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        markerId: const MarkerId(''),
        position: LatLng(widget.lat, widget.lng),
      );
    });
    return SafeArea(
        bottom: true,
        top: false,
        child: Stack(children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: AppStyles.MAIN_COLOR,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Order #${widget.ordersData.orderId}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(color: Colors.white),
              ),
              leadingWidth: 80,
              leading: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        )),
                    Text(
                      ' Back',
                      textScaleFactor: 1,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      Platform.isIOS
                          ? showModalBottomSheet(
                              isDismissible: true,
                              useSafeArea: false,
                              isScrollControlled: true,
                              shape: const OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)), borderSide: BorderSide.none),
                              elevation: 10,
                              enableDrag: true,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (builder) {
                                return Container(
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)), color: Colors.white),
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 4.0,
                                        width: 32.0,
                                        margin: const EdgeInsets.symmetric(vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppStyles.MAIN_COLOR,
                                          borderRadius: BorderRadius.circular(28),
                                        ),
                                      ),
                                      const Center(
                                        child: Text(
                                          "Please select an option",
                                          textScaleFactor: 1,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppStyles.MAIN_COLOR),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          _getDirection();
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(28),
                                            color: AppStyles.MAIN_COLOR,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Open in Apple Maps",
                                              textScaleFactor: 1,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          _googleMap();
                                        },
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(28),
                                            color: AppStyles.MAIN_COLOR,
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Open in Google Maps",
                                              textScaleFactor: 1,
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Center(
                                            child: Text(
                                              "Cancel",
                                              textScaleFactor: 1,
                                              style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(.85) : Colors.black54),
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              })
                          : _getDirection();
                    },
                    child: const Icon(Icons.location_on_outlined),
                  ),
                )
              ],
            ),
            body: BlocListener<OrderStatusBloc, OrderStatusState>(
                listener: (context, state) async {
                  if (state is OrderStatusLoading) {
                    loader(context);
                  }
                  if (state is OrderStatusSuccess) {
                    Loader.hide();
                    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
                    setState(() {
                      start = true;
                    });
                  } else if (state is DeliveryCancelSuccess) {
                    Loader.hide();
                    Navigator.of(context).pop(true);
                    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
                    Navigator.of(context).pop();
                    BlocProvider.of<ShiftsDataBloc>(context).add(GetShiftsData(AppData.user!.id));
                  } else if (state is NotHomeSuccess) {
                    Loader.hide();
                    Navigator.of(context).pop(true);
                    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
                    Navigator.of(context).pop();
                    BlocProvider.of<ShiftsDataBloc>(context).add(GetShiftsData(AppData.user!.id));
                  } else if (state is DeliveryStopSuccess) {
                    Loader.hide();
                    Navigator.of(context).pop(true);
                    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
                    Navigator.of(context).pop();
                    BlocProvider.of<ShiftsDataBloc>(context).add(GetShiftsData(AppData.user!.id));
                  }

                  if (state is OrderStatusFailed) {
                    Loader.hide();
                    showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Center(
                            child: Text(
                          'Please complete the other order delivery',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        )),
                      ),
                    );
                  }
                },
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(overscroll: false),
                        child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 180,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(target: LatLng(widget.lat, widget.lng), zoom: 15),
                                    mapType: MapType.normal,
                                    myLocationEnabled: false,
                                    scrollGesturesEnabled: true,
                                    zoomGesturesEnabled: true,
                                    zoomControlsEnabled: false,
                                    minMaxZoomPreference: const MinMaxZoomPreference(0, 20),
                                    markers: Set.from(markers),
                                    tiltGesturesEnabled: true,
                                    mapToolbarEnabled: false,
                                    onCameraMove: (position) {
                                      //_customInfoWindowController.onCameraMove!();
                                    },
                                    onMapCreated: (GoogleMapController controller) {
                                      controller = controller;
                                    },
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Platform.isIOS
                                          ? showModalBottomSheet(
                                              isDismissible: true,
                                              useSafeArea: false,
                                              isScrollControlled: true,
                                              shape:
                                                  const OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)), borderSide: BorderSide.none),
                                              elevation: 10,
                                              enableDrag: true,
                                              backgroundColor: Colors.white,
                                              context: context,
                                              builder: (builder) {
                                                return Container(
                                                  decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)), color: Colors.white),
                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                  height: 250,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 4.0,
                                                        width: 32.0,
                                                        margin: const EdgeInsets.symmetric(vertical: 4),
                                                        decoration: BoxDecoration(
                                                          color: AppStyles.MAIN_COLOR,
                                                          borderRadius: BorderRadius.circular(28),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          "Please select an option",
                                                          textScaleFactor: 1,
                                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppStyles.MAIN_COLOR),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () {
                                                          _getDirection();
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(28),
                                                            color: AppStyles.MAIN_COLOR,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Open in Apple Maps",
                                                              textScaleFactor: 1,
                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () {
                                                          _googleMap();
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(28),
                                                            color: AppStyles.MAIN_COLOR,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              "Open in Google Maps",
                                                              textScaleFactor: 1,
                                                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      InkWell(
                                                          splashColor: Colors.transparent,
                                                          highlightColor: Colors.transparent,
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              "Cancel",
                                                              textScaleFactor: 1,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(.85) : Colors.black54),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                );
                                              })
                                          : _getDirection();
                                    },
                                    child: Container(
                                      height: 60,
                                      color: AppStyles.SECOND_COLOR.withOpacity(.7),
                                      padding: const EdgeInsets.all(8),
                                      child: Center(
                                          child: Text(
                                        widget.location,
                                        maxLines: 2,
                                      )),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            DetailCard(ordersData: widget.ordersData, miles: widget.miles, callback: receiveDataFromChild),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Flexible(
                                        child: SizedBox(
                                            width: 160,
                                            child: Text(
                                              'Items',
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            )),
                                      ),
                                      SizedBox(
                                          child: Center(
                                              child: Text(
                                        'Qty',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ))),
                                      SizedBox(
                                          child: Center(
                                              child: Text(
                                        'Price',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      )))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 100),
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                          physics: const NeverScrollableScrollPhysics(),
                                          primary: false,
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          itemCount: widget.ordersData.orderDetail!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(vertical: 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                          width: 180,
                                                          child: Text(
                                                            widget.orderDetail![index].product?.detail![0].title ?? 'Not Available',
                                                            textAlign: TextAlign.start,
                                                          )),
                                                      SizedBox(child: Center(child: Text(widget.orderDetail![index].productQty))),
                                                      SizedBox(
                                                          child: Center(
                                                              child: widget.orderDetail![index].productDiscount == '0.00'
                                                                  ? Text(
                                                                      '\$${widget.orderDetail![index].productPrice}',
                                                                    )
                                                                  : Column(
                                                                      children: [
                                                                        Text(
                                                                          '\$${widget.orderDetail![index].productPrice}',
                                                                          style: const TextStyle(decoration: TextDecoration.lineThrough),
                                                                        ),
                                                                        Text(
                                                                          '\$${widget.orderDetail![index].productDiscount}',
                                                                        ),
                                                                      ],
                                                                    )))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                      const Divider(
                                        color: Colors.black38,
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Item total',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            '\$${itemTotal.toStringAsFixed(2)}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Item Discounts',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            itemDiscount.toStringAsFixed(2) == '0.00' ? '\$${itemDiscount.toStringAsFixed(2)}' : '-\$${itemDiscount.toStringAsFixed(2)}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Coupon Discounts',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            widget.ordersData.coupon_amount != null && widget.ordersData.coupon_amount != '0.00'?'-\$${widget.ordersData.coupon_amount}' : '\$0.00',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black38,
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Sub Total',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '\$${subtotal.toStringAsFixed(2)}',
                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Tax',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            '\$$tax',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Delivery Charges',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            '\$${widget.ordersData.shipping_cost}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Transaction Fee',
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            '\$${widget.ordersData.transaction_fee}',
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Flexible(
                                            child: SizedBox(
                                                child: Text(
                                              'Total',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                                              textAlign: TextAlign.start,
                                            )),
                                          ),
                                          SizedBox(
                                              child: Center(
                                                  child: Text(
                                            '\$${orderTotal.toStringAsFixed(2)}',
                                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ))),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white,
                          child: widget.type == 'history' || widget.type == 'delivered'
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Product Delivered',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green),
                                      ),
                                      Image.asset(
                                        'assets/images/success.gif',
                                        height: 30,
                                      )
                                    ],
                                  ))
                              : widget.ordersData.delivery_status == 'On Route'
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              highlightColor: Colors.transparent,
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PaymentScreen(
                                                              amount: orderTotal.toStringAsFixed(2),
                                                              orderId: widget.ordersData.orderId.toString(),
                                                            )));
                                              },
                                              child: Container(
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(color: AppStyles.MAIN_COLOR),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    'Check Out',
                                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: AppStyles.MAIN_COLOR),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height: 200,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(24),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
                                                              BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Cancel', 0, 0));
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: const [
                                                                Icon(
                                                                  Icons.cancel_outlined,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  '  Cancel Delivery',
                                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
                                                              BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Stop', 0, 0));
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: const [
                                                                Icon(
                                                                  Icons.block_outlined,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  '  Stop Delivery',
                                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
                                                              BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Not At Home', 0, 0));
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: const [
                                                                Icon(
                                                                  Icons.backspace_outlined,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  '  Not Home',
                                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.grey.shade200,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.more_vert_outlined,
                                                  size: 34,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          start == true
                                              ? Flexible(
                                                  child: InkWell(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => PaymentScreen(
                                                                    amount: orderTotal.toStringAsFixed(2),
                                                                    orderId: widget.ordersData.orderId.toString(),
                                                                  )));
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(color: AppStyles.MAIN_COLOR),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          'Check Out',
                                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: AppStyles.MAIN_COLOR),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Flexible(
                                                  child: InkWell(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onTap: () {
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
                                                                    "Are You Sure You Want to Start Delivery?",
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
                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'On Route', 0, 0));
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      decoration: const BoxDecoration(color: AppStyles.MAIN_COLOR, boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)]),
                                                      child: const Center(
                                                        child: Text(
                                                          'Start Delivery',
                                                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    height: 200,
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(24),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
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
                                                                            "Are You Sure You Want to Cancel Delivery?",
                                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.MAIN_COLOR),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        child: const Text(
                                                                          "No",
                                                                          style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold),
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.of(context, rootNavigator: true).pop();
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: const Text("Cancel", style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold)),
                                                                        onPressed: () async {
                                                                          Navigator.of(context, rootNavigator: true).pop();
                                                                          BlocProvider.of<OrderStatusBloc>(context)
                                                                              .add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Cancel', 0, 0));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: const [
                                                                Icon(
                                                                  Icons.cancel_outlined,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  '  Cancel Delivery',
                                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
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
                                                                            "Are You Sure You Want to Stop Delivery?",
                                                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.MAIN_COLOR),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: [
                                                                      TextButton(
                                                                        child: const Text(
                                                                          "No",
                                                                          style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold),
                                                                        ),
                                                                        onPressed: () {
                                                                          Navigator.of(context, rootNavigator: true).pop();
                                                                        },
                                                                      ),
                                                                      TextButton(
                                                                        child: const Text("Stop", style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold)),
                                                                        onPressed: () async {
                                                                          Navigator.of(context, rootNavigator: true).pop();
                                                                          BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Stop', 0, 0));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: const [
                                                                Icon(
                                                                  Icons.block_outlined,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  '  Stop Delivery',
                                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          InkWell(
                                                            splashColor: Colors.transparent,
                                                            highlightColor: Colors.transparent,
                                                            onTap: () {
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
                                                                            "Are You Sure You Want to Change the status to Not Home?",
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
                                                                        child: const Text("Not Home", style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold)),
                                                                        onPressed: () async {
                                                                          Navigator.of(context, rootNavigator: true).pop();
                                                                          BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Not At Home', 0, 0));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: const [
                                                                Icon(
                                                                  Icons.backspace_outlined,
                                                                  color: Colors.red,
                                                                ),
                                                                Text(
                                                                  '  Not Home',
                                                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.grey.shade200,
                                              child: const Center(
                                                child: Icon(
                                                  Icons.more_vert_outlined,
                                                  size: 34,
                                                  color: Colors.black45,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                        ))
                  ],
                )),
          ),
          isZoom
              ? Scaffold(
                  body: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(children: [
                        Zoom(
                            centerOnScale: true,
                            maxZoomWidth: MediaQuery.of(context).size.width,
                            maxZoomHeight: MediaQuery.of(context).size.height,
                            maxScale: 3,
                            backgroundColor: Colors.white,
                            child: Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              // padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(border: Border.all(color: Colors.black12), color: Colors.white),
                              child: CachedNetworkImage(
                                imageUrl: 'https://admin.dankofamerica.karnavati.in/proof/${widget.ordersData.customerId!.customer_proof ?? ''}',
                                fit: BoxFit.contain,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Center(child: CircularProgressIndicator(color: Colors.white, backgroundColor: AppStyles.MAIN_COLOR, value: downloadProgress.progress)),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            )),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(top: 50, left: 16),
                                child: InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      setState(() {
                                        isZoom = false;
                                      });
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: AppStyles.MAIN_COLOR,
                                      radius: 12,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ))))
                      ])))
              : SizedBox()
        ]));
  }

  _getDirection() async {
    if (Platform.isAndroid) {
      var uri = Uri.parse("google.navigation:q=${widget.lat},${widget.lng}&mode=d");
      if (await canLaunchUrl(uri)) {
        await launch(uri.toString());
      } else {
        throw 'Could not launch Maps';
      }
    } else if (Platform.isIOS) {
      var url = Uri.parse('https://maps.apple.com/?q=${widget.lat},${widget.lng}');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch Maps';
      }
    }
  }

  _googleMap() async {
    var url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.lng}");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch Maps';
    }
  }
}
