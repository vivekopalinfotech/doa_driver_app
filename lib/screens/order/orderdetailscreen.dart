// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/dashboard/dashboardscreen.dart';
import 'package:doa_driver_app/screens/order/widgets/detailcard.dart';
import 'package:doa_driver_app/utils/widgets/titlebar.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final type;
  var online;
   OrderDetailScreen({super.key, this.type,this.online, required this.navigateToNext});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {

  List items = [
    'Packwoods-Yellow Fruit Strips Blunt 2g',
    'Packwoods-Medellin Blunt 2g',
    'Packwoods-Runtz Blunt 2g',
    'Packwoods-Tear Gas Blunt 2g',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppStyles.MAIN_COLOR,
          elevation: 0,
          title: Text('Order Details',style: TextStyle(color: Colors.white),),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const DetailCard(),
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
                      itemCount: items.length,
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
                                  child: Text(items[index],textAlign: TextAlign.start,)),
                              const SizedBox(
                                  width: 80,
                                  child: Center(child: Text('1 Pcs'))),
                              const SizedBox(

                                  width: 80,
                                  child: Center(child: Text('\$25.00')))
                            ],
                          ),

                        ],
                      ),
                    );
                  }),
                  const Divider(color: Colors.black38,thickness: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      SizedBox(
                          width: 180,
                          child: Text('Cart Discount',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$30.00',style: TextStyle(fontWeight: FontWeight.bold,),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      SizedBox(
                          width: 180,
                          child: Text('Items Discount',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$0.00',style: TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.black38,thickness: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      SizedBox(
                          width: 180,
                          child: Text('Sub Total',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$150.00',style: TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      SizedBox(
                          width: 180,
                          child: Text('Tax',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$0.00',style: TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      SizedBox(
                          width: 180,
                          child: Text('Delivery Charges',textAlign: TextAlign.start,)),
                      SizedBox(

                          width: 80,
                          child: Center(child: Text('\$5.00',style: TextStyle(fontWeight: FontWeight.bold),))),
                    ],
                  ),
                  const Divider(color: Colors.transparent,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  const [
                      SizedBox(
                          width: 180,
                          child: Text('Total',style:TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 22
                          ),textAlign: TextAlign.start,)),
                      SizedBox(
                          width: 100,
                          child: Center(child: Text('\$125.00',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
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
