import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
//import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MyBottomNavigation extends StatelessWidget {
  final Function(int position) selectCurrentItem;
  final int selectedIndex;

  const MyBottomNavigation(this.selectCurrentItem, this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppStyles.MAIN_COLOR,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        backgroundColor: Colors.white,
        selectedLabelStyle: TextStyle(

        ),
        onTap: (value) {
          selectCurrentItem(value);
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/delivery-truck.png',
                height: 20,
                color: Colors.grey,
              ),
              label: 'Delivery',
              activeIcon: Image.asset(
                'assets/images/delivery-truck.png',
                height: 24,
                color: AppStyles.MAIN_COLOR,
              )),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/download.png',
                height: 20,
                color: Colors.grey,
              ),
              label: 'Shifts',
              activeIcon: Image.asset(
                'assets/images/download.png',
                height: 24,
                color: AppStyles.MAIN_COLOR,
              )),
        ]);
  }
}
