// ignore_for_file: use_build_context_synchronously

import 'package:doa_driver_app/bloc/auth/auth_bloc.dart';
import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/tweaks/shared_pref_service.dart';
import 'package:doa_driver_app/utils/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is Authenticated) {
            AppData.user = state.user;
            AppData.accessToken = state.user?.token;
            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user!.id!);
            await sharedPrefService.setUserFirstName(state.user!.firstName!);
            await sharedPrefService.setUserLastName(state.user!.lastName!);
            await sharedPrefService.setUserEmail(state.user!.email!);
            await sharedPrefService.setUserToken(state.user!.token!);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>  MainScreen()), (route) => false);
          } else if (state is UnAuthenticated) {
            AppData.user = null;
            AppData.accessToken = null;
            Navigator.pop(context);
          } else if (state is EmailSent) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        builder: (context, state) => DefaultTabController(
            length: 2, child: SingleChildScrollView(
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
                                  color: Colors.black,
                                  fontFamily: 'MontserratSemiBold'),
                            )
                          ],
                        ),
                        const Text('Mobile Number',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'MontserratSemiBold'),
                        ),
                        const SizedBox(height: 30),
                        const Text('Enter Your Email',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500,
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
                            children:  [
                              Flexible( flex: 5,
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  validator: validateEmail,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Please Enter your Email',
                                    hintStyle: TextStyle(
                                      color: AppStyles.COLOR_GREY_LIGHT,
                                    ),
                                    border: InputBorder.none,),
                                ),
                              ),
                              const Flexible( flex: 1,
                                child: Icon(
                                  Icons.email_outlined,
                                  color:  AppStyles.COLOR_GREY_LIGHT, size: 20,),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30,),
                        const Text( 'Enter Your Password',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500,
                            color: AppStyles.MAIN_COLOR,
                          ),
                        ),
                        CustomTextfield(
                          obscure: true,
                          obscuringCharacter: '●',
                          keyboardType: TextInputType.visiblePassword,
                          hint: 'Please enter your Password',
                          fieldIcon: const Icon(Icons.lock_outline,
                            color: AppStyles.COLOR_GREY_LIGHT, size: 20,),
                          controller: phoneController,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 40.0,
                      width: double.maxFinite,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(AppStyles.MAIN_COLOR),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder( borderRadius: BorderRadius.circular(18.0),
                              ),),
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                            if (emailController.text.isEmpty && phoneController.text.isEmpty){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Center(child: Text('Empty Email or Password')),
                                    duration: Duration(seconds: 1),backgroundColor: AppStyles.MAIN_COLOR,));
                              }else{
                              BlocProvider.of<AuthBloc>(context).add(
                                  PerformLogin(emailController.text, phoneController.text));
                            }},
                          child: const Text("Sign In")),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}
