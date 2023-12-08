// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/settings/editprofilescreen.dart';
import 'package:doa_driver_app/screens/signinscreen.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
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
  final TextEditingController _firstNameController =
  TextEditingController();
  final TextEditingController _emailController =
  TextEditingController();
  final TextEditingController _lastNameController =
  TextEditingController();
  final TextEditingController _phoneController =
  TextEditingController();
  final TextEditingController _VehicleNumberController =
  TextEditingController();
  final TextEditingController _VehicleColorController =
  TextEditingController();
  final TextEditingController _passCodeController =
  TextEditingController();

  _SettingScreenState(this.navigateToNext);
  @override
  void initState() {
    _firstNameController.text = AppData.user!.firstName!;
    _lastNameController.text = AppData.user!.lastName!;
    _phoneController.text = AppData.user!.mobile!;
    _emailController.text = AppData.user!.email!;
    _VehicleNumberController.text = AppData.user!.vehicle_registration_no!;
    _VehicleColorController.text = AppData.user!.vehicle_color!;
    _passCodeController.text = AppData.user!.mobile_del_code!;
    super.initState();
  }
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                // onTap: () => _openHomeDrawer(),
                onTap: () => showAlertDialog1(context),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset(
                    "assets/images/menu.png",
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
          centerTitle: true,
          title: const Text('Profile'),),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height*.9,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppStyles.SECOND_COLOR,
                        padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        child: Text('Personal Details:',  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppStyles.MAIN_COLOR),),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'First Name: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      autofocus: false,
                                      controller: _firstNameController,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(40),
                                            borderSide: const BorderSide(
                                              width: 0,
                                              style: BorderStyle.none,
                                            ),
                                          ),
                                          // border: InputBorder.none,
                                          hintText: "First Name",
                                          hintStyle: const TextStyle(
                                              color: Colors.brown,
                                              fontSize: 14),
                                         ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Last Name: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      autofocus: false,
                                      controller: _lastNameController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        // border: InputBorder.none,
                                        hintText: "First Name",
                                        hintStyle: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Phone Number: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      readOnly: true,
                                      autofocus: false,
                                      controller: _phoneController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        // border: InputBorder.none,
                                        hintText: "Phone Number",
                                        hintStyle: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Email: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(

                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      readOnly: true,
                                      autofocus: false,
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        // border: InputBorder.none,
                                        hintText: "Email Address",
                                        hintStyle: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppStyles.SECOND_COLOR,
                        padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        child: Text('Vehicle Details:',  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppStyles.MAIN_COLOR),),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Vehicle No: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      autofocus: false,
                                      controller: _VehicleNumberController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        // border: InputBorder.none,
                                        hintText: "Vehicle No.",
                                        hintStyle: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 1,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Vehicle Color: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      autofocus: false,
                                      controller: _VehicleColorController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        // border: InputBorder.none,
                                        hintText: "Color",
                                        hintStyle: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppStyles.SECOND_COLOR,
                        padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                        child: Text('Login Code:',  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppStyles.MAIN_COLOR),),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children:  [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'Pass Code: ',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: AppStyles.SECOND_COLOR),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppStyles.SECOND_COLOR.withOpacity(.3)
                                  ),
                                  height: 45,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ThemeData().colorScheme.copyWith(
                                        primary: AppStyles.MAIN_COLOR,
                                      ),
                                    ),
                                    child: TextField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      autofocus: false,
                                      controller: _passCodeController,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        // border: InputBorder.none,
                                        hintText: "PassCode",
                                        hintStyle: const TextStyle(
                                            color: Colors.brown,
                                            fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                )),
          ),
          Positioned(
              bottom: 24,left: 0,right: 0,
              child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
                height: 40.0,
                width: double.maxFinite,
                child:
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppStyles.MAIN_COLOR),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          )
                      )
                  ),
                  onPressed: () {

                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Update",style: TextStyle(
                    color: Colors.white,
                  ),
                  ),
                )
            ),
          )),
        ],
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
        final sharedPrefService = await SharedPreferencesService.instance;
        sharedPrefService.logoutUser();
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInScreen()),
          (Route<dynamic> route) => false,
        );

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
