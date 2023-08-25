// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'package:doa_driver_app/bloc/online/online_bloc.dart';
import 'package:doa_driver_app/constants/appstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'screens/history/historyscreen.dart';
import 'screens/dashboard/dashboardscreen.dart';
import 'screens/order/orderscreen.dart';
import 'screens/settings/settingscreen.dart';
import 'utils/widgets/bottonnavigation.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
   bool online = false;
   MainScreen({super.key,});

  @override
  // ignore: no_logic_in_create_state
  _MainScreenState createState() => _MainScreenState(online);
}

class _MainScreenState extends State<MainScreen> {
  bool  online = false;
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  _MainScreenState(this.online);


  @override
  void initState() {
    super.initState();
  }

  final keyCounter = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        } else {
          return isFirstRouteInCurrentTab;
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: SettingScreen(navigateToNext: _navigateToNext,type: 'drawer',online: online, navigateToRemoveUntil: _navigateToNextRemoveUntil,openDrawer: _openHomeDrawer,),
        ),
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AppStyles.MAIN_COLOR,
            leading: Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () => _openHomeDrawer(),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset("assets/images/menu.png",
                      scale: 2.5,
                      color: AppStyles.SECOND_COLOR,
                      fit: BoxFit.none),
                ),
              ),
            ),
            title:  Center(
                child: online == false?const Text(
                  "Offline",
                  // AppLocalizations.of(context)!.translate('app_name')!,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "MontserratBold",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                  ),
                ):
                const Text(
                  "Online",
                  // AppLocalizations.of(context)!.translate('app_name')!,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: "MontserratBold",
                      fontWeight: FontWeight.bold,
                      color: AppStyles.SECOND_COLOR
                  ),
                )),
            actions: [
              Padding( padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FlutterSwitch(
                  //    activeSwitchBorder: Border.all(color: Colors.white),
                  activeColor: AppStyles.SECOND_COLOR,
                  width: 45.0,
                  height: 30.0,
                  valueFontSize: 12.0,
                  toggleSize: 20.0,
                  value: online,
                  borderRadius: 20.0,
                  padding: 5.0,
                  showOnOff: false,
                  onToggle: (val) {
                    BlocProvider.of<OnlineBloc>(context).add(PerformOnline('2', val.toString()));
                    setState(() {
                      online  = val;
                    });
                  },
                ),
              )]
        ),
        body: Stack(
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
        bottomNavigationBar: MyBottomNavigation(_selectCurrentItem, _selectedIndex),
      ),
    );
  }


  void _selectCurrentItem(int position) {
    setState(() {
      _selectedIndex = position;
    });
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _homeScreenRouteBuilder(context, index);
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }

  _navigateToNext(Widget widget) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        )).then((val) => setState(() {}));
  }

  _navigateToNextRemoveUntil(Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => widget,
        ), (route) => false).then((value) => setState((){}));
  }

  _openHomeDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }

  Map<String, WidgetBuilder> _homeScreenRouteBuilder(BuildContext context, int index) {
    return {
      '/': (context) {
        return [
          DashboardScreen(_navigateToNext, _openHomeDrawer,online),
          OrderScreen(_navigateToNext, _openHomeDrawer,online,'',''),
          HistoryScreen(_navigateToNext, _openHomeDrawer,online),
          SettingScreen(navigateToNext: _navigateToNext, navigateToRemoveUntil: _navigateToNextRemoveUntil,online: online, openDrawer: _openHomeDrawer,),
        ].elementAt(index);
      },
    };
  }
}


