
// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables, must_be_immutable

import 'dart:io';

import 'package:doa_driver_app/constants/app_data.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';

class ShiftScreen extends StatefulWidget {
  final type;

  final Function(Widget widget) navigateToNext;
  final Function() openDrawer;
  final Function(Widget widget) navigateToRemoveUntil;
  ShiftScreen({Key? key, required this.navigateToNext, this.type, required this.navigateToRemoveUntil, required this.openDrawer, }) : super(key: key);

  @override
  State<ShiftScreen> createState() => _ShiftScreenState(navigateToNext,navigateToRemoveUntil);
}

class _ShiftScreenState extends State<ShiftScreen> {
  bool  online = false;


  final Function(Widget widget) navigateToNext;
  final Function(Widget widget) navigateToRemoveUntil;
  File? imageFile;
  int i = 0;
  _ShiftScreenState(this.navigateToNext,this.navigateToRemoveUntil);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
              child: Center(
                child: RichText(
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  text:  TextSpan(
                    text: 'Opened December 16, 2023 at 10:48 pm\n',style: const TextStyle(
                      color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16
                  ),
                    children: [
                      TextSpan(
                        text: "by  ${AppData.user?.firstName} ${AppData.user?.lastName}",
                        style: const TextStyle(
                          color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16,
                        )
                      )
                    ]
                  ),
                )
              ),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12
                ),
                color: Colors.white
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Text(
                          'Amount Delivered',style: TextStyle(
                          color: Colors.black38,fontWeight: FontWeight.w500
                        ),
                        )),
                        Text('0/\$${0.00}',
                          style: TextStyle(
                              fontSize: 18
                          ),)
                      ],
                    ),
                  ),
                  const Divider(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Text(
                          'Pending Amount',style: TextStyle(
                            color: Colors.black38,fontWeight: FontWeight.w500
                        ),
                        )),
                        Text('0/\$${0.00}',
                          style: TextStyle(
                              fontSize: 18
                          ),)
                      ],
                    ),
                  ),
                  const Divider(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Text(
                          'Opening Amount',style: TextStyle(
                            color: Colors.black38,fontWeight: FontWeight.w500
                        ),
                        )),
                        Text('\$${0.00}',
                          style: TextStyle(
                              fontSize: 18
                          ),)
                      ],
                    ),
                  ),
                  const Divider(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Text(
                          'Cash Traders',style: TextStyle(
                            color: Colors.black38,fontWeight: FontWeight.w500
                        ),
                        )),
                        Text('\$${0.00}',
                          style: TextStyle(
                              fontSize: 18
                          ),)
                      ],
                    ),
                  ),
                  const Divider(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Text(
                          'Expected Drawer',style: TextStyle(
                            color: Colors.black38,fontWeight: FontWeight.w500
                        ),
                        )),
                        Text('\$${0.00}',
                          style: TextStyle(
                              fontSize: 18
                          ),)
                      ],
                    ),
                  ),


                ],
              ),
            ),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Container(
              color: AppStyles.MAIN_COLOR,
              height: 60,
              child: const Center(
                child: Text('Close Shift',style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
            ),),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  color: Colors.white
                ),
                height: 60,
                child: const Center(
                  child: Text('Drop/Payout',style: TextStyle(color: Colors.red,fontSize: 18),),
                ),
              ),)

          ],
        ),
      ),
      //    ),
    );
  }

}