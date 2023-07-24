
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class MyBottomNavigation extends StatelessWidget {
  final Function(int position) selectCurrentItem;
  final int selectedIndex;

  const MyBottomNavigation(this.selectCurrentItem, this.selectedIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      selectedColorOpacity: .2,
      backgroundColor: Colors.white,
      margin: const EdgeInsets.all(10),
      onTap: (value) { selectCurrentItem(value);},

      currentIndex: selectedIndex,

      items: [
        SalomonBottomBarItem(
          title: const Text('Dashboard'),
          icon: const Icon(Icons.home_outlined,size: 30,),
          //Image.asset("assets/images/home.png",height: 25,width: 25,),
          unselectedColor: Colors.grey,
          selectedColor: AppStyles.MAIN_COLOR,
        ),
        SalomonBottomBarItem(
          title: const Text('Orders'),
          icon:  const Icon(Icons.list_alt_outlined,size: 30,),
          //Image.asset("assets/images/order.png",height: 25,width: 25,),
          unselectedColor: Colors.grey,
          selectedColor: AppStyles.MAIN_COLOR,
        ),
        SalomonBottomBarItem(
          title: const Text('History'),
          icon:  const Icon(Icons.history,size: 30,),
          //Image.asset("assets/images/history.png",height: 25,width: 25,),
          unselectedColor: Colors.grey,
          selectedColor: AppStyles.MAIN_COLOR,
        ),

        SalomonBottomBarItem(
          title: const Text('settings'),
          icon: const Icon(Icons.settings_outlined,size: 30,),
          //Image.asset("assets/images/settings.png",height: 25,width: 25,),
          unselectedColor: Colors.grey,
          selectedColor: AppStyles.MAIN_COLOR,
        ),

      ],
    );
  }
}
