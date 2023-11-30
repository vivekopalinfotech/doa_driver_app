import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCard extends StatefulWidget {
  final OrdersData ordersData;
  final miles;
  const DetailCard({super.key, required this.ordersData, this.miles});

  @override
  State<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends State<DetailCard> {


  Future<void> _makePhoneCall(String phone) async {
    final Uri launchUri = Uri.parse('tel:$phone');
    await launchUrl(launchUri);
  }

  Future<void> _textMsg(String phone) async {
    final Uri launchUri = Uri.parse('sms:$phone');
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
    child: Container(

        color: Colors.white,

    height: 220,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

      Row(

        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25,
            backgroundImage: AssetImage(
              'assets/images/profile.jpg',
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   AppUtils.capitalizeFirstLetter(
                   '${widget.ordersData.billing_first_name} ${widget.ordersData.billing_last_name}'),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
              //  const SizedBox(height: 5,),
                Text(
                  widget.ordersData.warehouse!.warehouse_name??'',
                  style: const TextStyle(
                      color: AppStyles.MAIN_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
              //  const SizedBox(height: 5,),
              ],
            ),
          ),
      
        ],
      ),
   Divider(color: Colors.black38,),
     Row(
       children: [
         Flexible(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text(
                     'Cell Phone: ',
                     style: TextStyle(color: Colors.black26, fontSize: 14),
                   ),

                   Flexible(
                     child: Text(
                       widget.ordersData.billing_phone??'',
                       style: const TextStyle(
                         color:  AppStyles.SECOND_COLOR,
                         fontSize: 14,
                         decoration: TextDecoration.underline,
                         decorationStyle: TextDecorationStyle.solid,
                       ),
                     ),
                   ),        ],
               ),
               SizedBox(height: 8,),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text(
                     'Created At: ',
                     style: TextStyle(color: Colors.black26, fontSize: 14),
                   ),
                   const SizedBox(height: 5,),
                   Flexible(
                     child: Text(
                       '${AppUtils.convertDate(widget.ordersData.order_date??'')}, ${AppUtils.convertTime(widget.ordersData.order_time??'')}',
                       style: const TextStyle(
                         color:  Colors.black,
                         fontSize: 14,

                         decorationStyle: TextDecorationStyle.solid,
                       ),
                     ),
                   ),        ],
               ),
               SizedBox(height: 8,),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Text(
                     'Delivery Time: ',
                     style: TextStyle(color: Colors.black26, fontSize: 14),
                   ),
                   const SizedBox(height: 5,),
                   Flexible(
                     child: Text(
                       widget.ordersData.delivery_time??"Not Available",
                       style: const TextStyle(
                         color:  Colors.black,
                         fontSize: 14,

                         decorationStyle: TextDecorationStyle.solid,
                       ),
                     ),
                   ),        ],
               ),
             ],
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
         )
       ],
     )


    ]),),

    ),
    );
  }

}
