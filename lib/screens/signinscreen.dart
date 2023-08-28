// ignore_for_file: use_build_context_synchronously

import 'package:doa_driver_app/bloc/login/mobile_bloc.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/screens/otp_screen.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class SignInScreen extends StatefulWidget {

  const SignInScreen({Key? key,}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController mobileController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String latitude = "";
  String longitude = "";
  late bool serviceEnabled;
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
  Future<void> _callSplashScreen() async {
    Position position = await _getGeoLocationPosition();
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
  }
  Future<Position> _getGeoLocationPosition() async {
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      // showSnackBar(context, "You have to give your location permission");
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _callSplashScreen();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callSplashScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  BlocConsumer<MobileBloc, MobileState>(
        builder: (context, state) {
      return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,),
                    child: SizedBox(
                      height: 230,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/images/onboarding.jpg', fit: BoxFit.fill),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( children: const [
                            Text('Sign In ',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold,
                                  color: AppStyles.MAIN_COLOR,
                                  fontFamily: 'MontserratSemiBold'),
                            ),
                            Text('with Email &',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold,
                                  color: AppStyles.SECOND_COLOR,
                                  fontFamily: 'MontserratSemiBold'),
                            )
                          ],
                        ),
                        const Text('Mobile Number',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold,
                              color: AppStyles.SECOND_COLOR,
                              fontFamily: 'MontserratSemiBold'),
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            const SizedBox(height: 30),
                            const Text(
                              'Enter Your Phone Number',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppStyles.MAIN_COLOR,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppStyles.SECOND_COLOR),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '+1',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: AppStyles.MAIN_COLOR),
                                  ),
                                  Flexible(
                                    flex: 5,
                                    child: TextFormField(
                                      cursorColor: AppStyles.MAIN_COLOR,
                                      controller: mobileController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                        color: AppStyles.MAIN_COLOR,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: const InputDecoration(
                                          hintText: 'Phone Number',
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const Flexible(
                                      flex: 1,
                                      child: Icon(
                                        Icons.phone_outlined,
                                        color: AppStyles.MAIN_COLOR,
                                        size: 22,
                                      ))
                                ],
                              ),
                            ),
                            const SizedBox(height: 30,),
                            SizedBox(
                              height: 40.0,
                              width: double.maxFinite,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(AppStyles.MAIN_COLOR),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0),
                                      ),),
                                  ),
                                  onPressed: () {
                                    print(mobileController.text);
                                    BlocProvider.of<MobileBloc>(context).add(PerformMobile(mobileController.text));
                                    },
                                  child: const Text("Sign In")),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            );
        },
        listener: (context, state) async {
          if (state is MobileSuccess) {

            setState(() {
              state.data!.mobile = mobileController.text;
            });

            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserPhone(mobileController.text);

            if(state.data != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OtpScreen(phone: state.data!.mobile.toString(),
                            otp: state.data!.Code,
                            user: state.data!.user,lat: latitude,lng: longitude,)));
            }else {
              const ScaffoldMessenger(
                  child: Text('Enter Valid Phone Number'));
            }
          }
        },
      ));


  }
}
