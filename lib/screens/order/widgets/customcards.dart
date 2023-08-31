import 'dart:math';

import 'package:doa_driver_app/bloc/order/order_bloc.dart';
import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/screens/dashboard/dashboardscreen.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCard extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final OrdersData ordersData;
  final type;
  final miles;
  var online;
  final lat;
  final lng;
  final customerAddress;

   CustomCard({super.key, this.type,this.online, required this.navigateToNext, required this.ordersData, this.miles, this.lat, this.lng, this.customerAddress, });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {


  @override
  void initState() {
    // double distance = calculateDistanceInMiles(lat1, lon1, lat2, lon2);
    // print('Distance between customer and delivery boy: ${distance.toStringAsFixed(2)} miles');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double distanceInMiles = AppUtils.calculateDistanceInMiles(
        widget.lat,
        widget.lng,
        widget.ordersData.customerId!= null? double.parse(widget.customerAddress.lattitude.toString()):23.03085995,
      widget.ordersData.customerId!= null?double.parse(widget.customerAddress.longitude.toString()):72.53501535,
    );



    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
      height: widget.type == 'order'? 300:260,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/profile.jpg',),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text( '${widget.ordersData.billing_first_name} ${widget.ordersData.billing_last_name}',
                           style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                    //      const SizedBox(height: 5,),
                          Text( widget.ordersData.warehouse!.warehouse_name??'',style: const TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.w500,fontSize: 14),),
                      //    const SizedBox(height: 5,),
                      //     StarRating(
                      //       starCount: 5,
                      //       rating: 5,
                      //       onRatingChanged: (rating) {}, color: Colors.amber,),
                      ],),

                    ],

                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment:CrossAxisAlignment.end,
                    children:  [
                       Text('\$${widget.ordersData.order_price}',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                  //      const SizedBox(height: 5,),
                       Text('${distanceInMiles.toStringAsFixed(2)} mi',style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                   //     const SizedBox(height: 5,),
                      InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: (){
                            widget.navigateToNext(OrderDetailScreen(
                              type: widget.type, navigateToNext: widget.navigateToNext,online: widget.online, ordersData: widget.ordersData,
                              orderDetail: widget.ordersData.orderDetail,miles: distanceInMiles.toStringAsFixed(2),
                            ));
                          },
                          child: const Text('Order Details >',style: TextStyle(color: AppStyles.SECOND_COLOR,fontWeight: FontWeight.bold,fontSize: 14),)),
                    ],),
                ),
              ],
            ),
        //    const SizedBox(height: 5,),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text('Pick Up',
                     style: TextStyle(color: AppStyles.SECOND_COLOR,fontSize: 12),),
                    const SizedBox(height: 5,),

                   SizedBox(
                     width: 250,
                     child: Text(widget.ordersData.warehouse!.warehouse_address??'',
                       maxLines: 2,
                       style: const TextStyle(color: Colors.black,fontSize: 14),),
                   ),
                 ],
               ),
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(20),
                   color: AppStyles.SECOND_COLOR,
                 ),
                 padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                 child:  Center(
                     child: widget.type == 'order'?const Text('In Transit',
                       style: TextStyle(color: Colors.black),):const Text('Delivered',
                       style: TextStyle(color: Colors.black),)
                 ),
               )
             ],
           ),
      //      const SizedBox(height: 10,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Drop Off',
                  style: TextStyle(color: AppStyles.SECOND_COLOR,fontSize: 12),),
                 const SizedBox(height: 5,),

                SizedBox(
                  width: 250,
                  child: Text('${widget.ordersData.billing_street_aadress}, ${widget.ordersData.billing_city}, ${widget.ordersData.billing_postcode}',
                    maxLines: 2,
                    style: const TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,),
                ),
              ],
            ),
       //     const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:  [
                    const Icon(Icons.calendar_month_outlined,color: AppStyles.SECOND_COLOR,size: 18,),
                    const SizedBox(width: 5,),
                    Text(
                        widget.ordersData.delivery_dt!=null?
                      AppUtils.formattedDate(widget.ordersData.delivery_dt.toString()):'N/A',
                      style: const TextStyle(color: Colors.black,fontSize: 14),),
                    const SizedBox(width: 10,),
                    const Icon(Icons.access_time_outlined,color: AppStyles.SECOND_COLOR,size: 18,),
                    const SizedBox(width: 5,),
                    Text(widget.ordersData.delivery_time??'N/A',
                      style: const TextStyle(color: Colors.black,fontSize: 14),),
                  ],
                ),

              ],
            ),

            widget.type == 'order' ?
            BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
            if (state is OrdersLoaded) {

              return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
           widget.ordersData.order_status == 'Shipped' ?InkWell(
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent,
             onTap: (){
               widget.online == false?ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                       behavior: SnackBarBehavior.floating,
                       backgroundColor: AppStyles.MAIN_COLOR,
                       duration: const Duration(milliseconds: 1200),
                       content:  Container(
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
                                   child:  CircleAvatar(
                                       radius: 20,
                                       backgroundColor: AppStyles.SECOND_COLOR,
                                       child: Image.asset('assets/images/offline.png',height: 25,)
                                   )),
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
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 16),
                                     ),
                                     SizedBox(height: 5,),
                                     Text(
                                       'Go online to start accepting orders',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 12),
                                     )
                                   ],
                                 ))
                           ],
                         ),
                       ))):
               widget.navigateToNext( DashboardScreen(widget.navigateToNext, () => null, widget.online,type: 'order',latitude: widget.lat,longitude: widget.lng,));
             },
             child: Container(
               height: 40,
               width: 200,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(40),
                   color: AppStyles.MAIN_COLOR,
                   boxShadow: const [
                     BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 4)
                   ]
               ),
               child: const Center(child: Text('Open',
                 style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                     color: Colors.white
                 ),),),
             ),
           )
               :  widget.ordersData.order_status == 'Shipped' && widget.ordersData.order_status == 'Pending'?InkWell(
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent,
             onTap: (){
               widget.online == false?ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                       behavior: SnackBarBehavior.floating,
                       backgroundColor: AppStyles.MAIN_COLOR,
                       duration: const Duration(milliseconds: 1200),
                       content:  Container(
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
                                   child:  CircleAvatar(
                                       radius: 20,
                                       backgroundColor: AppStyles.SECOND_COLOR,
                                       child: Image.asset('assets/images/offline.png',height: 25,)
                                   )),
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
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 16),
                                     ),
                                     SizedBox(height: 5,),
                                     Text(
                                       'Go online to start accepting orders',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 12),
                                     )
                                   ],
                                 ))
                           ],
                         ),
                       ))):
               widget.navigateToNext( DashboardScreen(widget.navigateToNext, () => null, widget.online,type: 'order',latitude: widget.lat,longitude: widget.lng,));
             },
             child: Container(
               height: 40,
               width: 200,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(40),
                   color: AppStyles.MAIN_COLOR,
                   boxShadow: const [
                     BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 4)
                   ]
               ),
               child: const Center(child: Text('Start Delivery',
                 style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                     color: Colors.white
                 ),),),
             ),
           )
               :InkWell(
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent,
             onTap: (){
               widget.online == false?ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                       behavior: SnackBarBehavior.floating,
                       backgroundColor: AppStyles.MAIN_COLOR,
                       duration: const Duration(milliseconds: 1200),
                       content:  Container(
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
                                   child:  CircleAvatar(
                                       radius: 20,
                                       backgroundColor: AppStyles.SECOND_COLOR,
                                       child: Image.asset('assets/images/offline.png',height: 25,)
                                   )),
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
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 16),
                                     ),
                                     SizedBox(height: 5,),
                                     Text(
                                       'Go online to start accepting orders',
                                       style: TextStyle(
                                           color: Colors.white,
                                           fontWeight: FontWeight.w500,
                                           fontSize: 12),
                                     )
                                   ],
                                 ))
                           ],
                         ),
                       ))):
               SizedBox();
             },
             child: Container(
               height: 40,
               width: 200,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(40),
                   color: Colors.grey,
                   boxShadow: const [
                     BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 4)
                   ]
               ),
               child: const Center(child: Text('Start Delivery',
                 style: TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 16,
                     color: Colors.white
                 ),),),
             ),
           ),
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        _textMsg(widget.ordersData.billing_phone??'');
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppStyles.MAIN_COLOR,
                        child: Icon(
                          Icons.message_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: (){
                        _makePhoneCall(widget.ordersData.billing_phone??'');
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: AppStyles.MAIN_COLOR,
                        child: Icon(
                          Icons.phone_in_talk_outlined,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )
                  ],
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
              )

        :const SizedBox()
          ],
        ),
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
