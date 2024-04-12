// ignore_for_file: must_be_immutable

import 'package:doa_driver_app/bloc/otp/otp_bloc.dart';
import 'package:doa_driver_app/bloc/shift/shift_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  final lat;
  final lng;
  String phone = "";
  final otp;
  final user;
  OtpScreen({Key? key, required this.phone, this.otp, this.user, this.lat, this.lng}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  String? _otp;
  String currentText = "";

  @override
  void initState() {
    print(widget.otp);
    print(widget.user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<OtpBloc, OtpState>(
        builder: (context, state) {
          return ScrollConfiguration(
              behavior:  ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 8.0,
                        ),
                        child: SizedBox(
                          height: 230,
                          width: MediaQuery.of(context).size.width,
                          child: Image.asset(
                            'assets/images/onboarding.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22, right: 22, top: 50),
                        child: Column(
                          children: [
                            const Text(
                              "ENTER OTP",
                              style: TextStyle(
                                color: AppStyles.MAIN_COLOR,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Enter four digit code sent on your email.",
                              style: TextStyle(
                                color: AppStyles.MAIN_COLOR,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  OtpInput(_fieldOne, true),
                                  OtpInput(_fieldTwo, false),
                                  OtpInput(_fieldThree, false),
                                  OtpInput(_fieldFour, false),
                                  OtpInput(_fieldFive, false),
                                  OtpInput(_fieldSix, false),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              height: 40.0,
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppStyles.MAIN_COLOR),
                                    elevation: MaterialStateProperty.all(0),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _otp = _fieldOne.text + _fieldTwo.text + _fieldThree.text + _fieldFour.text + _fieldFive.text + _fieldSix.text;
                                    });
                                    print(widget.user);
                                    print(widget.otp);
                                    print(_otp);
                                    if (_otp.toString() != widget.otp.toString()) {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                          backgroundColor: AppStyles.MAIN_COLOR,
                                          duration: Duration(milliseconds: 1200),
                                          content: Center(
                                            child: Text(
                                              'Invalid Otp',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          )));
                                    } else if (widget.user == "true" && _otp.toString() == widget.otp.toString()) {
                                      BlocProvider.of<OtpBloc>(context).add(PerformLogin(widget.phone, _otp.toString()));
                                      //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  MainScreen()), (route) => false);
                                    } else {
                                      throw 'error';
                                    }
                                    //    }
                                  },
                                  child: const Text(
                                    "Submit",
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
        listener: (context, state) async {
          if (state is OtpSuccess) {
            AppData.user = state.user;
            // AppData.accessToken = state.user?.token;
            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user!.id!);
            await sharedPrefService.setUserFirstName(state.user!.firstName!);
            await sharedPrefService.setUserLastName(state.user!.lastName!);
            await sharedPrefService.setUserEmail(state.user!.email!);
            await sharedPrefService.setUserPhone(state.user!.mobile!);
            await sharedPrefService.setUserVehicle(state.user!.vehicle_registration_no!);
            await sharedPrefService.setUserVehicleColor(state.user!.vehicle_color ?? '');
            await sharedPrefService.setMobileCode(state.user!.mobile_del_code!);
            print('***************');
            print(state.user!.firstName!);
            print(state.user!.lastName!);
            print(state.user!.email!);
            print(state.user!.mobile!);
            print('***************');
            FirebaseMessaging.instance.getToken().then((value) {
              BlocProvider.of<UpdateShiftBloc>(context).add(CheckUpdateShift(int.parse(AppData.user!.id.toString()), int.parse(state.user!.availability_status.toString()), value.toString()));
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(
                          lat: widget.lat,
                          lng: widget.lng,
                        )),
                (route) => false);
          }
        },
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      padding: EdgeInsets.only(bottom: 5),
      decoration: const BoxDecoration(color: AppStyles.SECOND_COLOR, borderRadius: BorderRadius.all(Radius.circular(9))),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        style: const TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        maxLength: 1,
        cursorColor: AppStyles.MAIN_COLOR,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(80.0),
              borderSide: const BorderSide(color: Color(0xffA68F4C), width: 0.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(80.0),
              borderSide: const BorderSide(color: Color(0xffA68F4C), width: 0.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(80.0),
              borderSide: const BorderSide(color: Color(0xffA68F4C), width: 0.0),
            ),
            counterText: ''),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        validator: (otpvalidation) {
          if (otpvalidation!.isEmpty) {
            return "";
          }
          return null;
        },
      ),
    );
  }
}
