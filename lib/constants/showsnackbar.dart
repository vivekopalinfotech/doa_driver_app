import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: Colors.red,
          duration: const Duration(milliseconds: 3000),
          content: Center(
              child: Text(message, textScaleFactor: 1,
                textAlign: TextAlign.center,
                style:  const TextStyle(
                    color: Colors.white),))));
}

loader(BuildContext context) {
  Loader.show(context,
      isSafeAreaOverlay: false,
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: const Center(
        child: CircularProgressIndicator(
          color: AppStyles.MAIN_COLOR,
          strokeWidth: 4,
        ),
      ),
      overlayColor: Colors.white);
}