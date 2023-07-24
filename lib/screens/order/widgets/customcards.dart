import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/dashboard/dashboardscreen.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:doa_driver_app/utils/widgets/starrating.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final Function(Widget widget) navigateToNext;
  final type;
  var online;
   CustomCard({super.key, this.type,this.online, required this.navigateToNext});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.type == 'order'? 300:260,
      decoration: BoxDecoration(
          gradient:   LinearGradient(colors: [Colors.white,AppStyles.SECOND_COLOR.withOpacity(.8),AppStyles.SECOND_COLOR.withOpacity(.9),AppStyles.SECOND_COLOR],begin: AlignmentDirectional.topCenter,end: Alignment.bottomCenter),
          color: Colors.white,
          boxShadow: [
        BoxShadow(blurRadius: 1,spreadRadius: 3,color: Colors.grey.shade200)
      ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const Text('Dank of America',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                    //      const SizedBox(height: 5,),
                          Text('OBD Store',style: TextStyle(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 14),),
                      //    const SizedBox(height: 5,),
                          StarRating(
                            starCount: 5,
                            rating: 5,
                            onRatingChanged: (rating) {}, color: Colors.amber,),
                      ],),

                    ],

                  ),
                ),
                Flexible(
                  flex: 3,
                  child: SizedBox(
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:CrossAxisAlignment.end,
                      children:  [
                        const Text('\$230.00',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),),
                  //      const SizedBox(height: 5,),
                        const Text('2.5 km',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                   //     const SizedBox(height: 5,),
                        InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: (){
                              widget.navigateToNext(OrderDetailScreen(
                                    type: widget.type, navigateToNext: widget.navigateToNext,online: widget.online,
                                  ));
                            },
                            child: const Text('Order Details >',style: TextStyle(color: AppStyles.MAIN_COLOR,fontWeight: FontWeight.bold,fontSize: 11),)),
                      ],),
                  ),
                ),
              ],
            ),
        //    const SizedBox(height: 5,),

            const Text('Pick Up',
              style: TextStyle(color: Colors.grey,fontSize: 12),),
        //    const SizedBox(height: 5,),

            const SizedBox(
              width: 250,
              child: Text('123,ABC Building,Near Mall Road...',
                style: TextStyle(color: Colors.black,fontSize: 14),),
            ),
      //      const SizedBox(height: 10,),

            const Text('Drop Off',
              style: TextStyle(color: Colors.grey,fontSize: 12),),
           // const SizedBox(height: 5,),

            const SizedBox(
              width: 250,
              child: Text('3rd Floor, william street, Twin Tower gh vhhunjkn vuhjvu hvhvhjvhjvhjvhjvhvhj...',
                style: TextStyle(color: Colors.black,fontSize: 14),overflow: TextOverflow.ellipsis,),
            ),
       //     const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(Icons.calendar_month_outlined,color: AppStyles.MAIN_COLOR,size: 18,),
                    SizedBox(width: 5,),
                    Text('03/23/2022',
                      style: TextStyle(color: Colors.black,fontSize: 14),),
                    SizedBox(width: 10,),
                    Icon(Icons.access_time_outlined,color: AppStyles.MAIN_COLOR,size: 18,),
                    SizedBox(width: 5,),
                    Text('8:01 pm',
                      style: TextStyle(color: Colors.black,fontSize: 14),),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppStyles.NEW_COLOR,
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

            widget.type == 'order'?
            Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: (){
                  widget.navigateToNext( DashboardScreen(widget.navigateToNext, () => null, widget.online,type: 'order',));
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
              ),
            ):SizedBox()
          ],
        ),
      ),

    );
  }
}
