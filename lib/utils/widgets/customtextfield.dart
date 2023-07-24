// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hint;
  final Widget fieldIcon;
  final keyboardType;
  final obscure;
  final obscuringCharacter;
  final TextEditingController controller;
  const CustomTextfield({Key? key, required this.hint, required this.fieldIcon, required this.controller, this.keyboardType, this.obscure, this.obscuringCharacter}) : super(key: key);

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppStyles.SECOND_COLOR),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Flexible(
            flex: 5,
            child: TextFormField(
              obscureText: widget.obscure,
              obscuringCharacter: widget.obscuringCharacter,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              style: const TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                  hintText: widget.hint,
                  hintStyle: const TextStyle(
                    color: AppStyles.COLOR_GREY_LIGHT,
                  ),
                  border: InputBorder.none,),
            ),
          ),
           Flexible(
              flex: 1,
              child:
                widget.fieldIcon,
           )
        ],
      ),
    );
  }
}
