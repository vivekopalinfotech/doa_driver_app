// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';


class NotificationPage extends StatefulWidget {
  final type;
  const NotificationPage({Key? key, this.type}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class Notification{
  final String img;
  final String notification;

  Notification(this.img, this.notification);
}
class _NotificationPageState extends State<NotificationPage> {

  List<Notification> notification = [
      Notification("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png", "Test Notification 1"),
      Notification("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png", "Test Notification 2"),
      Notification("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png", "Test Notification 3"),
      Notification("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png", "Test Notification 4"),
      Notification("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png", "Test Notification 5"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       elevation: 1,
        backgroundColor: AppStyles.MAIN_COLOR,
        title: const Text('Notifications',style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
                children: [
                  const SizedBox(height: 10,),
                   Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 18),
                          child:
                          ListView.builder(

                            shrinkWrap: true,
                            itemCount: notification.length,
                            //        itemCount: state.notificationResponse.data?.docs?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){

                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 4),
                                        child: InkWell(
                                          onTap: (){},
                                          child: Row( children: [
                                          Flexible(flex: 1,
                                            child: CachedNetworkImage(
                                                  imageUrl: notification[index].img,
                                                  height: 45, width: 45,
                                                  imageBuilder: (context, imageProvider) => Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(56),
                                                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                  progressIndicatorBuilder:
                                                      (context, url, downloadProgress) =>
                                                  const CircleAvatar(backgroundImage: NetworkImage("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png"),),
                                                  errorWidget: (context, url, error) =>
                                                  const CircleAvatar(backgroundImage: NetworkImage("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png"),)),
                                          ),
                                            const SizedBox(width: 15,),
                                            Flexible(flex: 6,
                                              child: Text(
                                                  notification[index].notification,
                                                  style: const TextStyle(
                                                    color:  AppStyles.MAIN_COLOR,
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                            ),
                                          ]),
                                        ),
                                      ),
                                      //   const SizedBox(height : 15),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                      ),
                    ),
                  )
                ],
              ),
            );

  }
}
