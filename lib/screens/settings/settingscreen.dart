
// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/screens/order/orderscreen.dart';
import 'package:doa_driver_app/screens/settings/editprofilescreen.dart';
import 'package:doa_driver_app/screens/signinscreen.dart';
import 'package:doa_driver_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingScreen extends StatefulWidget {
  final type;
  var online;
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;
  final Function(Widget widget) navigateToRemoveUntil;
   SettingScreen({Key? key, required this.navigateToNext, this.type,this.online, required this.navigateToRemoveUntil, required this.openDrawer, }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState(navigateToNext,navigateToRemoveUntil);
}

class _SettingScreenState extends State<SettingScreen> {
  bool  online = false;
  int _selectedIndex = 0;

  final Function(Widget widget) navigateToNext;
  final Function(Widget widget) navigateToRemoveUntil;
  File? imageFile;
  int i = 0;
  _SettingScreenState(this.navigateToNext,this.navigateToRemoveUntil);

  _openHomeDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar:
      widget.type == 'drawer'? const PreferredSize(preferredSize:  Size.fromHeight(0),child: SizedBox(),):
      AppBar(
          elevation: 0,
          backgroundColor: AppStyles.MAIN_COLOR,
          leading: Padding(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () => _openHomeDrawer(),
              // onTap:  s1.assignListner(_counter),
              child: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset("assets/images/menu.png",
                    scale: 2.5,
                    color: Colors.white,
                    fit: BoxFit.none),
              ),
            ),
          ),
          title:  Center(
              child: Text(
                widget.online == false? "Offline": "Online",
                // AppLocalizations.of(context)!.translate('app_name')!,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontFamily: "MontserratBold",
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),
              )),
          actions: [ Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FlutterSwitch(
              activeSwitchBorder: Border.all(color: Colors.white),

              activeColor: AppStyles.MAIN_COLOR,
              width: 45.0,
              height: 30.0,
              valueFontSize: 12.0,
              toggleSize: 20.0,
              value: widget.online ,
              borderRadius: 20.0,
              padding: 5.0,
              showOnOff: false,
              onToggle: (val) {
                setState(() {
                  widget.online  = val;
                });
              },
            ),
          )]
      ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  widget.type == 'drawer' ? Container(color: AppStyles.MAIN_COLOR,height: 40,): const SizedBox(height: 0,),
                  Container(
                    height: 90,
                    color: AppStyles.MAIN_COLOR,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                    //  mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16),
                          child: Row(
                            children: [
                               Container(
                                width: 60.0,
                                height: 60.0,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: CachedNetworkImage(
                                    imageUrl: "https://image.shutterstock.com/image-photo/smile-confidence-young-man-professional-260nw-1801689064.jpg",
                                    fit: BoxFit.cover,
                                    progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                        Image.network("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png"),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error,color: Colors.white,),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    "Mike Jones",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'mikejones1@doa.com',
                                    style:
                                    TextStyle(color: Colors.white,fontSize: 12),
                                  ),
                                ],
                              ),
                              const Expanded(child: SizedBox()),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: (){
                                  navigateToNext(const EditProfileScreen());
                                },
                                child: IconTheme(
                                    data: const IconThemeData(
                                        color: Colors.black),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10,vertical: 2),

                                      color: Colors.white,
                                      child: const Center(
                                        child: Text(
                                          'Edit',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              GestureDetector(
                                onTap: (){
                                navigateToNext(const NotificationPage());
                                },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.notifications_outlined,
                                        color: AppStyles.MAIN_COLOR,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: Text(
                                            'Notifications',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  )),
                              const Divider(height: 1, color: AppStyles.MAIN_COLOR),

                              GestureDetector(
                                onTap: (){
                                  navigateToNext(OrderScreen(navigateToNext, _openHomeDrawer,widget.online,type: widget.type,));
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.list_alt_outlined,
                                        color: AppStyles.MAIN_COLOR,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 10),
                                          child: Text(
                                            'Orders',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ],
                                  )),
                              const Divider(height: 1, color: AppStyles.MAIN_COLOR),

                            GestureDetector(
                              onTap: (){
                                navigateToRemoveUntil(const SignInScreen());
                              },
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.logout_outlined,
                                          color: AppStyles.MAIN_COLOR,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                            child: Text(
                                              'Logout',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                      ],
                                    )),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
      //    ),
    );
  }

}
