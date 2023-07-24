import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:doa_driver_app/mainscreen.dart';
import 'package:doa_driver_app/screens/order/orderdetailscreen.dart';
import 'package:doa_driver_app/utils/switch.dart';
import 'package:doa_driver_app/utils/widgets/myappbar.dart';
import 'package:doa_driver_app/utils/widgets/titlebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'widgets/customcards.dart';

class OrderScreen extends StatefulWidget {
  final type;
  var online;
  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;

   OrderScreen(this.navigateToNext, this.openDrawer,this.online, {super.key, this.type, });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool  online = false;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }
  _openHomeDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        appBar: 
        
        widget.type == 'order'?
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
        ):AppBar(
          elevation: 1,
          backgroundColor: AppStyles.MAIN_COLOR,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Orders',style: TextStyle(color: Colors.white),),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                      child:  CustomCard(navigateToNext:  widget.navigateToNext,type: 'order',online: widget.online,),
                    );
                  }),
            ],
          ),
        )
    );
  }
}
