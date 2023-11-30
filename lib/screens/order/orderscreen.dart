// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:async';
import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/dashboard/dashboardscreen.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/customcards.dart';

class OrderScreen extends StatefulWidget {
  final lat;
  final lng;
  final type;

  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

  OrderScreen(
    this.navigateToNext,
    this.openDrawer,

    this.lat,
    this.lng, {
    super.key,
    this.type,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool online = false;

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
    BlocProvider.of<OrdersBloc>(context).add(GetOrders(AppData.user!.id));
    super.initState();
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
                "Orders",
                style: TextStyle(fontSize: 20.0, fontFamily: "MontserratBold", fontWeight: FontWeight.bold, color: AppStyles.SECOND_COLOR),
              ))
          : const PreferredSize(preferredSize: Size.zero, child: SizedBox()),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoaded) {

            return state.ordersData.isNotEmpty
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
                              double distanceInMiles = AppUtils.calculateDistanceInMiles(
                                widget.lat,
                                widget.lng,
                                state.ordersData[index].customerId!= null? double.parse(state.ordersData[index].customerId!.customer_address![index].lattitude.toString()):23.03085995,
                                state.ordersData[index].customerId!= null?double.parse(state.ordersData[index].customerId!.customer_address![index].longitude.toString()):72.53501535,
                              );
                              return  InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: (){
                                  widget.navigateToNext(OrderDetailScreen(
                                    type: widget.type, navigateToNext: widget.navigateToNext, ordersData: state.ordersData[index],
                                    orderDetail: state.ordersData[index].orderDetail,miles: distanceInMiles.toStringAsFixed(2),
                                 lat: state.ordersData[index].customerId!= null? double.parse(state.ordersData[index].customerId!.customer_address![index].lattitude.toString()):23.03085995,
                                  lng: state.ordersData[index].customerId!= null?double.parse(state.ordersData[index].customerId!.customer_address![index].longitude.toString()):72.53501535,
                                    location:'${state.ordersData[index].billing_street_aadress.toString().toUpperCase()}, ${state.ordersData[index].billing_city.toString().toUpperCase()}, ${state.ordersData[index].billing_postcode}',
                                  ));
                                },
                                child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text( '#Order${state.ordersData[index].orderId}',
                                                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                              ),

                                            Row(
                                              children: [
                                                Image.asset("assets/images/invoice.png",
                                                  height: 20,
                                                ),
                                                const SizedBox(width: 16,),
                                                Container(
                                                  color: Colors.grey.shade100,
                                                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                                                  child: const Center(
                                                    child: Text( 'ETA: - ',
                                                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                                  ),
                                                )
                                              ],
                                            )
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            children:  [
                                              const Icon(Icons.verified_outlined,color: Colors.black26,size: 18,),
                                              Text( state.ordersData[index].delivery_status.toString(),
                                                style: const TextStyle(color: Colors.black26,fontWeight: FontWeight.bold,fontSize: 14),),
                                            ],
                                          ),
                                          const SizedBox(height: 8,),
                                          Text( AppUtils.capitalizeFirstLetter('${state.ordersData[index].billing_first_name} ${state.ordersData[index].billing_last_name}'),
                                            style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),

                                            const SizedBox(height: 8,),

                                          SizedBox(
                                            width: 250,
                                            child: Text('${state.ordersData[index].billing_street_aadress.toString().toUpperCase()}\n${state.ordersData[index].billing_city.toString().toUpperCase()}, ${state.ordersData[index].billing_postcode}',
                                              maxLines: 2,
                                              style: const TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,),
                                          ),
                                          const SizedBox(height: 8,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children:  [

                                                  Text(
                                                    state.ordersData[index].delivery_dt!=null?
                                                    AppUtils.formattedDate(state.ordersData[index].delivery_dt.toString()):'N/A',
                                                    style: const TextStyle(color: Colors.black54,fontSize: 16),),
                                                  const SizedBox(width: 5,),
                                                  Text(state.ordersData[index].delivery_time??'N/A',
                                                    style: const TextStyle(color: Colors.black54,fontSize: 16),),
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
                            }, separatorBuilder: (BuildContext context, int index) {
                              return const Divider(
                                color: Colors.black12,
                              );
                          },
                          ),
                        ),
                      ],
                    ),
                  )
                : const Center(
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
  Future<void> _makePhoneCall(String phone) async {
    final Uri launchUri = Uri.parse('tel:$phone');
    await launchUrl(launchUri);
  }

  Future<void> _textMsg(String phone) async {
    final Uri launchUri = Uri.parse('sms:$phone');
    await launchUrl(launchUri);
  }
}
