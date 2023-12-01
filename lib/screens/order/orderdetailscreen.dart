// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, deprecated_member_use, avoid_print

import 'dart:io';

import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/bloc/order_status/check_order_status_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/screens/order/widgets/detailcard.dart';
import 'package:doa_driver_app/screens/payment/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps_marker;
import 'package:url_launcher/url_launcher.dart';

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

  @override
  void initState() {
    print(widget.lat);
    print(widget.lng);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double orderTotal = 0;
    double itemTotal = 0;
    double itemDiscount = 0;
    String tax = '';
    deliveryCharges = widget.ordersData.shipping_cost.toString();
    tax = widget.ordersData.total_tax.toString();
    // orderTotal = widget.ordersData.order_price.toString();
    for (int i = 0; i < widget.orderDetail!.length; i++) {
      itemDiscount += (double.parse(widget.orderDetail![i].productQty.toString())) * (double.parse(widget.orderDetail![i].productPrice) - 0);
      cartDiscount = double.parse(widget.orderDetail![i].productDiscount);
      itemTotal += double.parse(widget.orderDetail![i].productPrice) * double.parse(widget.orderDetail![i].productQty.toString());
    }
    subtotal = itemTotal - itemDiscount;
    orderTotal = subtotal + num.parse(deliveryCharges) + num.parse(tax);
    Iterable markers = Iterable.generate(1, (index) {
      return maps_marker.Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        markerId: const MarkerId(''),
        position: LatLng(widget.lat, widget.lng),
      );
    });
    return Scaffold(
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
                _getDirection();
              },
              child: const Icon(Icons.location_on_outlined),
            ),
          )
        ],
      ),
      body: BlocListener<OrderStatusBloc, OrderStatusState>(
        listener: (context, state) async {
          if (state is OrderStatusSuccess) {
            BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
            setState(() {
              start = true;
            });
          }
          if (state is OrderStatusFailed) {
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
        child: Column(
            children: [
              SizedBox(
                height: widget.type == 'history' ?MediaQuery.of(context).size.height * .75:MediaQuery.of(context).size.height * .8,
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
                                _getDirection();
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
                      DetailCard(
                        ordersData: widget.ordersData,
                        miles: widget.miles,
                      ),
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
                                                        child: Column(
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
                                      '-\$${itemDiscount.toStringAsFixed(2)}',
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
                ),
              ),
              widget.type == 'history' || widget.type == 'delivered'
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
                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Cancel',0,0));
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
                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Stop',0,0));
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
                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Not At Home',0,0));
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
                                          BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'On Route',0,0));
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
                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Cancel',0,0));
                                                  Navigator.of(context).pop(true);
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
                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Delivery Stop',0,0));
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
                                                  BlocProvider.of<OrderStatusBloc>(context).add(CheckOrderStatus(widget.ordersData.orderId.toString(), 'Not At Home',0,0));
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
            ],
        )
      ),
    );
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
}
