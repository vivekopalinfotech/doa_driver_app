// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/models/user.dart';
import 'package:doa_driver_app/screens/signinscreen.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with  SingleTickerProviderStateMixin{
  late AnimationController controller;
  bool isLogin = false;

  Future<void> checkIfUserLoggedIn() async {
    final sharedPrefService = await SharedPreferencesService.instance;
    int? userId = sharedPrefService.userId;
    if (userId != null) {
      User user = User();
      user.id = userId;
      user.firstName = sharedPrefService.userFirstName;
      user.lastName = sharedPrefService.userLastName;
      user.email = sharedPrefService.userEmail;
      user.token = sharedPrefService.userToken;
      AppData.user = user;
      AppData.accessToken = user.token;
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
          MaterialPageRoute(builder: (context) => MainScreen()),
              (route) => false);
    }else{
      Future.microtask(() => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (BuildContext context) =>
              const SignInScreen())));
    }
  }

  @override
  void initState() {
    super.initState();
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
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/images/splash.jpg',
            fit: BoxFit.cover,)));
  }
}
