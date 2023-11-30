// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously
import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/screens/signinscreen.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with  SingleTickerProviderStateMixin{
  late AnimationController controller;
  bool isLogin = false;

   double? latitude;
   double? longitude;

  late bool serviceEnabled;

  Future<void> _callSplashScreen() async {
    Position position = await _getGeoLocationPosition();
    latitude = position.latitude;
    longitude = position.longitude;
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


  Future<void> checkIfUserLoggedIn() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    int? userId = sharedPrefService.userId;
    if (userId != null) {
      User user = User();
      user.id = userId;
      user.firstName = sharedPrefService.userFirstName;
      user.lastName = sharedPrefService.userLastName;
      user.email = sharedPrefService.userEmail;
      user.mobile = sharedPrefService.userPhone;
      user.vehicle_registration_no = sharedPrefService.userVehicle;

      AppData.user = user;

      BlocProvider.of<AuthBloc>(context).add(PerformAutoLogin(user));

      setState(() {
        isLogin = true;
      });

    }
  }

  checkLoginStatus() async {
    if(isLogin == true){
      Navigator.of(context)
          .pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen(lat: latitude,lng: longitude,)),
              (route) => false);
    }else{
      Future.microtask(() => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) =>
               const SignInScreen())));
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _callSplashScreen();
  }

  @override
  void initState() {
    super.initState();
    _callSplashScreen();
    checkIfUserLoggedIn();

    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    controller.forward().then((_) async {
      await checkLoginStatus();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "assets/images/splash.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
              child: Image.asset(
                "assets/images/logo.png",
                scale: 2.5,
              )),
          const Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "© Royal Kush",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),);
  }
}
