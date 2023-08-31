import 'package:doa_driver_app/constants/app_utils.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/models/order.dart';
import 'package:doa_driver_app/utils/widgets/starrating.dart';
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white
      ),
    height: 270,
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children:  [
              const Text(
                'Order  ',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '#${widget.ordersData.orderId}',
                style: const TextStyle(
                    fontSize: 16,
                    color: AppStyles.SECOND_COLOR,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          // StarRating(
          //   starCount: 5,
          //   rating: 5,
          //   onRatingChanged: (rating) {},
          //   color: Colors.amber,
          // ),
        ],
      ),
    //  const SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                children: [
                   Text(
                     '${widget.ordersData.billing_first_name} ${widget.ordersData.billing_last_name}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  [
              Text(
                '\$${widget.ordersData.order_price}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
             // SizedBox(height: 5,),
               Text(
                '${widget.miles} mi',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
           //   SizedBox(height: 5,),
            ],
          ),
        ],
      ),
 //  SizedBox(height: 10,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Phone Number',
            style: TextStyle(color: AppStyles.SECOND_COLOR, fontSize: 12),
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: 250,
            child: Text(
              widget.ordersData.billing_phone??'',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
          ),        ],
      ),
    //  const SizedBox(height: 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              const Text(
                'Delivery Time',
                style: TextStyle(color: AppStyles.SECOND_COLOR, fontSize: 12),
              ),
           const SizedBox(height: 5,),
              SizedBox(
                child: Text(
                 widget.ordersData.delivery_time??"Not Available",
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
       //   const SizedBox(width: 15,),
       //    Column(
       //      crossAxisAlignment: CrossAxisAlignment.start,
       //      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       //      children:  [
       //        const Text(
       //          'Delivery Method',
       //          style: TextStyle(color: AppStyles.SECOND_COLOR, fontSize: 12),
       //        ),
       //       const SizedBox(height: 5,),
       //        SizedBox(
       //          child: Text(
       //            widget.ordersData.shipping_method??'',
       //
       //            style: const TextStyle(color: Colors.black, fontSize: 16),
       //            overflow: TextOverflow.ellipsis,
       //          ),
       //        ),
       //      ],
       //    ),
       //   const SizedBox(width: 20,),
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
      ),
   //   const SizedBox(height: 15,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:  [
          const Text(
            'Created at',
            style: TextStyle(color: AppStyles.SECOND_COLOR, fontSize: 12),
          ),
         const SizedBox(height: 5,),
          SizedBox(
            child: Text(
             '${AppUtils.convertDate(widget.ordersData.order_date??'')}, ${AppUtils.convertTime(widget.ordersData.order_time??'')}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ]),),

    ),
    );
  }

}
