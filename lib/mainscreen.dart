// ignore_for_file: library_private_types_in_public_api, must_be_immutable
import 'package:flutter/material.dart';
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

  Map<String, WidgetBuilder> _homeScreenRouteBuilder(BuildContext context,
      int index) {
    return {
      '/': (context) {
        return [
          DashboardScreen(_navigateToNext, _openHomeDrawer,online),
          OrderScreen(_navigateToNext, _openHomeDrawer,online,type: 'order',),
          HistoryScreen(_navigateToNext, _openHomeDrawer,online),
          SettingScreen(navigateToNext: _navigateToNext, navigateToRemoveUntil: _navigateToNextRemoveUntil,online: online, openDrawer: _openHomeDrawer,),
        ].elementAt(index);
      },
    };
  }
}


