import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';


class MyAppBar extends StatefulWidget {
  final Widget? leadingWidget;
  final Widget? centerWidget;
  final Widget? trailingWidget;

  const MyAppBar({super.key, this.leadingWidget, this.centerWidget, this.trailingWidget});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      bottom: false,
      child: Container(
            color: AppStyles.MAIN_COLOR,
        height: kToolbarHeight,
        child: Row(
          children: [
            (widget.leadingWidget != null)
                ? widget.leadingWidget!
                : const SizedBox(
              width: 16.0,
            ),
            Expanded(child: (widget.centerWidget != null) ? widget.centerWidget! : const SizedBox()),
            (widget.trailingWidget != null)
                ? widget.trailingWidget!
                : const SizedBox(
              width: 16.0,
            )
          ],
        ),
      ),
    );

  }
}
