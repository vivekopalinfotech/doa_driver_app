import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/utils/widgets/starrating.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailCard extends StatefulWidget {
  const DetailCard({super.key});

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
        padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 5),
    child: Container(
    height: 270,
    decoration: BoxDecoration(
    gradient:   LinearGradient(colors: [Colors.white,AppStyles.SECOND_COLOR.withOpacity(.8),AppStyles.SECOND_COLOR.withOpacity(.9),AppStyles.SECOND_COLOR],begin: AlignmentDirectional.topCenter,end: Alignment.bottomCenter),
    color: Colors.white,
    border: Border.all(color: Colors.grey.shade100),
    boxShadow: [
    BoxShadow(blurRadius: 1,spreadRadius: 3,color: Colors.grey.shade200)
    ]),
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
            children: const [
              Text(
                'Order ',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '#1234567',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          StarRating(
            starCount: 5,
            rating: 5,
            onRatingChanged: (rating) {},
            color: Colors.amber,
          ),
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
                  const Text(
                    'Dank of America',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                //  const SizedBox(height: 5,),
                  Text(
                    'OBD Store',
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
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
            children: const [
              Text(
                '\$230.00',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
             // SizedBox(height: 5,),
              Text(
                '2.5 km',
                style: TextStyle(
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
      const Text(
        'Phone Number',
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
     // const SizedBox(height: 5,),
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: (){
          _makePhoneCall('(805)123 4567');
        },
        child: const SizedBox(
          width: 250,
          child: Text(
            '(805)123 4567',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
            ),
          ),
        ),
      ),
    //  const SizedBox(height: 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Delivery Time',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
          //    SizedBox(height: 5,),
              SizedBox(
                child: Text(
                  'Not Available',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
       //   const SizedBox(width: 15,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                'Delivery Method',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
        //      SizedBox(height: 5,),
              SizedBox(
                child: Text(
                  'CurbSide',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
       //   const SizedBox(width: 20,),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              _textMsg('(805)123 4567');
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: AppStyles.MAIN_COLOR,
              child: Icon(
                Icons.message_outlined,
                color: Colors.black,
                size: 18,
              ),
            ),
          ),
       //   const SizedBox(width: 15,),
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              _makePhoneCall('(805)123 4567');
            },
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: AppStyles.MAIN_COLOR,
              child: Icon(
                Icons.phone_in_talk_outlined,
                color: Colors.black,
                size: 18,
              ),
            ),
          )
        ],
      ),
   //   const SizedBox(height: 15,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          Text(
            'Created at',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
       //   SizedBox(height: 5,),
          SizedBox(
            child: Text(
              '03/23/2022, 8:01 pm',
              style: TextStyle(color: Colors.black, fontSize: 16),
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
