// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/screens/dashboard/dashboardscreen.dart';
import 'package:doa_driver_app/screens/order/widgets/detailcard.dart';
import 'package:doa_driver_app/utils/widgets/titlebar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final type;
  final OrdersData ordersData;
  final List<OrderDetail>? orderDetail;
  var online;
   OrderDetailScreen({super.key, this.type,this.online, required this.navigateToNext, required this.ordersData, required this.orderDetail});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  int itemDiscount = 0;
  String cartDiscount = '';
  String deliveryCharges = '';

  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    String orderTotal = '';
    String tax = '';
    deliveryCharges = widget.ordersData.shipping_cost.toString();
    tax = widget.ordersData.total_tax.toString();
    orderTotal = widget.ordersData.order_price.toString();
    for(int i = 0; i<widget.orderDetail!.length;i++){
      itemDiscount = widget.orderDetail![i].product?.productDiscountPrice ?? 0;
      cartDiscount = widget.orderDetail![i].productDiscount;
      subtotal += double.parse(widget.orderDetail![i].productPrice.toString()) *
          double.parse(widget.orderDetail![i].productQty.toString());
      // orderTotal = subtotal+ num.parse(deliveryCharges)+ num.parse(tax);

    }
    return Scaffold(

        appBar: AppBar(
          backgroundColor: AppStyles.MAIN_COLOR,
          elevation: 0,
          title: const Text('Order Details',style: TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            DetailCard(ordersData: widget.ordersData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                     SizedBox(
                         width: 180,
                         child: Text('Items',style: TextStyle(fontWeight: FontWeight.bold),)),
                      SizedBox(
                          width: 80,
                          child: Center(child: Text('Qty',style: TextStyle(fontWeight: FontWeight.bold),))),
                      SizedBox(
                          width: 80,
                          child: Center(child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold),)))
                    ],
                  ),
                  const Divider(),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    primary: false,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                      itemCount: widget.ordersData.orderDetail!.length,
                      itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              SizedBox(
                                  width: 180,
                                  child: Text(widget.orderDetail![index].product?.detail![0].title??'Not Available',textAlign: TextAlign.start,)),
                               SizedBox(
                                  width: 80,
                                  child: Center(child: Text(widget.orderDetail![index].productQty))),
                               SizedBox(
                                  width: 80,
                                  child: Center(child: Text('\$${widget.orderDetail![index].productPrice}')))
                            ],
                          ),

                        ],
                      ),
                    );
                  }),
                   const Divider(color: Colors.black38,thickness: 1,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children:   [
                  //     SizedBox(
                  //         width: 180,
                  //         child: Text('Cart Discount',textAlign: TextAlign.start,)),
                  //     SizedBox(
                  //
                  //         width: 80,
                  //         child: Center(child: Text('\$$cartDiscount',style: TextStyle(fontWeight: FontWeight.bold,),))),
                  //   ],
                  // ),
                  // const Divider(color: Colors.transparent,),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children:   [
                  //     SizedBox(
                  //         width: 180,
                  //         child: Text('Items Discount',textAlign: TextAlign.start,)),
                  //     SizedBox(
                  //
                  //         width: 80,
                  //         child: Center(child: Text('\$${itemDiscount.toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.bold),))),
                  //   ],
                  // ),
                  // const Divider(color: Colors.black38,thickness: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:   [
                      const SizedBox(
                          width: 180,
                          child: Text('Sub Total',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$$subtotal',style: const TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:   [
                      const SizedBox(
                          width: 180,
                          child: Text('Tax',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$$tax',style: const TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:   [
                      const SizedBox(
                          width: 180,
                          child: Text('Delivery Charges',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$${widget.ordersData.shipping_cost}',style: const TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:   [
                      const SizedBox(
                          width: 180,
                          child: Text('Total',style:TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 22
                          ),textAlign: TextAlign.start,)),
                      SizedBox(
                          width: 100,
                          child: Center(child: Text('\$$orderTotal',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                    ],
                  ),


                ],
              ),
            ),
           widget.type == 'history'?

           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
             child:  Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
             const Text('Product Delivered',
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                   color: Colors.green
               ),),

             Image.asset('assets/images/success.gif',height: 30,)
             ],
             )
           )
               :Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  widget.online == false?ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: AppStyles.MAIN_COLOR,
                          duration: Duration(milliseconds: 1200),
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
                  widget.navigateToNext( DashboardScreen(widget.navigateToNext, () => null, widget.online,type: 'order',));
                },
                child: Container(
                  height: 50,
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
              ),),

          ],
        ),
      )
    );
  }
}
