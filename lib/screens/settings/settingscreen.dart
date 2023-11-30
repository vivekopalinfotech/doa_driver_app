// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/settings/editprofilescreen.dart';
import 'package:doa_driver_app/screens/signinscreen.dart';
import 'package:doa_driver_app/utils/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatefulWidget {
  final Function(Widget widget) navigateToNext;

  SettingScreen({
    Key? key,
    required this.navigateToNext,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState(navigateToNext);
}

class _SettingScreenState extends State<SettingScreen> {
  bool online = false;

  final Function(Widget widget) navigateToNext;

  File? imageFile;
  int i = 0;
  _SettingScreenState(this.navigateToNext);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, toolbarHeight: 60,
          backgroundColor: AppStyles.MAIN_COLOR,
          automaticallyImplyLeading: false,
          leadingWidth: 80,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {

              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    )),
                Text(' Back',
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )
              ],
            ),
          ),
          centerTitle: true,
          title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 90,
              color: AppStyles.MAIN_COLOR,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                //  mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: CachedNetworkImage(
                              imageUrl: "https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Image.network("https://wisdomexperience.org/wp-content/uploads/2019/10/blank-profile-picture-973460_960_720.png"),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${AppData.user?.firstName} ${AppData.user?.lastName}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${AppData.user?.email}',
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            navigateToNext(const EditProfileScreen());
                          },
                          child: IconTheme(
                              data: const IconThemeData(color: Colors.black),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                color: Colors.white,
                                child: const Center(
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
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
                            onTap: () {
                              navigateToNext(const NotificationPage());
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.notifications_outlined,
                                  color: AppStyles.MAIN_COLOR,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                    child: Text(
                                      'Notifications',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    )),
                              ],
                            )),
                        const Divider(height: 1, color: AppStyles.MAIN_COLOR),

                        // GestureDetector(
                        //   onTap: (){
                        //     navigateToNext(OrderScreen(navigateToNext, _openHomeDrawer,widget.online,'','',type: 'order',));
                        //     },
                        //     child: Row(
                        //       children: const [
                        //         Icon(
                        //           Icons.list_alt_outlined,
                        //           color: AppStyles.MAIN_COLOR,
                        //         ),
                        //         Padding(
                        //             padding: EdgeInsets.symmetric(
                        //                 vertical: 20, horizontal: 10),
                        //             child: Text(
                        //               'Orders',
                        //               style: TextStyle(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold),
                        //             )),
                        //       ],
                        //     )),
                        // const Divider(height: 1, color: AppStyles.MAIN_COLOR),

                        BlocConsumer<AuthBloc, AuthState>(
                          builder: (context, state) => GestureDetector(
                              onTap: () {
                                showAlertDialog1(context);
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.logout_outlined,
                                    color: AppStyles.MAIN_COLOR,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      )),
                                ],
                              )),
                          listener: (context, state) {
                            if (state is UnAuthenticated) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("logout successful")));
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SplashScreen()),
                              //         (route) => false);
                            }
                          },
                        )
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

  void showAlertDialog1(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Logout", style: TextStyle(color: AppStyles.MAIN_COLOR, fontWeight: FontWeight.bold)),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false,
        );
        BlocProvider.of<AuthBloc>(context).add(const PerformLogout());
      },
    );
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: 200,
            child: const Text(
              "Are You Sure You Want to Logout?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppStyles.MAIN_COLOR),
            ),
          ),
        ],
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
